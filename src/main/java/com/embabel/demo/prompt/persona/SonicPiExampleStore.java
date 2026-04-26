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
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

// Cheap RAG — or as we like to call it, Chux™ (it's a cheap cloth... gets the job done!)

/**
 * Thread-safe in-memory store for Sonic Pi example metadata. Uses a volatile reference to an
 * immutable list (copy-on-write pattern) so that readers always see a consistent snapshot while
 * the indexer can atomically swap in updated entries.
 *
 * <p>Loads from and persists to a {@code store.json} file. By default this lives inside the
 * examples directory, but a separate writable path can be configured via {@code storeFile}
 * for read-only environments (e.g. Docker volumes). Creates a timestamped backup before each save.
 */
@Component
public class SonicPiExampleStore {

    private static final Logger LOG = LoggerFactory.getLogger(SonicPiExampleStore.class);
    private static final String STORE_FILENAME = "store.json";
    private static final DateTimeFormatter BACKUP_TIMESTAMP = DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss");

    private final ObjectMapper objectMapper;
    private final Path storeFilePath;

    private volatile List<SonicPiExampleStoreEntry> entries = List.of();

    public SonicPiExampleStore(@Nonnull SonicPiExamplesProperties properties) {
        this.objectMapper = new ObjectMapper().enable(SerializationFeature.INDENT_OUTPUT);
        this.storeFilePath = resolveStoreFilePath(properties);
        LOG.info("Store file path: {}", storeFilePath);
    }

    private static @Nonnull Path resolveStoreFilePath(@Nonnull SonicPiExamplesProperties properties) {
        if (properties.storeFile() != null && !properties.storeFile().isBlank()) {
            return Path.of(properties.storeFile()).toAbsolutePath().normalize();
        }
        return Path.of(properties.storeDir()).toAbsolutePath().normalize().resolve(STORE_FILENAME);
    }

    /**
     * Returns the current snapshot of all store entries. The returned list is immutable and
     * safe for concurrent reads.
     */
    public @Nonnull List<SonicPiExampleStoreEntry> getEntries() {
        return entries;
    }

    /**
     * Atomically replaces the store contents with the given entries and persists to disk.
     * Creates a backup of the existing {@code store.json} before writing.
     *
     * @param updatedEntries the new complete list of entries
     * @param changed        whether the store actually changed (controls backup/save)
     */
    public void updateAndSave(@Nonnull List<SonicPiExampleStoreEntry> updatedEntries, boolean changed) {
        entries = List.copyOf(updatedEntries);

        if (!changed) {
            LOG.info("Store unchanged — skipping backup and save");
            return;
        }

        backupIfExists(storeFilePath);
        save(storeFilePath);
    }

    /**
     * Loads entries from {@code store.json} on disk. Returns an empty list if the file does not
     * exist (first run).
     */
    public @Nonnull List<SonicPiExampleStoreEntry> loadFromDisk() {
        if (!Files.exists(storeFilePath)) {
            LOG.info("No existing store.json found at {} — starting with empty store", storeFilePath);
            return new ArrayList<>();
        }

        try {
            List<SonicPiExampleStoreEntry> loaded = objectMapper.readValue(
                    storeFilePath.toFile(),
                    new TypeReference<>() {
                    });
            LOG.info("Loaded {} entries from {}", loaded.size(), storeFilePath);
            return new ArrayList<>(loaded);
        } catch (IOException e) {
            LOG.warn("Failed to read store.json at {} — starting with empty store", storeFilePath, e);
            return new ArrayList<>();
        }
    }

    private void backupIfExists(@Nonnull Path fileToBackup) {
        if (!Files.exists(fileToBackup)) {
            return;
        }

        var timestamp = LocalDateTime.now().format(BACKUP_TIMESTAMP);
        var backupFile = fileToBackup.resolveSibling(STORE_FILENAME + ".backup." + timestamp);
        try {
            Files.copy(fileToBackup, backupFile, StandardCopyOption.REPLACE_EXISTING);
            LOG.info("Backed up store.json to {}", backupFile);
        } catch (IOException e) {
            LOG.warn("Failed to create backup at {}", backupFile, e);
        }
    }

    private void save(@Nonnull Path targetFile) {
        try {
            Files.createDirectories(targetFile.getParent());
            objectMapper.writeValue(targetFile.toFile(), entries);
            LOG.info("Saved {} entries to {}", entries.size(), targetFile);
        } catch (IOException e) {
            LOG.error("Failed to save store.json to {}", targetFile, e);
        }
    }
}
