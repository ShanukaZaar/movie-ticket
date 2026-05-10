package com.movieticket.dao;

import com.movieticket.model.Payment;
import com.movieticket.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentDAO {

    public boolean addPayment(Payment payment) {
        String sql = "INSERT INTO payments (booking_id, amount, payment_method, status) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, payment.getBookingId());
            stmt.setDouble(2, payment.getAmount());
            stmt.setString(3, payment.getPaymentMethod());
            stmt.setString(4, payment.getStatus());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}