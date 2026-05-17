package com.movieticket.dao;

import com.movieticket.model.Booking;
import com.movieticket.model.Seat;
import com.movieticket.model.Show;
import com.movieticket.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // Get all shows for a movie
    public List<Show> getShowsByMovie(int movieId) throws SQLException {
        List<Show> shows = new ArrayList<>();
        String sql = "SELECT s.*, m.title as movie_title, m.poster_url, m.poster_path, " +
                "sc.screen_name, t.name as theater_name " +
                "FROM shows s " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN screens sc ON s.screen_id = sc.id " +
                "JOIN theaters t ON sc.theater_id = t.id " +
                "WHERE s.movie_id = ? AND s.show_date >= CURDATE() " +
                "ORDER BY s.show_date, s.show_time";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
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
                shows.add(show);
            }
        }
        return shows;
    }

    // Get show by ID
    public Show getShowById(int showId) throws SQLException {
        String sql = "SELECT s.*, m.title as movie_title, m.poster_url, m.poster_path, " +
                "sc.screen_name, t.name as theater_name " +
                "FROM shows s " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN screens sc ON s.screen_id = sc.id " +
                "JOIN theaters t ON sc.theater_id = t.id " +
                "WHERE s.id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
                return show;
            }
        }
        return null;
    }

    // Get all seats for a show with booked status
    public List<Seat> getSeatsByShow(int showId, int screenId) throws SQLException {
        List<Seat> seats = new ArrayList<>();
        String sql = "SELECT s.*, " +
                "CASE WHEN bs.seat_id IS NOT NULL THEN 1 ELSE 0 END as is_booked " +
                "FROM seats s " +
                "LEFT JOIN booking_seats bs ON s.id = bs.seat_id " +
                "LEFT JOIN bookings b ON bs.booking_id = b.id AND b.show_id = ? AND b.status != 'cancelled' " +
                "WHERE s.screen_id = ? " +
                "ORDER BY s.seat_number";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, showId);
            ps.setInt(2, screenId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat();
                seat.setId(rs.getInt("id"));
                seat.setScreenId(rs.getInt("screen_id"));
                seat.setSeatNumber(rs.getString("seat_number"));
                seat.setSeatType(rs.getString("seat_type"));
                seat.setBooked(rs.getInt("is_booked") == 1);
                seats.add(seat);
            }
        }
        return seats;
    }

    // Create a booking
    public int createBooking(int userId, int showId, double totalAmount) throws SQLException {
        String sql = "INSERT INTO bookings (user_id, show_id, total_amount, status) VALUES (?, ?, ?, 'confirmed')";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, userId);
            ps.setInt(2, showId);
            ps.setDouble(3, totalAmount);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next())
                return rs.getInt(1);
        }
        return -1;
    }

    // Add seats to booking
    public void addBookingSeats(int bookingId, List<Integer> seatIds) throws SQLException {
        String sql = "INSERT INTO booking_seats (booking_id, seat_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            for (int seatId : seatIds) {
                ps.setInt(1, bookingId);
                ps.setInt(2, seatId);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    // Get bookings by user
    public List<Booking> getBookingsByUser(int userId) throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, m.title as movie_title, t.name as theater_name, " +
                "s.show_date, s.show_time, sc.screen_name " +
                "FROM bookings b " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN screens sc ON s.screen_id = sc.id " +
                "JOIN theaters t ON sc.theater_id = t.id " +
                "WHERE b.user_id = ? " +
                "ORDER BY b.booking_date DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setShowId(rs.getInt("show_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setTotalAmount(rs.getDouble("total_amount"));
                booking.setStatus(rs.getString("status"));
                booking.setMovieTitle(rs.getString("movie_title"));
                booking.setTheaterName(rs.getString("theater_name"));
                booking.setShowDate(rs.getString("show_date"));
                booking.setShowTime(rs.getString("show_time"));
                booking.setScreenName(rs.getString("screen_name"));
                bookings.add(booking);
            }
        }
        return bookings;
    }

    // Get booking by ID with seat numbers
    public Booking getBookingById(int bookingId) throws SQLException {
        String sql = "SELECT b.*, m.title as movie_title, t.name as theater_name, " +
                "s.show_date, s.show_time, sc.screen_name " +
                "FROM bookings b " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN screens sc ON s.screen_id = sc.id " +
                "JOIN theaters t ON sc.theater_id = t.id " +
                "WHERE b.id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setShowId(rs.getInt("show_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setTotalAmount(rs.getDouble("total_amount"));
                booking.setStatus(rs.getString("status"));
                booking.setMovieTitle(rs.getString("movie_title"));
                booking.setTheaterName(rs.getString("theater_name"));
                booking.setShowDate(rs.getString("show_date"));
                booking.setShowTime(rs.getString("show_time"));
                booking.setScreenName(rs.getString("screen_name"));

                List<String> seatNumbers = getSeatNumbersByBooking(bookingId);
                booking.setSeatNumbers(seatNumbers);
                return booking;
            }
        }
        return null;
    }

    // Get seat numbers for a booking
    public List<String> getSeatNumbersByBooking(int bookingId) throws SQLException {
        List<String> seatNumbers = new ArrayList<>();
        String sql = "SELECT s.seat_number FROM seats s " +
                "JOIN booking_seats bs ON s.id = bs.seat_id " +
                "WHERE bs.booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                seatNumbers.add(rs.getString("seat_number"));
            }
        }
        return seatNumbers;
    }

    // Cancel a booking
    public boolean cancelBooking(int bookingId) throws SQLException {
        String sql = "UPDATE bookings SET status = 'cancelled' WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    // Update booking status to paid (added from payment component)
    public boolean updateBookingStatusToPaid(int bookingId) throws SQLException {
        String sql = "UPDATE bookings SET status = 'confirmed' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    // Get booking amount
    public double getBookingAmount(int bookingId) throws SQLException {
        String sql = "SELECT total_amount FROM bookings WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble("total_amount");
            }
        }
        return 0.0;
    }

    // Get all bookings (admin)
    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, m.title as movie_title, t.name as theater_name, " +
                "s.show_date, s.show_time, sc.screen_name " +
                "FROM bookings b " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "JOIN screens sc ON s.screen_id = sc.id " +
                "JOIN theaters t ON sc.theater_id = t.id " +
                "ORDER BY b.booking_date DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setId(rs.getInt("id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setShowId(rs.getInt("show_id"));
                booking.setBookingDate(rs.getTimestamp("booking_date"));
                booking.setTotalAmount(rs.getDouble("total_amount"));
                booking.setStatus(rs.getString("status"));
                booking.setMovieTitle(rs.getString("movie_title"));
                booking.setTheaterName(rs.getString("theater_name"));
                booking.setShowDate(rs.getString("show_date"));
                booking.setShowTime(rs.getString("show_time"));
                booking.setScreenName(rs.getString("screen_name"));
                bookings.add(booking);
            }
        }
        return bookings;
    }
}