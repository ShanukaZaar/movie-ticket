package com.movieticket.model;

public class Screen {
    private int id;
    private int theaterId;
    private String screenName;
    private int totalSeats;
    private String theaterName;

    public Screen() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getTheaterId() { return theaterId; }
    public void setTheaterId(int theaterId) { this.theaterId = theaterId; }

    public String getScreenName() { return screenName; }
    public void setScreenName(String screenName) { this.screenName = screenName; }

    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }

    public String getTheaterName() { return theaterName; }
    public void setTheaterName(String theaterName) { this.theaterName = theaterName; }
}