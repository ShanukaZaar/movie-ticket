package com.movieticket.dao;

import com.movieticket.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class BookingDAO {

    public boolean updateBookingStatusToPaid(int bookingId) {
        String sql = "UPDATE bookings SET status = 'PAID' WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, bookingId);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}