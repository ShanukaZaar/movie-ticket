<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings - CineBook Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 span { color: #e50914; }
        .section { padding: 40px 0; }
        .table-dark-custom { background: #1a1a1a; border-radius: 15px; overflow: hidden; }
        table { color: #fff; width: 100%; }
        thead { background: #e50914; }
        thead th { padding: 15px; font-weight: 700; border: none; }
        tbody tr { border-bottom: 1px solid #333; transition: background 0.2s; }
        tbody tr:hover { background: #222; }
        tbody td { padding: 12px 15px; vertical-align: middle; color: #ccc; }
        .status-confirmed { color: #51cf66; font-weight: 600; }
        .status-cancelled { color: #ff6b6b; font-weight: 600; }
        .status-pending { color: #f39c12; font-weight: 600; }
        .amount { color: #e50914; font-weight: 700; }
    </style>
</head>
<body>

<c:set var="currentPage" value="dashboard" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>📋 All <span>Bookings</span></h1>
        <p style="color:#aaa;">Admin view — all customer bookings</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <div class="table-dark-custom">
            <table>
                <thead>
                    <tr>
                        <th>#ID</th>
                        <th>Movie</th>
                        <th>Theater</th>
                        <th>Date & Time</th>
                        <th>Amount</th>
                        <th>Status</th>
                        <th>Booked On</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${bookings}">
                        <tr>
                            <td>#${booking.id}</td>
                            <td style="color:#fff; font-weight:600;">${booking.movieTitle}</td>
                            <td>${booking.theaterName}</td>
                            <td>${booking.showDate} ${booking.showTime}</td>
                            <td class="amount">Rs. ${booking.totalAmount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${booking.status == 'confirmed'}"><span class="status-confirmed">✅ Confirmed</span></c:when>
                                    <c:when test="${booking.status == 'cancelled'}"><span class="status-cancelled">❌ Cancelled</span></c:when>
                                    <c:otherwise><span class="status-pending">⏳ Pending</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>${booking.bookingDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>