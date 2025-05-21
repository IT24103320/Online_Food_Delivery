package dao;

import model.Review;
import java.io.*;
import java.nio.file.Files;
import java.util.*;

public class ReviewDAO {
    private static final String FILE_PATH = "C:\\Users\\ASUS\\IdeaProjects\\demo\\src\\main\\webapp\\WEB-INF\\review.txt";

    public ReviewDAO() {
        // No context needed
    }

    public void saveReview(Review review) {
        try {
            File file = new File(FILE_PATH);
            file.getParentFile().mkdirs();
            if (!file.exists()) file.createNewFile();

            try (BufferedWriter bw = new BufferedWriter(new FileWriter(file, true))) {
                bw.write(review.getName() + "|" + review.getMessage() + "|" + review.getRating());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<Review> getAllReviews() {
        List<Review> reviews = new ArrayList<>();
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) return reviews;

            try (BufferedReader br = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = br.readLine()) != null) {
                    String[] parts = line.split("\\|");
                    if (parts.length == 3) {
                        String name = parts[0];
                        String message = parts[1];
                        int rating;
                        try {
                            rating = Integer.parseInt(parts[2]);
                        } catch (NumberFormatException e) {
                            rating = 0;
                        }
                        reviews.add(new Review(name, message, rating));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public void deleteReview(int indexToRemove) {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists()) return;

            List<String> lines = new ArrayList<>(Files.readAllLines(file.toPath()));
            if (indexToRemove < 0 || indexToRemove >= lines.size()) return;

            lines.remove(indexToRemove);
            Files.write(file.toPath(), lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
