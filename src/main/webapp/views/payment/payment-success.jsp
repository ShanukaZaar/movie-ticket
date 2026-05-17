<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Payment Successful - CineBook</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
            <style>
                body {
                    background: #0a0a0a;
                    color: #fff;
                    min-height: 100vh;
                }

                .section {
                    padding: 60px 0;
                }

                .success-card {
                    background: #1a1a1a;
                    border-radius: 20px;
                    border: 2px solid #28a745;
                    padding: 50px;
                    text-align: center;
                    max-width: 600px;
                    margin: 0 auto;
                }

                .success-icon {
                    font-size: 5rem;
                    color: #28a745;
                    margin-bottom: 20px;
                    animation: pop 0.5s ease-in-out;
                }

                @keyframes pop {
                    0% {
                        transform: scale(0);
                    }

                    70% {
                        transform: scale(1.1);
                    }

                    100% {
                        transform: scale(1);
                    }
                }

                .transaction-id {
                    background: #111;
                    border-radius: 10px;
                    padding: 15px;
                    font-family: monospace;
                    font-size: 1rem;
                    color: #e50914;
                    margin: 20px 0;
                    letter-spacing: 2px;
                }

                .details-card {
                    background: #111;
                    border-radius: 12px;
                    padding: 20px;
                    text-align: left;
                    margin: 25px 0;
                }

                .detail-row {
                    display: flex;
                    justify-content: space-between;
                    padding: 8px 0;
                    border-bottom: 1px solid #222;
                    color: #ccc;
                    font-size: 0.9rem;
                }

                .detail-row:last-child {
                    border-bottom: none;
                }

                .detail-row strong {
                    color: #fff;
                }

                .btn-home {
                    background: #e50914;
                    border: none;
                    color: #fff;
                    border-radius: 25px;
                    padding: 12px 30px;
                    font-weight: 700;
                    text-decoration: none;
                    display: inline-block;
                    transition: all 0.3s;
                    margin: 5px;
                }

                .btn-home:hover {
                    background: #b20710;
                    color: #fff;
                }

                .btn-bookings {
                    background: transparent;
                    border: 2px solid #555;
                    color: #aaa;
                    border-radius: 25px;
                    padding: 12px 30px;
                    font-weight: 700;
                    text-decoration: none;
                    display: inline-block;
                    transition: all 0.3s;
                    margin: 5px;
                }

                .btn-bookings:hover {
                    border-color: #fff;
                    color: #fff;
                }
            </style>
        </head>

        <body>

            <c:set var="currentPage" value="booking" scope="request" />
            <%@ include file="../navbar.jsp" %>

                <section class="section">
                    <div class="container">
                        <div class="success-card">
                            <div class="success-icon">
                                <i class="bi bi-check-circle-fill"></i>
                            </div>
                            <h2 style="font-weight:900;">Payment Successful!</h2>
                            <p style="color:#aaa;">Your booking has been confirmed and payment processed successfully.
                            </p>

                            <c:if test="${not empty payment}">
                                <div class="transaction-id">
                                    TXN: ${payment.transactionId}
                                </div>

                                <div class="details-card">
                                    <div class="detail-row">
                                        <span>Booking ID</span>
                                        <strong>#${payment.bookingId}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Payment Method</span>
                                        <strong>${payment.paymentMethod}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Payment Date</span>
                                        <strong>${payment.paymentDate}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Status</span>
                                        <strong style="color:#28a745;">Confirmed</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Amount Paid</span>
                                        <strong style="color:#e50914;">Rs. ${payment.amount}</strong>
                                    </div>
                                </div>
                            </c:if>

                            <c:if test="${not empty booking}">
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
                                        <span>Show Date</span>
                                        <strong>${booking.showDate}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Show Time</span>
                                        <strong>${booking.showTime}</strong>
                                    </div>
                                </div>
                            </c:if>

                            <div class="mt-3">
                                <a href="${pageContext.request.contextPath}/booking?action=myBookings"
                                    class="btn-bookings">View My Bookings</a>
                                <a href="${pageContext.request.contextPath}/home" class="btn-home">Go Home</a>
                            </div>
                        </div>
                    </div>
                </section>

                <footer
                    style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
                    <p>2024 CineBook. All rights reserved.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>