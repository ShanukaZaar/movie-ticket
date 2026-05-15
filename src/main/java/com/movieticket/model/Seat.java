package com.movieticket.model;

public class Seat {
    private int id;
    private int screenId;
    private String seatNumber;
    private String seatType;
    private boolean booked;

    public Seat() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getScreenId() { return screenId; }
    public void setScreenId(int screenId) { this.screenId = screenId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public String getSeatType() { return seatType; }
    public void setSeatType(String seatType) { this.seatType = seatType; }

    public boolean isBooked() { return booked; }
    public void setBooked(boolean booked) { this.booked = booked; }
}