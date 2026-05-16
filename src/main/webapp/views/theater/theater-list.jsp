<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theaters - CineBook</title>
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
        .theater-card { background: #1a1a1a; border: 1px solid #333; border-radius: 15px; padding: 25px; margin-bottom: 20px; transition: all 0.3s; }
        .theater-card:hover { border-color: #e50914; }
        .theater-name { font-size: 1.3rem; font-weight: 700; }
        .theater-info { color: #aaa; font-size: 0.9rem; margin-top: 8px; }
        .theater-info i { color: #e50914; margin-right: 5px; }
        .btn-add { background: #e50914; border: none; color: #fff; border-radius: 25px; padding: 10px 25px; font-weight: 700; text-decoration: none; transition: all 0.3s; }
        .btn-add:hover { background: #b20710; color: #fff; }
        .btn-edit { background: #f39c12; border: none; color: #fff; border-radius: 20px; padding: 6px 15px; font-size: 0.85rem; text-decoration: none; }
        .btn-edit:hover { background: #d68910; color: #fff; }
        .btn-delete { background: #333; border: none; color: #fff; border-radius: 20px; padding: 6px 15px; font-size: 0.85rem; text-decoration: none; }
        .btn-delete:hover { background: #e50914; color: #fff; }
        .empty-state { text-align: center; padding: 60px 0; color: #aaa; }
        .empty-state i { font-size: 4rem; color: #333; display: block; margin-bottom: 15px; }
        .screens-badge { background: rgba(229,9,20,0.2); color: #e50914; padding: 3px 10px; border-radius: 20px; font-size: 0.8rem; font-weight: 600; }
    </style>
</head>
<body>

<c:set var="currentPage" value="theater" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>🏛️ Theater & Show <span>Management</span></h1>
        <p style="color:#aaa;">Manage theaters, screens and show schedules</p>
    </div>
</div>

<section class="section">
    <div class="container">

        <%-- Tab Navigation --%>
        <ul class="nav nav-tabs-custom">
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/theater?action=list">
                    <i class="bi bi-building"></i> Theaters
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/theater?action=screens">
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
            <h4>All Theaters <span style="color:#aaa; font-size:0.9rem;">(${theaters.size()} total)</span></h4>
            <c:if test="${sessionScope.userRole == 'admin'}">
                <a href="${pageContext.request.contextPath}/theater?action=addTheater" class="btn-add">
                    <i class="bi bi-plus-circle"></i> Add Theater
                </a>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${not empty theaters}">
                <c:forEach var="theater" items="${theaters}">
                    <div class="theater-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <div class="theater-name">
                                    <i class="bi bi-building" style="color:#e50914;"></i>
                                    ${theater.name}
                                </div>
                                <div class="theater-info">
                                    <i class="bi bi-geo-alt-fill"></i>${theater.location}
                                </div>
                                <div class="mt-2">
                                    <span class="screens-badge">
                                        <i class="bi bi-display"></i> ${theater.totalScreens} Screens
                                    </span>
                                </div>
                            </div>
                            <c:if test="${sessionScope.userRole == 'admin'}">
                                <div class="col-md-4 text-md-end mt-3 mt-md-0 d-flex gap-2 justify-content-md-end">
                                    <a href="${pageContext.request.contextPath}/theater?action=editTheater&id=${theater.id}"
                                       class="btn-edit"><i class="bi bi-pencil"></i> Edit</a>
                                    <a href="${pageContext.request.contextPath}/theater?action=deleteTheater&id=${theater.id}"
                                       class="btn-delete"
                                       onclick="return confirm('Delete this theater?')">
                                        <i class="bi bi-trash"></i> Delete
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="bi bi-building-x"></i>
                    <h5>No theaters found</h5>
                    <p>Add your first theater to get started</p>
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