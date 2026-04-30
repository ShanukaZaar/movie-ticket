package com.movieticket.dao;

import com.movieticket.model.Movie;
import com.movieticket.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {

    // Get ALL movies
    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM movies";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                movies.add(mapRow(rs));
            }
        }
        return movies;
    }

    // Get ONE movie by ID
    public Movie getMovieById(int id) throws SQLException {
        String sql = "SELECT * FROM movies WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        }
        return null;
    }

    // Search movies by title
    public List<Movie> searchMovies(String keyword) throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT * FROM movies WHERE title LIKE ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                movies.add(mapRow(rs));
            }
        }
        return movies;
    }

    // Add a new movie
    public boolean addMovie(Movie movie) throws SQLException {
        String sql = "INSERT INTO movies (title, genre, duration, language, release_date, description, poster_url, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getGenre());
            ps.setInt(3, movie.getDuration());
            ps.setString(4, movie.getLanguage());
            ps.setDate(5, movie.getReleaseDate());
            ps.setString(6, movie.getDescription());
            ps.setString(7, movie.getPosterUrl());
            ps.setString(8, movie.getStatus());

            return ps.executeUpdate() > 0;
        }
    }

    // Update a movie
    public boolean updateMovie(Movie movie) throws SQLException {
        String sql = "UPDATE movies SET title=?, genre=?, duration=?, language=?, release_date=?, description=?, poster_url=?, status=? WHERE id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, movie.getTitle());
            ps.setString(2, movie.getGenre());
            ps.setInt(3, movie.getDuration());
            ps.setString(4, movie.getLanguage());
            ps.setDate(5, movie.getReleaseDate());
            ps.setString(6, movie.getDescription());
            ps.setString(7, movie.getPosterUrl());
            ps.setString(8, movie.getStatus());
            ps.setInt(9, movie.getId());

            return ps.executeUpdate() > 0;
        }
    }

    // Delete a movie
    public boolean deleteMovie(int id) throws SQLException {
        String sql = "DELETE FROM movies WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // Helper: convert a database row → Movie object
    private Movie mapRow(ResultSet rs) throws SQLException {
        return new Movie(
            rs.getInt("id"),
            rs.getString("title"),
            rs.getString("genre"),
            rs.getInt("duration"),
            rs.getString("language"),
            rs.getDate("release_date"),
            rs.getString("description"),
            rs.getString("poster_url"),
            rs.getString("status")
        );
    }
}