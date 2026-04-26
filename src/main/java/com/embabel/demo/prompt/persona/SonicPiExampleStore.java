package com.embabel.demo.prompt.persona;

import com.embabel.demo.model.sonicpi.SonicPiExampleStoreEntry;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import jakarta.annotation.Nonnull;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

// Cheap RAG — or as we like to call it, Chux™ (it's a cheap cloth... gets the job done!)

/**
 * Thread-safe in-memory store for Sonic Pi example metadata. Uses a volatile reference to an
 * immutable list (copy-on-write pattern) so that readers always see a consistent snapshot while
 * the indexer can atomically swap in updated entries.
 *
 * <p>Loads from and persists to {@code store.json} in the {@code sonic-pi-examples/} directory.
 * Creates a timestamped backup before each save.
 */
@Component
public class SonicPiExampleStore {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiExampleStore.class);
    private static final String STORE_FILENAME = "store.json";
    private static final DateTimeFormatter BACKUP_TIMESTAMP = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");

    private final ObjectMapper objectMapper;
    private final Path storeDir;

    private volatile List<SonicPiExampleStoreEntry> entries = List.of();

    public SonicPiExampleStore(@Nonnull SonicPiExamplesProperties properties) {
        this.objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
        this.storeDir = Path.of(properties.storeDir()).toAbsolutePath().normalize();
    }

    /**
     * Returns the current snapshot of all store entries. The returned list is immutable and
     * safe for concurrent reads.
     */
    public @Nonnull List<SonicPiExampleStoreEntry> getEntries() {
        return entries;
    }

    /**
     * Returns the set of relative paths currently in the store.
     */
    public @Nonnull Set<String> getKnownPaths() {
        return entries.stream()
                .map(SonicPiExampleStoreEntry::relativePath)
                .collect(Collectors.toSet());
    }

    /**
     * Atomically replaces the store contents with the given entries and persists to disk.
     * Creates a backup of the existing {@code store.json} before writing.
     *
     * @param updatedEntries the new complete list of entries
     * @param changed        whether the store actually changed (controls backup/save)
     */
    public void updateAndSave(@Nonnull List<SonicPiExampleStoreEntry> updatedEntries, boolean changed) {
        this.entries = List.copyOf(updatedEntries);

        if (!changed) {
            LOG.info("Store unchanged — skipping backup and save");
            return;
        }

        var storePath = storeDir.resolve(STORE_FILENAME);
        backupIfExists(storePath);
        save(storePath);
    }

    /**
     * Loads entries from {@code store.json} on disk. Returns an empty list if the file does not
     * exist (first run).
     */
    public @Nonnull List<SonicPiExampleStoreEntry> loadFromDisk() {
        var storePath = storeDir.resolve(STORE_FILENAME);
        if (!Files.exists(storePath)) {
            LOG.info("No existing store.json found at {} — starting with empty store", storePath);
            return new ArrayList<>();
        }

        try {
            List<SonicPiExampleStoreEntry> loaded = objectMapper.readValue(
                    storePath.toFile(),
                    new TypeReference<>() {
                    });
            LOG.info("Loaded {} entries from {}", loaded.size(), storePath);
            return new ArrayList<>(loaded);
        } catch (IOException e) {
            LOG.warn("Failed to read store.json at {} — starting with empty store", storePath, e);
            return new ArrayList<>();
        }
    }

    private void backupIfExists(@Nonnull Path storePath) {
        if (!Files.exists(storePath)) {
            return;
        }

        var timestamp = LocalDateTime.now().format(BACKUP_TIMESTAMP);
        var backupPath = storeDir.resolve(STORE_FILENAME + ".backup." + timestamp);
        try {
            Files.copy(storePath, backupPath, StandardCopyOption.REPLACE_EXISTING);
            LOG.info("Backed up store.json to {}", backupPath);
        } catch (IOException e) {
            LOG.warn("Failed to create backup at {}", backupPath, e);
        }
    }

    private void save(@Nonnull Path storePath) {
        try {
            objectMapper.writeValue(storePath.toFile(), entries);
            LOG.info("Saved {} entries to {}", entries.size(), storePath);
        } catch (IOException e) {
            LOG.error("Failed to save store.json to {}", storePath, e);
        }
    }
}
