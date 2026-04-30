package com.movieticket.model;

import java.sql.Date;

public class Movie {
    private int id;
    private String title;
    private String genre;
    private int duration;
    private String language;
    private Date releaseDate;
    private String description;
    private String posterUrl;
    private String status;

    // --- Constructors ---
    public Movie() {}

    public Movie(int id, String title, String genre, int duration,
                 String language, Date releaseDate, String description,
                 String posterUrl, String status) {
        this.id = id;
        this.title = title;
        this.genre = genre;
        this.duration = duration;
        this.language = language;
        this.releaseDate = releaseDate;
        this.description = description;
        this.posterUrl = posterUrl;
        this.status = status;
    }

    // --- Getters and Setters ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }

    public Date getReleaseDate() { return releaseDate; }
    public void setReleaseDate(Date releaseDate) { this.releaseDate = releaseDate; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getPosterUrl() { return posterUrl; }
    public void setPosterUrl(String posterUrl) { this.posterUrl = posterUrl; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}