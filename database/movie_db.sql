-- ============================================
-- Online Movie Ticket Reservation System
-- Database Setup Script
-- ============================================

-- Create the database
CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;

-- Users table (starter table for Member 1)
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'customer') DEFAULT 'customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert a sample admin user (password: admin123)
INSERT INTO users (name, email, password, role)
VALUES ('Admin User', 'admin@movieticket.com', 'admin123', 'admin');

-- Insert a sample customer user (password: customer123)
INSERT INTO users (name, email, password, role)
VALUES ('Test Customer', 'customer@movieticket.com', 'customer123', 'customer');

-- ============================================
-- Each team member should add their tables below
-- ============================================

-- Member 2: Movies tables go here
-- Member 3: Theaters, Screens, Shows tables go here
-- Member 4: Bookings, Seats tables go here
-- Member 5: Payments table goes here
-- Member 6: No extra tables needed (uses existing tables for reports)
