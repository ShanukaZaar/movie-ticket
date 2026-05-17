package com.movieticket.model;

public class Show {
    private int id;
    private int movieId;
    private int screenId;
    private String showDate;
    private String showTime;
    private double price;

    // Extra fields for display
    private String movieTitle;
    private String theaterName;
    private String screenName;
    private String moviePosterUrl;
    private String moviePosterPath;
    private int theaterId;

    public Show() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public int getScreenId() { return screenId; }
    public void setScreenId(int screenId) { this.screenId = screenId; }

    public String getShowDate() { return showDate; }
    public void setShowDate(String showDate) { this.showDate = showDate; }

    public String getShowTime() { return showTime; }
    public void setShowTime(String showTime) { this.showTime = showTime; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getMovieTitle() { return movieTitle; }
    public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }

    public String getTheaterName() { return theaterName; }
    public void setTheaterName(String theaterName) { this.theaterName = theaterName; }

    public String getScreenName() { return screenName; }
    public void setScreenName(String screenName) { this.screenName = screenName; }

    public String getMoviePosterUrl() { return moviePosterUrl; }
    public void setMoviePosterUrl(String moviePosterUrl) { this.moviePosterUrl = moviePosterUrl; }

    public String getMoviePosterPath() { return moviePosterPath; }
    public void setMoviePosterPath(String moviePosterPath) { this.moviePosterPath = moviePosterPath; }

    public int getTheaterId() { return theaterId; }
    public void setTheaterId(int theaterId) { this.theaterId = theaterId; }
}