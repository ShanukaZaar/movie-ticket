package com.movieticket.dao;

import com.movieticket.util.DBConnection;

import java.sql.*;
import java.util.*;

public class ReportDAO {

    // Get monthly revenue
    public double getMonthlyRevenue(int year, int month) throws SQLException {
        String sql = "SELECT COALESCE(SUM(p.amount), 0) as revenue " +
                "FROM payments p " +
                "WHERE YEAR(p.payment_date) = ? " +
                "AND MONTH(p.payment_date) = ? " +
                "AND p.status = 'success'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getDouble("revenue");
        }
        return 0.0;
    }

    // Get total bookings for month
    public int getMonthlyBookings(int year, int month) throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM bookings " +
                "WHERE YEAR(booking_date) = ? AND MONTH(booking_date) = ? " +
                "AND status != 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt("total");
        }
        return 0;
    }

    // Get total cancellations for month
    public int getMonthlyCancellations(int year, int month) throws SQLException {
        String sql = "SELECT COUNT(*) as total FROM bookings " +
                "WHERE YEAR(booking_date) = ? AND MONTH(booking_date) = ? " +
                "AND status = 'cancelled'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getInt("total");
        }
        return 0;
    }

    // Get total cancellation fees for month
    public double getMonthlyCancellationFees(int year, int month) throws SQLException {
        String sql = "SELECT COALESCE(SUM(cancellation_fee), 0) as fees " +
                "FROM payments " +
                "WHERE YEAR(payment_date) = ? AND MONTH(payment_date) = ? " +
                "AND status = 'refunded'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getDouble("fees");
        }
        return 0.0;
    }

    // Get revenue per movie for month
    public List<Map<String, Object>> getRevenuePerMovie(int year, int month)
            throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT m.title, " +
                "COUNT(b.id) as bookings, " +
                "COALESCE(SUM(p.amount), 0) as revenue, " +
                "COUNT(CASE WHEN b.status = 'cancelled' THEN 1 END) as cancellations, " +
                "COALESCE(SUM(CASE WHEN b.status = 'cancelled' THEN p.cancellation_fee END), 0) as cancel_fees " +
                "FROM movies m " +
                "LEFT JOIN shows s ON m.id = s.movie_id " +
                "LEFT JOIN bookings b ON s.id = b.show_id " +
                "AND YEAR(b.booking_date) = ? AND MONTH(b.booking_date) = ? " +
                "LEFT JOIN payments p ON b.id = p.booking_id " +
                "GROUP BY m.id, m.title " +
                "ORDER BY revenue DESC";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("title", rs.getString("title"));
                row.put("bookings", rs.getInt("bookings"));
                row.put("revenue", rs.getDouble("revenue"));
                row.put("cancellations", rs.getInt("cancellations"));
                row.put("cancelFees", rs.getDouble("cancel_fees"));
                list.add(row);
            }
        }
        return list;
    }

    // Get daily revenue for chart (current month)
    public List<Map<String, Object>> getDailyRevenue(int year, int month)
            throws SQLException {
        List<Map<String, Object>> list = new ArrayList<>();
        String sql = "SELECT DAY(payment_date) as day, " +
                "COALESCE(SUM(amount), 0) as revenue " +
                "FROM payments " +
                "WHERE YEAR(payment_date) = ? AND MONTH(payment_date) = ? " +
                "AND status = 'success' " +
                "GROUP BY DAY(payment_date) " +
                "ORDER BY day";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new LinkedHashMap<>();
                row.put("day", rs.getInt("day"));
                row.put("revenue", rs.getDouble("revenue"));
                list.add(row);
            }
        }
        return list;
    }

    // Get most booked movie
    public String getMostBookedMovie(int year, int month) throws SQLException {
        String sql = "SELECT m.title, COUNT(b.id) as total " +
                "FROM bookings b " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "WHERE YEAR(b.booking_date) = ? AND MONTH(b.booking_date) = ? " +
                "AND b.status != 'cancelled' " +
                "GROUP BY m.id, m.title " +
                "ORDER BY total DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getString("title");
        }
        return "No data";
    }

    // Get total refunds for month
    public double getMonthlyRefunds(int year, int month) throws SQLException {
        String sql = "SELECT COALESCE(SUM(refund_amount), 0) as refunds " +
                "FROM payments " +
                "WHERE YEAR(payment_date) = ? AND MONTH(payment_date) = ? " +
                "AND status = 'refunded'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, year);
            ps.setInt(2, month);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return rs.getDouble("refunds");
        }
        return 0.0;
    }
}