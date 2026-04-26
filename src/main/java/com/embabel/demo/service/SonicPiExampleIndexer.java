package com.embabel.demo.service;

import com.embabel.agent.api.common.Ai;
import com.embabel.demo.model.sonicpi.SonicPiExampleStoreEntry;
import com.embabel.demo.model.sonicpi.SonicPiMetadata;
import com.embabel.demo.prompt.persona.SonicPiExampleStore;
import com.embabel.demo.prompt.persona.SonicPiExamplesProperties;
import jakarta.annotation.Nonnull;
import jakarta.annotation.Nullable;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Asynchronously indexes Sonic Pi {@code .rb} example files at startup and periodically thereafter.
 * New files are analysed by the LLM to extract {@link SonicPiMetadata}, then added to the
 * {@link SonicPiExampleStore}. Also maintains a file content map for prompt injection.
 *
 * <p>The indexer runs asynchronously on startup so that other controllers and agents are available
 * immediately. Sonic Pi endpoints should check {@link #isReady()} before accepting requests.
 */
@Component
public class SonicPiExampleIndexer {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiExampleIndexer.class);

    private final SonicPiExampleStore store;
    private final Ai ai;
    private final Path storePath;

    private final AtomicBoolean ready = new AtomicBoolean(false);
    private volatile Map<String, String> fileContentMap = Map.of();

    public SonicPiExampleIndexer(@Nonnull SonicPiExampleStore store,
                                 @Nonnull SonicPiExamplesProperties properties,
                                 @Nonnull Ai ai) {
        this.store = store;
        this.ai = ai;
        this.storePath = Path.of(properties.storeDir()).toAbsolutePath().normalize();
    }

    /**
     * Returns {@code true} once the initial indexing has completed and the store is ready for queries.
     */
    public boolean isReady() {
        return ready.get();
    }

    /**
     * Returns the current file content map. Keys are relative paths prefixed with {@code ./},
     * values are full {@code .rb} file contents. The returned map is immutable and safe for
     * concurrent reads.
     */
    public @Nonnull Map<String, String> getFileContentMap() {
        return fileContentMap;
    }

    /**
     * Triggered after the Spring context is fully initialised. Runs the initial index
     * asynchronously so other beans and endpoints are available immediately.
     */
    @Async
    @EventListener(ApplicationReadyEvent.class)
    public void indexOnStartup() {
        LOG.info("Starting async Sonic Pi example indexing...");
        try {
            scanAndIndex();
            ready.set(true);
            LOG.info("Sonic Pi example indexing complete — store is ready");
        } catch (Exception e) {
            LOG.error("Failed to complete initial Sonic Pi example indexing", e);
            ready.set(true);
        }
    }

    /**
     * Periodic rescan for new {@code .rb} files. Only runs after the initial indexing has completed.
     * Rate and initial delay are configurable via {@code sonic-pi.examples.rescan-fixed-rate}
     * and {@code sonic-pi.examples.rescan-initial-delay} in {@code application.yml}.
     */
    @Scheduled(
            fixedRateString = "${sonic-pi.examples.rescan-fixed-rate:300000}",
            initialDelayString = "${sonic-pi.examples.rescan-initial-delay:300000}")
    public void periodicRescan() {
        if (!ready.get()) {
            LOG.debug("Skipping periodic rescan — initial indexing not yet complete");
            return;
        }

        LOG.info("Starting periodic rescan for new Sonic Pi examples...");
        try {
            scanAndIndex();
        } catch (Exception e) {
            LOG.error("Periodic rescan failed", e);
        }
    }

    private void scanAndIndex() {
        List<SonicPiExampleStoreEntry> currentEntries = store.loadFromDisk();
        Set<String> knownPaths = currentEntries.stream()
                .map(SonicPiExampleStoreEntry::relativePath)
                .collect(Collectors.toSet());

        List<Path> rbFiles = scanRbFiles();
        LOG.info("Found {} .rb files under {}", rbFiles.size(), storePath);

        Map<String, String> newContentMap = new ConcurrentHashMap<>();
        List<SonicPiExampleStoreEntry> newEntries = new ArrayList<>();

        for (Path rbFile : rbFiles) {
            String relativePath = storePath.relativize(rbFile).toString();
            String content = readFileContent(rbFile);

            if (content != null) {
                newContentMap.put("./" + relativePath, content);

                if (!knownPaths.contains(relativePath)) {
                    LOG.info("New file detected: {} — extracting metadata via LLM", relativePath);
                    SonicPiMetadata metadata = extractMetadata(relativePath, content);
                    if (metadata != null) {
                        newEntries.add(new SonicPiExampleStoreEntry(relativePath, metadata, true));
                    }
                }
            }
        }

        fileContentMap = Map.copyOf(newContentMap);
        LOG.info("File content map updated with {} entries", newContentMap.size());

        boolean changed = !newEntries.isEmpty();
        if (changed) {
            currentEntries.addAll(newEntries);
            LOG.info("Added {} new entries to store (total: {})", newEntries.size(), currentEntries.size());
        }

        store.updateAndSave(currentEntries, changed);
    }

    private @Nonnull List<Path> scanRbFiles() {
        if (!Files.isDirectory(storePath)) {
            LOG.warn("Store directory does not exist: {}", storePath);
            return List.of();
        }

        try (Stream<Path> walk = Files.walk(storePath)) {
            return walk.filter(Files::isRegularFile)
                    .filter(p -> p.toString().endsWith(".rb"))
                    .toList();
        } catch (IOException e) {
            LOG.error("Failed to scan directory: {}", storePath, e);
            return List.of();
        }
    }

    private @Nullable String readFileContent(@Nonnull Path path) {
        try {
            return Files.readString(path);
        } catch (IOException e) {
            LOG.warn("Failed to read file: {}", path, e);
            return null;
        }
    }

    private @Nullable SonicPiMetadata extractMetadata(@Nonnull String relativePath, @Nonnull String content) {
        try {
            return ai.withDefaultLlm()
                    .withTemplate("sonicpi/extract-example-metadata.jinja")
                    .createObject(SonicPiMetadata.class, Map.of(
                            "scriptContent", content,
                            "relativePath", relativePath));
        } catch (Exception e) {
            LOG.error("LLM metadata extraction failed for {}", relativePath, e);
            return null;
        }
    }
}
