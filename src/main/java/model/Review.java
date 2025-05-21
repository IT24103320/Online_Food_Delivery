package model;

public class Review {
    private String name;
    private String message;
    private int rating;

    public Review(String name, String message, int rating) {
        this.name = name;
        this.message = message;
        this.rating = rating;
    }

    public String getName() { return name; }
    public String getMessage() { return message; }
    public int getRating() { return rating; }

    public void setName(String name) { this.name = name; }
    public void setMessage(String message) { this.message = message; }
    public void setRating(int rating) { this.rating = rating; }
}
