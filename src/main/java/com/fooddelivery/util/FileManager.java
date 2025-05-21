package com.fooddelivery.util;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FileManager {
    private static final Logger LOGGER = Logger.getLogger(FileManager.class.getName());
    private final Path filePath;

    public FileManager(String filePath) {
        this.filePath = Paths.get(filePath);
        ensureDirectoryExists();
    }

    private void ensureDirectoryExists() {
        try {
            Path parentDir = filePath.getParent();
            if (parentDir != null && !Files.exists(parentDir)) {
                Files.createDirectories(parentDir);
                LOGGER.info("Created directory: " + parentDir);
            }
            // Ensure file exists
            if (!Files.exists(filePath)) {
                Files.createFile(filePath);
                LOGGER.info("Created file: " + filePath);
            }
            // Check if file is writable
            if (!Files.isWritable(filePath)) {
                LOGGER.severe("File is not writable: " + filePath);
                throw new IOException("File is not writable: " + filePath);
            }
        } catch (IOException e) {
            LOGGER.severe("Error initializing file: " + filePath + " - " + e.getMessage());
            throw new RuntimeException("Failed to initialize file: " + filePath, e);
        }
    }

    public List<String> readAllRecords() {
        try {
            if (!Files.exists(filePath)) {
                LOGGER.warning("File does not exist: " + filePath + ". Creating new file.");
                Files.createFile(filePath);
                return new ArrayList<>();
            }
            List<String> records = Files.readAllLines(filePath);
            LOGGER.info("Read " + records.size() + " records from " + filePath);
            return records;
        } catch (IOException e) {
            LOGGER.severe("Error reading file: " + filePath + " - " + e.getMessage());
            throw new RuntimeException("Failed to read file: " + filePath, e);
        }
    }

    public void writeAllRecords(List<String> records) {
        try {
            ensureDirectoryExists();
            Files.write(filePath, records, StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING);
            LOGGER.info("Successfully wrote " + records.size() + " records to " + filePath);
        } catch (IOException e) {
            LOGGER.severe("Error writing to file: " + filePath + " - " + e.getMessage());
            throw new RuntimeException("Failed to write to file: " + filePath, e);
        }
    }
}