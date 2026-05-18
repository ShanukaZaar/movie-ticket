<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Cancel Booking - CineBook</title>
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

                .warning-card {
                    background: #1a1a1a;
                    border-radius: 20px;
                    border: 2px solid #f39c12;
                    padding: 50px;
                    text-align: center;
                    max-width: 600px;
                    margin: 0 auto;
                }

                .warning-icon {
                    font-size: 5rem;
                    color: #f39c12;
                    margin-bottom: 20px;
                    animation: pulse 1s ease-in-out;
                }

                @keyframes pulse {
                    0% {
                        transform: scale(0.8);
                    }

                    50% {
                        transform: scale(1.1);
                    }

                    100% {
                        transform: scale(1);
                    }
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

                .fee-row {
                    display: flex;
                    justify-content: space-between;
                    padding: 8px 0;
                    color: #ff6b6b;
                    font-size: 0.9rem;
                    border-bottom: 1px solid #222;
                }

                .refund-row {
                    display: flex;
                    justify-content: space-between;
                    padding: 10px 0;
                    font-weight: 700;
                    font-size: 1.1rem;
                }

                .refund-row span:last-child {
                    color: #51cf66;
                }

                .warning-text {
                    background: rgba(243, 156, 18, 0.1);
                    border: 1px solid rgba(243, 156, 18, 0.4);
                    border-radius: 10px;
                    padding: 15px;
                    color: #f39c12;
                    font-size: 0.9rem;
                    margin-bottom: 25px;
                    text-align: left;
                }

                .btn-confirm-cancel {
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

                .btn-confirm-cancel:hover {
                    background: #b20710;
                    color: #fff;
                }

                .btn-go-back {
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

                .btn-go-back:hover {
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
                        <div class="warning-card">
                            <div class="warning-icon">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                            </div>
                            <h2 style="font-weight:900;">Cancel Booking?</h2>
                            <p style="color:#aaa;">Please read the cancellation policy before proceeding.</p>

                            <%-- Warning message --%>
                                <div class="warning-text">
                                    <i class="bi bi-info-circle"></i>
                                    <strong> Cancellation Policy:</strong> A cancellation fee of
                                    <strong style="color:#e50914;">5%</strong> of the total amount will be deducted.
                                    The remaining amount will be refunded to your account.
                                    This action cannot be undone.
                                </div>

                                <div class="details-card">
                                    <div class="detail-row">
                                        <span>Booking ID</span>
                                        <strong>#${booking.id}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Movie</span>
                                        <strong>${booking.movieTitle}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Show Date</span>
                                        <strong>${booking.showDate} at ${booking.showTime}</strong>
                                    </div>
                                    <div class="detail-row">
                                        <span>Total Paid</span>
                                        <strong>Rs. ${booking.totalAmount}</strong>
                                    </div>
                                    <div class="fee-row">
                                        <span><i class="bi bi-dash-circle"></i> Cancellation Fee (5%)</span>
                                        <strong>- Rs.
                                            <fmt:formatNumber value="${cancellationFee}" maxFractionDigits="2" />
                                        </strong>
                                    </div>
                                    <div class="refund-row">
                                        <span>Refund Amount</span>
                                        <span>Rs.
                                            <fmt:formatNumber value="${refundAmount}" maxFractionDigits="2" />
                                        </span>
                                    </div>
                                </div>

                                <div class="d-flex gap-2 justify-content-center flex-wrap">
                                    <a href="${pageContext.request.contextPath}/booking?action=cancel&bookingId=${booking.id}&confirmed=yes"
                                        class="btn-confirm-cancel">
                                        <i class="bi bi-x-circle"></i> Confirm Cancellation
                                    </a>
                                    <a href="${pageContext.request.contextPath}/booking?action=myBookings"
                                        class="btn-go-back">
                                        <i class="bi bi-arrow-left"></i> Go Back
                                    </a>
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