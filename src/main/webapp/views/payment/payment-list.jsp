<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>All Payments - CineBook</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
            <style>
                body {
                    background: #0a0a0a;
                    color: #fff;
                    min-height: 100vh;
                }

                .page-header {
                    background: linear-gradient(135deg, #1a0000, #0a0a0a);
                    padding: 50px 0 30px;
                    border-bottom: 2px solid #e50914;
                }

                .page-header h1 span {
                    color: #e50914;
                }

                .section {
                    padding: 40px 0;
                }

                .table-card {
                    background: #1a1a1a;
                    border-radius: 15px;
                    overflow: hidden;
                }

                table {
                    color: #fff;
                    width: 100%;
                    margin: 0;
                }

                thead {
                    background: #e50914;
                }

                thead th {
                    padding: 15px;
                    font-weight: 700;
                    border: none;
                }

                tbody tr {
                    border-bottom: 1px solid #333;
                    transition: background 0.2s;
                }

                tbody tr:hover {
                    background: #222;
                }

                tbody td {
                    padding: 12px 15px;
                    vertical-align: middle;
                    color: #ccc;
                }

                .status-success {
                    color: #51cf66;
                    font-weight: 600;
                }

                .status-failed {
                    color: #ff6b6b;
                    font-weight: 600;
                }

                .status-refunded {
                    color: #f39c12;
                    font-weight: 600;
                }

                .amount {
                    color: #e50914;
                    font-weight: 700;
                }

                .badge-method {
                    background: rgba(229, 9, 20, 0.2);
                    color: #e50914;
                    padding: 3px 10px;
                    border-radius: 20px;
                    font-size: 0.8rem;
                }

                .empty-state {
                    text-align: center;
                    padding: 60px 0;
                    color: #aaa;
                }

                .empty-state i {
                    font-size: 4rem;
                    color: #333;
                    display: block;
                    margin-bottom: 15px;
                }
            </style>
        </head>

        <body>

            <c:set var="currentPage" value="dashboard" scope="request" />
            <%@ include file="../navbar.jsp" %>

                <div class="page-header">
                    <div class="container">
                        <h1>All <span>Payments</span></h1>
                        <p style="color:#aaa;">Admin view - all payment transactions</p>
                    </div>
                </div>

                <section class="section">
                    <div class="container">
                        <c:choose>
                            <c:when test="${not empty payments}">
                                <div class="table-card">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th>#ID</th>
                                                <th>Booking ID</th>
                                                <th>Movie</th>
                                                <th>Amount</th>
                                                <th>Method</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                                <th>Transaction ID</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="payment" items="${payments}">
                                                <tr>
                                                    <td>#${payment.id}</td>
                                                    <td>#${payment.bookingId}</td>
                                                    <td style="color:#fff; font-weight:600;">${payment.movieTitle}</td>
                                                    <td class="amount">Rs. ${payment.amount}</td>
                                                    <td>
                                                        <span class="badge-method">${payment.paymentMethod}</span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${payment.status == 'success'}">
                                                                <span class="status-success">Success</span>
                                                            </c:when>
                                                            <c:when test="${payment.status == 'failed'}">
                                                                <span class="status-failed">Failed</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-refunded">Refunded</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${payment.paymentDate}</td>
                                                    <td style="font-family:monospace; font-size:0.8rem; color:#aaa;">
                                                        ${payment.transactionId}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="bi bi-credit-card"></i>
                                    <h5>No payments found</h5>
                                    <p>No payment transactions have been made yet.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </section>

                <footer
                    style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
                    <p>2024 CineBook. All rights reserved.</p>
                </footer>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>