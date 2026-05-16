<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 { font-size: 2rem; font-weight: 900; }
        .page-header h1 span { color: #e50914; }
        .section { padding: 40px 0; }
        .booking-card { background: #1a1a1a; border: 1px solid #333; border-radius: 15px; padding: 20px; margin-bottom: 20px; transition: all 0.3s; }
        .booking-card:hover { border-color: #e50914; }
        .booking-id { color: #e50914; font-weight: 700; font-size: 0.9rem; }
        .movie-title { font-size: 1.2rem; font-weight: 700; margin: 5px 0; }
        .booking-info { color: #aaa; font-size: 0.9rem; }
        .booking-info i { color: #e50914; margin-right: 5px; }
        .status-confirmed { background: rgba(40,167,69,0.2); color: #51cf66; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .status-cancelled { background: rgba(229,9,20,0.2); color: #ff6b6b; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .status-pending { background: rgba(243,156,18,0.2); color: #f39c12; padding: 4px 12px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
        .total-amount { font-size: 1.1rem; font-weight: 700; color: #e50914; }
        .btn-cancel { background: transparent; border: 1px solid #555; color: #aaa; border-radius: 20px; padding: 5px 15px; font-size: 0.85rem; transition: all 0.3s; }
        .btn-cancel:hover { border-color: #e50914; color: #e50914; }
        .empty-state { text-align: center; padding: 80px 0; color: #aaa; }
        .empty-state i { font-size: 5rem; color: #333; display: block; margin-bottom: 20px; }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>🎟️ My <span>Bookings</span></h1>
        <p style="color:#aaa;">View and manage your movie ticket bookings</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <c:choose>
            <c:when test="${not empty bookings}">
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <div class="booking-id">Booking #${booking.id}</div>
                                <div class="movie-title">${booking.movieTitle}</div>
                                <div class="booking-info mt-2">
                                    <span><i class="bi bi-building"></i>${booking.theaterName}</span> &nbsp;|&nbsp;
                                    <span><i class="bi bi-display"></i>${booking.screenName}</span> &nbsp;|&nbsp;
                                    <span><i class="bi bi-calendar3"></i>${booking.showDate}</span> &nbsp;|&nbsp;
                                    <span><i class="bi bi-clock"></i>${booking.showTime}</span>
                                </div>
                                <div class="mt-2">
                                    <span class="booking-info"><i class="bi bi-clock-history"></i>Booked: ${booking.bookingDate}</span>
                                </div>
                            </div>
                            <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                <div class="total-amount">Rs. ${booking.totalAmount}</div>
                                <div class="mt-2">
                                    <c:choose>
                                        <c:when test="${booking.status == 'confirmed'}">
                                            <span class="status-confirmed">✅ Confirmed</span>
                                        </c:when>
                                        <c:when test="${booking.status == 'cancelled'}">
                                            <span class="status-cancelled">❌ Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-pending">⏳ Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <c:if test="${booking.status == 'confirmed'}">
                                    <div class="mt-2">
                                        <a href="${pageContext.request.contextPath}/booking?action=cancel&bookingId=${booking.id}"
                                           class="btn-cancel"
                                           onclick="return confirm('Cancel this booking?')">
                                            Cancel Booking
                                        </a>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="bi bi-ticket-perforated"></i>
                    <h4>No bookings yet</h4>
                    <p>You haven't booked any tickets yet.</p>
                    <a href="${pageContext.request.contextPath}/movies?action=list"
                       class="btn mt-3" style="background:#e50914; color:#fff; border-radius:25px; padding:10px 30px;">
                        Browse Movies
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>