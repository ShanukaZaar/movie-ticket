<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Screens - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 span { color: #e50914; }
        .section { padding: 40px 0; }
        .nav-tabs-custom { border-bottom: 2px solid #333; margin-bottom: 30px; }
        .nav-tabs-custom .nav-link { color: #aaa; border: none; padding: 10px 25px; border-radius: 0; }
        .nav-tabs-custom .nav-link:hover { color: #e50914; }
        .nav-tabs-custom .nav-link.active { color: #e50914; border-bottom: 3px solid #e50914; background: transparent; }
        .screen-card { background: #1a1a1a; border: 1px solid #333; border-radius: 12px; padding: 20px; margin-bottom: 15px; transition: all 0.3s; }
        .screen-card:hover { border-color: #e50914; }
        .screen-name { font-size: 1.1rem; font-weight: 700; }
        .screen-info { color: #aaa; font-size: 0.9rem; margin-top: 5px; }
        .screen-info i { color: #e50914; margin-right: 5px; }
        .btn-add { background: #e50914; border: none; color: #fff; border-radius: 25px; padding: 10px 25px; font-weight: 700; text-decoration: none; }
        .btn-add:hover { background: #b20710; color: #fff; }
        .btn-edit { background: #f39c12; border: none; color: #fff; border-radius: 20px; padding: 6px 15px; font-size: 0.85rem; text-decoration: none; }
        .btn-edit:hover { background: #d68910; color: #fff; }
        .btn-delete { background: #333; border: none; color: #fff; border-radius: 20px; padding: 6px 15px; font-size: 0.85rem; text-decoration: none; }
        .btn-delete:hover { background: #e50914; color: #fff; }
        .seats-badge { background: rgba(229,9,20,0.2); color: #e50914; padding: 3px 10px; border-radius: 20px; font-size: 0.8rem; }
    </style>
</head>
<body>

<c:set var="currentPage" value="theater" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>Theater & Show <span>Management</span></h1>
        <p style="color:#aaa;">Manage theaters, screens and show schedules</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <ul class="nav nav-tabs-custom">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/theater?action=list">
                    <i class="bi bi-building"></i> Theaters
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/theater?action=screens">
                    <i class="bi bi-display"></i> Screens
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/theater?action=shows">
                    <i class="bi bi-camera-reels"></i> Shows
                </a>
            </li>
        </ul>

        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4>All Screens <span style="color:#aaa; font-size:0.9rem;">(${screens.size()} total)</span></h4>
            <c:if test="${sessionScope.userRole == 'admin'}">
                <a href="${pageContext.request.contextPath}/theater?action=addScreen" class="btn-add">
                    <i class="bi bi-plus-circle"></i> Add Screen
                </a>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${not empty screens}">
                <c:forEach var="screen" items="${screens}">
                    <div class="screen-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <div class="screen-name">
                                    <i class="bi bi-display" style="color:#e50914;"></i>
                                    ${screen.screenName}
                                </div>
                                <div class="screen-info">
                                    <i class="bi bi-building"></i>${screen.theaterName}
                                </div>
                                <div class="mt-2">
                                    <span class="seats-badge">
                                        <i class="bi bi-grid-3x3"></i> ${screen.totalSeats} Seats
                                    </span>
                                </div>
                            </div>
                            <c:if test="${sessionScope.userRole == 'admin'}">
                                <div class="col-md-4 text-md-end mt-3 mt-md-0 d-flex gap-2 justify-content-md-end">
                                    <a href="${pageContext.request.contextPath}/theater?action=editScreen&id=${screen.id}"
                                       class="btn-edit"><i class="bi bi-pencil"></i> Edit</a>
                                    <a href="${pageContext.request.contextPath}/theater?action=deleteScreen&id=${screen.id}"
                                       class="btn-delete"
                                       onclick="return confirm('Delete this screen?')">
                                        <i class="bi bi-trash"></i> Delete
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div style="text-align:center; padding:60px 0; color:#aaa;">
                    <i class="bi bi-display" style="font-size:4rem; color:#333; display:block; margin-bottom:15px;"></i>
                    <h5>No screens found</h5>
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