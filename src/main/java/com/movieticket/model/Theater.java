package com.movieticket.model;

public class Theater {
    private int id;
    private String name;
    private String location;
    private int totalScreens;

    public Theater() {}

    public Theater(int id, String name, String location, int totalScreens) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.totalScreens = totalScreens;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public int getTotalScreens() { return totalScreens; }
    public void setTotalScreens(int totalScreens) { this.totalScreens = totalScreens; }
}