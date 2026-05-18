package com.movieticket.dao;

import com.movieticket.model.Payment;
import com.movieticket.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {

    // Create a new payment
    public boolean createPayment(int bookingId, double amount,
            String paymentMethod, String cardHolderName) {
        String sql = "INSERT INTO payments (booking_id, amount, payment_method, " +
                "status, card_holder_name, transaction_id) VALUES (?, ?, ?, 'success', ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ps.setDouble(2, amount);
            ps.setString(3, paymentMethod);
            ps.setString(4, cardHolderName);
            ps.setString(5, generateTransactionId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all payments
    public List<Payment> getAllPayments() {
        List<Payment> payments = new ArrayList<>();
        String sql = "SELECT p.*, b.user_id, m.title as movie_title " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.id " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "ORDER BY p.payment_date DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                payments.add(mapPayment(rs));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return payments;
    }

    // Get payment by ID
    public Payment getPaymentById(int id) {
        String sql = "SELECT p.*, m.title as movie_title " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.id " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "WHERE p.id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapPayment(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get payment by booking ID
    public Payment getPaymentByBookingId(int bookingId) {
        String sql = "SELECT p.*, m.title as movie_title " +
                "FROM payments p " +
                "JOIN bookings b ON p.booking_id = b.id " +
                "JOIN shows s ON b.show_id = s.id " +
                "JOIN movies m ON s.movie_id = m.id " +
                "WHERE p.booking_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapPayment(rs);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Update payment status
    public boolean updatePaymentStatus(int id, String status) {
        String sql = "UPDATE payments SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete payment
    public boolean deletePayment(int id) {
        String sql = "DELETE FROM payments WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Generate unique transaction ID
    private String generateTransactionId() {
        return "TXN" + System.currentTimeMillis();
    }

    // Map database row to Payment object
    private Payment mapPayment(ResultSet rs) throws SQLException {
        Payment payment = new Payment();
        payment.setId(rs.getInt("id"));
        payment.setBookingId(rs.getInt("booking_id"));
        payment.setAmount(rs.getDouble("amount"));
        payment.setPaymentMethod(rs.getString("payment_method"));
        payment.setStatus(rs.getString("status"));
        payment.setCardHolderName(rs.getString("card_holder_name"));
        payment.setTransactionId(rs.getString("transaction_id"));
        payment.setPaymentDate(rs.getTimestamp("payment_date"));
        try {
            payment.setMovieTitle(rs.getString("movie_title"));
        } catch (SQLException e) {
            // movie_title may not always be in result set
        }
        return payment;
    }

    // Process refund
    public boolean processRefund(int bookingId, double refundAmount,
            double cancellationFee) throws SQLException {
        String sql = "UPDATE payments SET status = 'refunded', " +
                "refund_amount = ?, cancellation_fee = ? " +
                "WHERE booking_id = ?";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDouble(1, refundAmount);
            ps.setDouble(2, cancellationFee);
            ps.setInt(3, bookingId);
            return ps.executeUpdate() > 0;
        }
    }

    // Get payment by booking ID for refund check
    public boolean hasPayment(int bookingId) throws SQLException {
        String sql = "SELECT id FROM payments WHERE booking_id = ? AND status = 'success'";
        try (Connection conn = DBConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }
}