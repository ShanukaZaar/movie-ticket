<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }

        .page-header {
            background: linear-gradient(135deg, #1a0000, #0a0a0a);
            padding: 50px 0 30px;
            border-bottom: 2px solid #e50914;
        }
        .page-header h1 { font-size: 2rem; font-weight: 900; }
        .page-header h1 span { color: #e50914; }
        .welcome-role {
            background: rgba(229,9,20,0.15);
            border: 1px solid rgba(229,9,20,0.3);
            color: #e50914;
            padding: 4px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-block;
            margin-top: 8px;
        }

        .section { padding: 40px 0; }

        .dash-card {
            background: #1a1a1a;
            border: 1px solid #333;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            transition: all 0.3s;
            height: 100%;
            text-decoration: none;
            display: block;
            color: #fff;
        }
        .dash-card:hover {
            border-color: #e50914;
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(229,9,20,0.2);
            color: #fff;
        }
        .dash-card .card-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }
        .dash-card h5 { font-weight: 700; margin-bottom: 8px; }
        .dash-card p { color: #aaa; font-size: 0.9rem; margin: 0; }

        .icon-red { color: #e50914; }
        .icon-green { color: #28a745; }
        .icon-blue { color: #007bff; }
        .icon-yellow { color: #f39c12; }
        .icon-purple { color: #9b59b6; }
        .icon-teal { color: #17a2b8; }

        .section-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: #aaa;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #333;
        }
        .section-title span { color: #e50914; }
    </style>
</head>
<body>

<c:set var="currentPage" value="dashboard" scope="request"/>
<%@ include file="navbar.jsp" %>

<%-- Page Header --%>
<div class="page-header">
    <div class="container">
        <h1>Welcome, <span>${sessionScope.userName}</span>!</h1>
        <div class="welcome-role">
            <i class="bi bi-shield-check"></i>
            ${sessionScope.userRole == 'admin' ? 'Administrator' : 'Customer'}
        </div>
    </div>
</div>

<section class="section">
    <div class="container">

        <%-- General Cards - visible to all --%>
        <div class="section-title"><span>Movies</span></div>
        <div class="row g-4 mb-5">
            <div class="col-6 col-md-3">
                <a href="${pageContext.request.contextPath}/movies?action=list" class="dash-card">
                    <span class="card-icon icon-red"><i class="bi bi-film"></i></span>
                    <h5>Browse Movies</h5>
                    <p>View all movie listings</p>
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="${pageContext.request.contextPath}/booking?action=myBookings" class="dash-card">
                    <span class="card-icon icon-blue"><i class="bi bi-ticket-perforated"></i></span>
                    <h5>My Bookings</h5>
                    <p>View your bookings</p>
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="${pageContext.request.contextPath}/theater?action=shows" class="dash-card">
                    <span class="card-icon icon-green"><i class="bi bi-camera-reels"></i></span>
                    <h5>Shows</h5>
                    <p>View available shows</p>
                </a>
            </div>
            <div class="col-6 col-md-3">
                <a href="${pageContext.request.contextPath}/theater?action=list" class="dash-card">
                    <span class="card-icon icon-yellow"><i class="bi bi-building"></i></span>
                    <h5>Theaters</h5>
                    <p>View theater locations</p>
                </a>
            </div>
        </div>

        <%-- Admin only cards --%>
        <c:if test="${sessionScope.userRole == 'admin'}">
            <div class="section-title"><span>Admin</span> Controls</div>
            <div class="row g-4">
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/movies?action=new" class="dash-card">
                        <span class="card-icon icon-red"><i class="bi bi-plus-circle"></i></span>
                        <h5>Add Movie</h5>
                        <p>Add a new movie</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/theater?action=addShow" class="dash-card">
                        <span class="card-icon icon-green"><i class="bi bi-calendar-plus"></i></span>
                        <h5>Add Show</h5>
                        <p>Schedule a new show</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/theater?action=addTheater" class="dash-card">
                        <span class="card-icon icon-yellow"><i class="bi bi-building-add"></i></span>
                        <h5>Add Theater</h5>
                        <p>Add a new theater</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/booking?action=allBookings" class="dash-card">
                        <span class="card-icon icon-purple"><i class="bi bi-list-ul"></i></span>
                        <h5>All Bookings</h5>
                        <p>View all bookings</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/theater?action=list" class="dash-card">
                        <span class="card-icon icon-teal"><i class="bi bi-building-gear"></i></span>
                        <h5>Manage Theaters</h5>
                        <p>Edit and manage theaters</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/theater?action=screens" class="dash-card">
                        <span class="card-icon icon-blue"><i class="bi bi-display"></i></span>
                        <h5>Manage Screens</h5>
                        <p>Edit and manage screens</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/movies?action=list" class="dash-card">
                        <span class="card-icon icon-red"><i class="bi bi-collection-play"></i></span>
                        <h5>Manage Movies</h5>
                        <p>Edit and delete movies</p>
                    </a>
                </div>
                <div class="col-6 col-md-3">
                    <a href="${pageContext.request.contextPath}/theater?action=shows" class="dash-card">
                        <span class="card-icon icon-green"><i class="bi bi-calendar-week"></i></span>
                        <h5>Manage Shows</h5>
                        <p>Edit show schedules</p>
                    </a>
                </div>
            </div>
        </c:if>

    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555; margin-top:40px;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>