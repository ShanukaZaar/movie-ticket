<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Show - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 { font-size: 2rem; font-weight: 900; }
        .page-header h1 span { color: #e50914; }
        .section { padding: 40px 0; }
        .date-group { margin-bottom: 40px; }
        .date-title { color: #e50914; font-weight: 700; font-size: 1.1rem; margin-bottom: 15px; padding-bottom: 8px; border-bottom: 1px solid #333; }
        .show-card { background: #1a1a1a; border: 2px solid #333; border-radius: 15px; padding: 20px; transition: all 0.3s; cursor: pointer; text-decoration: none; color: #fff; display: block; }
        .show-card:hover { border-color: #e50914; transform: translateY(-3px); color: #fff; box-shadow: 0 10px 30px rgba(229,9,20,0.2); }
        .show-time { font-size: 1.8rem; font-weight: 900; color: #e50914; }
        .show-info { color: #aaa; font-size: 0.9rem; margin-top: 5px; }
        .show-price { font-size: 1.2rem; font-weight: 700; color: #fff; margin-top: 10px; }
        .show-price span { color: #e50914; }
        .movie-poster-sm { width: 60px; height: 80px; object-fit: cover; border-radius: 8px; }
        .no-shows { text-align: center; padding: 60px 0; color: #aaa; }
        .no-shows i { font-size: 4rem; color: #333; display: block; margin-bottom: 20px; }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb" style="background:transparent;">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home" style="color:#aaa;">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/movies?action=list" style="color:#aaa;">Movies</a></li>
                <li class="breadcrumb-item active" style="color:#e50914;">Select Show</li>
            </ol>
        </nav>
        <h1>🎬 Select a <span>Show</span></h1>
        <c:if test="${not empty shows}">
            <p style="color:#aaa;">${shows[0].movieTitle} — Choose your preferred show time</p>
        </c:if>
    </div>
</div>

<section class="section">
    <div class="container">
        <c:choose>
            <c:when test="${not empty shows}">
                <%-- Group by date --%>
                <c:set var="currentDate" value=""/>
                <c:forEach var="show" items="${shows}">
                    <c:if test="${show.showDate != currentDate}">
                        <c:set var="currentDate" value="${show.showDate}"/>
                        <div class="date-title">
                            <i class="bi bi-calendar3"></i> ${show.showDate}
                        </div>
                    </c:if>
                    <div class="row mb-3">
                        <div class="col-md-6 col-lg-4">
                            <a href="${pageContext.request.contextPath}/booking?action=selectSeats&showId=${show.id}"
                               class="show-card">
                                <div class="d-flex align-items-center gap-3">
                                    <div>
                                        <div class="show-time">${show.showTime}</div>
                                        <div class="show-info">
                                            <i class="bi bi-building"></i> ${show.theaterName} •
                                            <i class="bi bi-display"></i> ${show.screenName}
                                        </div>
                                        <div class="show-price">Rs. <span>${show.price}</span> per seat</div>
                                    </div>
                                    <div class="ms-auto">
                                        <i class="bi bi-chevron-right" style="font-size:1.5rem; color:#e50914;"></i>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-shows">
                    <i class="bi bi-calendar-x"></i>
                    <h4>No shows available</h4>
                    <p>There are no upcoming shows for this movie.</p>
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