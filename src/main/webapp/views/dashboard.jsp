<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CineBook</title>
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
        .page-header p { color: #aaa; font-size: 1rem; margin: 0; }

        /* Stat cards */
        .stat-card { background: #1a1a1a; border: 1px solid #222; border-radius: 15px; padding: 25px; transition: all 0.3s; }
        .stat-card:hover { border-color: #e50914; transform: translateY(-5px); }
        .stat-card .icon { font-size: 3rem; opacity: 0.3; }
        .stat-card .number { font-size: 2.2rem; font-weight: 900; color: #e50914; }
        .stat-card .label { color: #aaa; font-size: 0.95rem; margin-top: 5px; }

        /* Quick links */
        .quick-card { background: #1a1a1a; border: 2px solid #222; border-radius: 15px; padding: 30px; text-align: center; transition: all 0.3s; text-decoration: none; color: #fff; display: block; }
        .quick-card:hover { border-color: #e50914; color: #e50914; transform: translateY(-5px); }
        .quick-card i { font-size: 2.5rem; display: block; margin-bottom: 12px; }
        .quick-card span { font-weight: 700; font-size: 1rem; }

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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/reports">Reports</a></li>
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
        <h1>Admin <span>Dashboard</span></h1>
        <p>Welcome back! Here's what's happening with CineBook today.</p>
    </div>
</div>

<div class="container mt-5">

    <%-- Stat Cards --%>
    <div class="row g-4 mb-5">

        <div class="col-md-3">
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="number">${totalUsers}</div>
                        <div class="label">Total Users</div>
                    </div>
                    <i class="bi bi-people-fill icon"></i>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="number">${totalBookings}</div>
                        <div class="label">Confirmed Bookings</div>
                    </div>
                    <i class="bi bi-ticket-perforated-fill icon"></i>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="number">
                            $<fmt:formatNumber value="${totalRevenue}" pattern="#,##0"/>
                        </div>
                        <div class="label">Total Revenue</div>
                    </div>
                    <i class="bi bi-cash-coin icon"></i>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="stat-card">
                <div class="d-flex justify-content-between align-items-start">
                    <div>
                        <div class="number">${totalMovies}</div>
                        <div class="label">Movies Now Showing</div>
                    </div>
                    <i class="bi bi-film icon"></i>
                </div>
            </div>
        </div>

    </div>

    <%-- Quick Links --%>
    <h2 style="font-weight:800; margin-bottom:25px;">
        Quick <span style="color:#e50914;">Links</span>
    </h2>
    <div class="row g-4">
        <div class="col-6 col-md-2">
            <a href="${pageContext.request.contextPath}/reports" class="quick-card">
                <i class="bi bi-bar-chart-fill"></i>
                <span>Reports</span>
            </a>
        </div>
        <div class="col-6 col-md-2">
            <a href="${pageContext.request.contextPath}/movies?action=list" class="quick-card">
                <i class="bi bi-film"></i>
                <span>Movies</span>
            </a>
        </div>
        <div class="col-6 col-md-2">
            <a href="${pageContext.request.contextPath}/bookings" class="quick-card">
                <i class="bi bi-ticket-perforated"></i>
                <span>Bookings</span>
            </a>
        </div>
        <div class="col-6 col-md-2">
            <a href="${pageContext.request.contextPath}/theaters" class="quick-card">
                <i class="bi bi-building"></i>
                <span>Theaters</span>
            </a>
        </div>
        <div class="col-6 col-md-2">
            <a href="${pageContext.request.contextPath}/shows" class="quick-card">
                <i class="bi bi-display"></i>
                <span>Shows</span>
            </a>
        </div>
        <div class="col-6 col-md-2">
            <a href="${pageContext.request.contextPath}/home" class="quick-card">
                <i class="bi bi-house-fill"></i>
                <span>Home</span>
            </a>
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