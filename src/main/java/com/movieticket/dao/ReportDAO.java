package com.movieticket.dao;

import com.movieticket.model.Report;
import com.movieticket.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalBookings() {
        String sql = "SELECT COUNT(*) FROM bookings WHERE status = 'confirmed'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(amount), 0) FROM payments WHERE status = 'success'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0.0;
    }

    public int getTotalMovies() {
        String sql = "SELECT COUNT(*) FROM movies WHERE status = 'now_showing'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public List<Report> getMonthlyBookings() {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT DATE_FORMAT(MIN(booking_date), '%M %Y') AS label, " +
                "COUNT(*) AS total_bookings, " +
                "COALESCE(SUM(total_amount), 0) AS revenue " +
                "FROM bookings " +
                "WHERE status = 'confirmed' " +
                "GROUP BY DATE_FORMAT(booking_date, '%Y-%m') " +
                "ORDER BY DATE_FORMAT(booking_date, '%Y-%m') DESC " +
                "LIMIT 12";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Report(
                        rs.getString("label"),
                        rs.getInt("total_bookings"),
                        rs.getDouble("revenue")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Report> getMoviePopularity() {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT m.title AS label, " +
                "COUNT(b.id) AS total_bookings, " +
                "COALESCE(SUM(b.total_amount), 0) AS revenue " +
                "FROM movies m " +
                "JOIN shows s ON m.id = s.movie_id " +
                "JOIN bookings b ON s.id = b.show_id " +
                "WHERE b.status = 'confirmed' " +
                "GROUP BY m.id, m.title " +
                "ORDER BY total_bookings DESC " +
                "LIMIT 10";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Report(
                        rs.getString("label"),
                        rs.getInt("total_bookings"),
                        rs.getDouble("revenue")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Report> getRevenueByPaymentMethod() {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT payment_method AS label, " +
                "COUNT(*) AS total_bookings, " +
                "SUM(amount) AS revenue " +
                "FROM payments " +
                "WHERE status = 'success' " +
                "GROUP BY payment_method";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(new Report(
                        rs.getString("label"),
                        rs.getInt("total_bookings"),
                        rs.getDouble("revenue")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}