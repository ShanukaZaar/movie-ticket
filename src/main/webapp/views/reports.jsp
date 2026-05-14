<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', sans-serif; background: #0a0a0a; color: #fff; }

        /* Navbar */
        .navbar { background: rgba(0,0,0,0.95) !important; border-bottom: 2px solid #e50914; padding: 15px 0; }
        .navbar-brand { font-size: 1.8rem; font-weight: 900; color: #e50914 !important; }
        .nav-link { color: #fff !important; font-weight: 500; margin: 0 5px; transition: color 0.3s; }
        .nav-link:hover { color: #e50914 !important; }
        .btn-logout { background: transparent; border: 2px solid #e50914; color: #e50914 !important; border-radius: 25px; padding: 5px 20px; }
        .btn-logout:hover { background: #e50914; color: #fff !important; }

        /* Page header */
        .page-header { background: linear-gradient(135deg, #1a0a0a, #0a0a1a); padding: 40px 0; border-bottom: 2px solid #e50914; }
        .page-header h1 { font-size: 2.5rem; font-weight: 900; }
        .page-header h1 span { color: #e50914; }

        /* Report sections */
        .report-section { margin-bottom: 50px; }
        .report-title { font-size: 1.4rem; font-weight: 800; border-left: 4px solid #e50914; padding-left: 12px; margin-bottom: 20px; }

        /* Tables */
        .report-table { background: #1a1a1a; border-radius: 12px; overflow: hidden; border: 1px solid #222; }
        .report-table table { margin: 0; color: #fff; }
        .report-table thead tr { background: #e50914 !important; color: #fff; }
        .report-table thead th { border: none; padding: 14px 16px; font-weight: 700; }
        .report-table tbody tr { border-bottom: 1px solid #222; transition: background 0.2s; }
        .report-table tbody tr:hover { background: #222 !important; }
        .report-table tbody td { border: none; padding: 12px 16px; color: #ddd; }
        .report-table tbody tr:last-child { border-bottom: none; }
        .no-data { text-align: center; color: #555; padding: 30px; font-size: 1rem; }

        /* Footer */
        .footer { background: #000; padding: 20px 0; border-top: 3px solid #e50914; text-align: center; color: #555; font-size: 0.85rem; margin-top: 60px; }
    </style>
</head>
<body>

<%-- Navbar --%>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">🎬 CineBook</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/movies?action=list">Movies</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/reports">Reports</a></li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link btn-logout" href="${pageContext.request.contextPath}/logout">
                        <i class="bi bi-box-arrow-right"></i> Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<%-- Page Header --%>
<div class="page-header">
    <div class="container">
        <h1>System <span>Reports</span></h1>
        <p style="color:#aaa;">Detailed analytics and reports for CineBook admin.</p>
    </div>
</div>

<div class="container mt-5">

    <%-- Monthly Bookings --%>
    <div class="report-section">
        <div class="report-title">📅 Monthly Bookings and Revenue</div>
        <div class="report-table">
            <table class="table">
                <thead>
                    <tr>
                        <th>Month</th>
                        <th>Total Bookings</th>
                        <th>Revenue ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty monthlyData}">
                            <c:forEach var="row" items="${monthlyData}">
                                <tr>
                                    <td><i class="bi bi-calendar3 me-2" style="color:#e50914;"></i>${row.label}</td>
                                    <td><i class="bi bi-ticket me-2" style="color:#e50914;"></i>${row.bookingCount}</td>
                                    <td><i class="bi bi-cash me-2" style="color:#e50914;"></i>
                                        $<fmt:formatNumber value="${row.revenue}" pattern="#,##0.00"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="3" class="no-data">No monthly data available</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Movie Popularity --%>
    <div class="report-section">
        <div class="report-title">🎬 Movie Popularity (Top 10)</div>
        <div class="report-table">
            <table class="table">
                <thead>
                    <tr>
                        <th>Movie Title</th>
                        <th>Total Bookings</th>
                        <th>Revenue ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty popularMovies}">
                            <c:forEach var="row" items="${popularMovies}" varStatus="status">
                                <tr>
                                    <td>
                                        <span style="color:#e50914; font-weight:700; margin-right:8px;">
                                            #${status.index + 1}
                                        </span>
                                        ${row.label}
                                    </td>
                                    <td>${row.bookingCount}</td>
                                    <td>$<fmt:formatNumber value="${row.revenue}" pattern="#,##0.00"/></td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="3" class="no-data">No movie data available</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <%-- Payment Methods --%>
    <div class="report-section">
        <div class="report-title">💳 Revenue by Payment Method</div>
        <div class="report-table">
            <table class="table">
                <thead>
                    <tr>
                        <th>Payment Method</th>
                        <th>Transactions</th>
                        <th>Revenue ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty paymentMethods}">
                            <c:forEach var="row" items="${paymentMethods}">
                                <tr>
                                    <td>
                                        <i class="bi bi-credit-card-fill me-2" style="color:#e50914;"></i>
                                        ${row.label}
                                    </td>
                                    <td>${row.bookingCount}</td>
                                    <td>$<fmt:formatNumber value="${row.revenue}" pattern="#,##0.00"/></td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="3" class="no-data">No payment data available</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

</div>

<%-- Footer --%>
<footer class="footer">
    <p>© 2024 CineBook. All rights reserved. Made with ❤️ for movie lovers.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>