package com.movieticket.model;

public class Report {
    private String label;      // e.g., "January", "Action", movie title
    private int bookingCount;
    private double revenue;

    // Constructor
    public Report(String label, int bookingCount, double revenue) {
        this.label = label;
        this.bookingCount = bookingCount;
        this.revenue = revenue;
    }

    // Getters
    public String getLabel() { return label; }
    public int getBookingCount() { return bookingCount; }
    public double getRevenue() { return revenue; }
}