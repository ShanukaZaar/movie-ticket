package com.movieticket.dao;

import com.movieticket.model.Screen;
import com.movieticket.model.Show;
import com.movieticket.model.Theater;
import com.movieticket.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TheaterDAO {

    // ==================== THEATER METHODS ====================

    public List<Theater> getAllTheaters() throws SQLException {
        List<Theater> theaters = new ArrayList<>();
        String sql = "SELECT * FROM theaters ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                theaters.add(mapTheaterRow(rs));
            }
        }
        return theaters;
    }

    public Theater getTheaterById(int id) throws SQLException {
        String sql = "SELECT * FROM theaters WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapTheaterRow(rs);
        }
        return null;
    }

    public boolean addTheater(Theater theater) throws SQLException {
        String sql = "INSERT INTO theaters (name, location, total_screens) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, theater.getName());
            ps.setString(2, theater.getLocation());
            ps.setInt(3, theater.getTotalScreens());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateTheater(Theater theater) throws SQLException {
        String sql = "UPDATE theaters SET name=?, location=?, total_screens=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, theater.getName());
            ps.setString(2, theater.getLocation());
            ps.setInt(3, theater.getTotalScreens());
            ps.setInt(4, theater.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteTheater(int id) throws SQLException {
        String sql = "DELETE FROM theaters WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ==================== SCREEN METHODS ====================

    public List<Screen> getAllScreens() throws SQLException {
        List<Screen> screens = new ArrayList<>();
        String sql = "SELECT s.*, t.name as theater_name FROM screens s " +
                     "JOIN theaters t ON s.theater_id = t.id ORDER BY t.name, s.screen_name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                screens.add(mapScreenRow(rs));
            }
        }
        return screens;
    }

    public List<Screen> getScreensByTheater(int theaterId) throws SQLException {
        List<Screen> screens = new ArrayList<>();
        String sql = "SELECT s.*, t.name as theater_name FROM screens s " +
                     "JOIN theaters t ON s.theater_id = t.id WHERE s.theater_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, theaterId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                screens.add(mapScreenRow(rs));
            }
        }
        return screens;
    }

    public Screen getScreenById(int id) throws SQLException {
        String sql = "SELECT s.*, t.name as theater_name FROM screens s " +
                     "JOIN theaters t ON s.theater_id = t.id WHERE s.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapScreenRow(rs);
        }
        return null;
    }

    public boolean addScreen(Screen screen) throws SQLException {
        String sql = "INSERT INTO screens (theater_id, screen_name, total_seats) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, screen.getTheaterId());
            ps.setString(2, screen.getScreenName());
            ps.setInt(3, screen.getTotalSeats());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateScreen(Screen screen) throws SQLException {
        String sql = "UPDATE screens SET theater_id=?, screen_name=?, total_seats=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, screen.getTheaterId());
            ps.setString(2, screen.getScreenName());
            ps.setInt(3, screen.getTotalSeats());
            ps.setInt(4, screen.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteScreen(int id) throws SQLException {
        String sql = "DELETE FROM screens WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ==================== SHOW METHODS ====================

    public List<Show> getAllShows() throws SQLException {
        List<Show> shows = new ArrayList<>();
        String sql = "SELECT s.*, m.title as movie_title, m.poster_url, m.poster_path, " +
                     "sc.screen_name, t.name as theater_name, t.id as theater_id " +
                     "FROM shows s " +
                     "JOIN movies m ON s.movie_id = m.id " +
                     "JOIN screens sc ON s.screen_id = sc.id " +
                     "JOIN theaters t ON sc.theater_id = t.id " +
                     "ORDER BY s.show_date, s.show_time";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                shows.add(mapShowRow(rs));
            }
        }
        return shows;
    }

    public Show getShowById(int id) throws SQLException {
        String sql = "SELECT s.*, m.title as movie_title, m.poster_url, m.poster_path, " +
                     "sc.screen_name, t.name as theater_name, t.id as theater_id " +
                     "FROM shows s " +
                     "JOIN movies m ON s.movie_id = m.id " +
                     "JOIN screens sc ON s.screen_id = sc.id " +
                     "JOIN theaters t ON sc.theater_id = t.id " +
                     "WHERE s.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapShowRow(rs);
        }
        return null;
    }

    public boolean addShow(Show show) throws SQLException {
        String sql = "INSERT INTO shows (movie_id, screen_id, show_date, show_time, price) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, show.getMovieId());
            ps.setInt(2, show.getScreenId());
            ps.setString(3, show.getShowDate());
            ps.setString(4, show.getShowTime());
            ps.setDouble(5, show.getPrice());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateShow(Show show) throws SQLException {
        String sql = "UPDATE shows SET movie_id=?, screen_id=?, show_date=?, show_time=?, price=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, show.getMovieId());
            ps.setInt(2, show.getScreenId());
            ps.setString(3, show.getShowDate());
            ps.setString(4, show.getShowTime());
            ps.setDouble(5, show.getPrice());
            ps.setInt(6, show.getId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteShow(int id) throws SQLException {
        String sql = "DELETE FROM shows WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    // ==================== HELPER METHODS ====================

    private Theater mapTheaterRow(ResultSet rs) throws SQLException {
        return new Theater(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getString("location"),
            rs.getInt("total_screens")
        );
    }

    private Screen mapScreenRow(ResultSet rs) throws SQLException {
        Screen screen = new Screen();
        screen.setId(rs.getInt("id"));
        screen.setTheaterId(rs.getInt("theater_id"));
        screen.setScreenName(rs.getString("screen_name"));
        screen.setTotalSeats(rs.getInt("total_seats"));
        screen.setTheaterName(rs.getString("theater_name"));
        return screen;
    }

    private Show mapShowRow(ResultSet rs) throws SQLException {
        Show show = new Show();
        show.setId(rs.getInt("id"));
        show.setMovieId(rs.getInt("movie_id"));
        show.setScreenId(rs.getInt("screen_id"));
        show.setShowDate(rs.getString("show_date"));
        show.setShowTime(rs.getString("show_time"));
        show.setPrice(rs.getDouble("price"));
        show.setMovieTitle(rs.getString("movie_title"));
        show.setScreenName(rs.getString("screen_name"));
        show.setTheaterName(rs.getString("theater_name"));
        show.setMoviePosterUrl(rs.getString("poster_url"));
        show.setMoviePosterPath(rs.getString("poster_path"));
        show.setTheaterId(rs.getInt("theater_id"));
        return show;
    }
}