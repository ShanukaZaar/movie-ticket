<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmed - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .confirmation-section { padding: 60px 0; }
        .confirmation-card { background: #1a1a1a; border-radius: 20px; border: 2px solid #e50914; padding: 50px; text-align: center; max-width: 600px; margin: 0 auto; }
        .success-icon { font-size: 5rem; color: #28a745; margin-bottom: 20px; animation: pulse 1s ease-in-out; }
        @keyframes pulse { 0% { transform: scale(0); } 70% { transform: scale(1.1); } 100% { transform: scale(1); } }
        .booking-id { font-size: 1.5rem; font-weight: 900; color: #e50914; margin: 15px 0; }
        .details-card { background: #111; border-radius: 12px; padding: 20px; text-align: left; margin: 25px 0; }
        .detail-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #222; color: #ccc; font-size: 0.9rem; }
        .detail-row:last-child { border-bottom: none; }
        .detail-row strong { color: #fff; }
        .seats-display { color: #e50914; font-weight: 700; }
        .total-row { display: flex; justify-content: space-between; padding: 12px 0; font-weight: 700; font-size: 1.1rem; }
        .total-row span:last-child { color: #e50914; }
        .btn-home { background: #e50914; border: none; color: #fff; border-radius: 25px; padding: 12px 30px; font-weight: 700; text-decoration: none; display: inline-block; transition: all 0.3s; }
        .btn-home:hover { background: #b20710; color: #fff; }
        .btn-mybookings { background: transparent; border: 2px solid #555; color: #aaa; border-radius: 25px; padding: 12px 30px; font-weight: 700; text-decoration: none; display: inline-block; transition: all 0.3s; }
        .btn-mybookings:hover { border-color: #fff; color: #fff; }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="../navbar.jsp" %>

<section class="confirmation-section">
    <div class="container">
        <div class="confirmation-card">
            <div class="success-icon"><i class="bi bi-check-circle-fill"></i></div>
            <h2 style="font-weight:900;">Booking Confirmed! 🎉</h2>
            <p style="color:#aaa;">Your tickets have been successfully booked.</p>
            <div class="booking-id">Booking #${booking.id}</div>

            <div class="details-card">
                <div class="detail-row">
                    <span>Movie</span>
                    <strong>${booking.movieTitle}</strong>
                </div>
                <div class="detail-row">
                    <span>Theater</span>
                    <strong>${booking.theaterName}</strong>
                </div>
                <div class="detail-row">
                    <span>Screen</span>
                    <strong>${booking.screenName}</strong>
                </div>
                <div class="detail-row">
                    <span>Date</span>
                    <strong>${booking.showDate}</strong>
                </div>
                <div class="detail-row">
                    <span>Time</span>
                    <strong>${booking.showTime}</strong>
                </div>
                <div class="detail-row">
                    <span>Seats</span>
                    <strong class="seats-display">
                        <c:forEach var="seat" items="${booking.seatNumbers}" varStatus="s">
                            ${seat}<c:if test="${!s.last}">, </c:if>
                        </c:forEach>
                    </strong>
                </div>
                <div class="detail-row">
                    <span>Status</span>
                    <strong style="color:#28a745;">✅ Confirmed</strong>
                </div>
                <div class="total-row">
                    <span>Total Paid</span>
                    <span>Rs. ${booking.totalAmount}</span>
                </div>
            </div>

            <div class="d-flex gap-3 justify-content-center flex-wrap">
                <a href="${pageContext.request.contextPath}/booking?action=myBookings" class="btn-mybookings">
                    <i class="bi bi-list-ul"></i> My Bookings
                </a>
                <a href="${pageContext.request.contextPath}/home" class="btn-home">
                    <i class="bi bi-house"></i> Go Home
                </a>
            </div>
        </div>
    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>