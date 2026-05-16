<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${show == null ? 'Add Show' : 'Edit Show'} - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .form-section { padding: 50px 0; }
        .form-card { background: #1a1a1a; border-radius: 20px; border: 1px solid #333; padding: 40px; }
        .form-card h2 span { color: #e50914; }
        .form-label { color: #ccc; font-weight: 500; }
        .form-control, .form-select { background: #111; border: 2px solid #333; color: #fff; border-radius: 10px; padding: 12px 15px; }
        .form-control:focus, .form-select:focus { background: #111; border-color: #e50914; color: #fff; box-shadow: none; }
        .form-select option { background: #111; }
        .btn-save { background: #e50914; border: none; color: #fff; border-radius: 25px; padding: 12px 35px; font-weight: 700; }
        .btn-save:hover { background: #b20710; color: #fff; }
        .btn-cancel { background: transparent; border: 2px solid #555; color: #aaa; border-radius: 25px; padding: 12px 35px; font-weight: 700; text-decoration: none; }
        .btn-cancel:hover { border-color: #fff; color: #fff; }
    </style>
</head>
<body>

<c:set var="currentPage" value="theater" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="form-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="form-card">
                    <h2 class="mb-4">${show == null ? '➕ Add New' : '✏️ Edit'} <span>Show</span></h2>

                    <form action="${pageContext.request.contextPath}/theater" method="post">
                        <input type="hidden" name="action" value="saveShow">
                        <input type="hidden" name="id" value="${show.id}">

                        <div class="mb-3">
                            <label class="form-label">Movie *</label>
                            <select name="movieId" class="form-select" required>
                                <option value="">Select Movie</option>
                                <c:forEach var="movie" items="${movies}">
                                    <option value="${movie.id}"
                                        ${show.movieId == movie.id ? 'selected' : ''}>
                                        ${movie.title}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Screen *</label>
                            <select name="screenId" class="form-select" required>
                                <option value="">Select Screen</option>
                                <c:forEach var="screen" items="${screens}">
                                    <option value="${screen.id}"
                                        ${show.screenId == screen.id ? 'selected' : ''}>
                                        ${screen.theaterName} — ${screen.screenName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Show Date *</label>
                                <input type="date" name="showDate" class="form-control"
                                       value="${show.showDate}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Show Time *</label>
                                <input type="time" name="showTime" class="form-control"
                                       value="${show.showTime}" required>
                            </div>
                        </div>
                        <div class="mb-4 mt-3">
                            <label class="form-label">Ticket Price (Rs.) *</label>
                            <input type="number" name="price" class="form-control"
                                   value="${show.price}" placeholder="e.g. 500" step="0.01" required>
                        </div>

                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-save">
                                <i class="bi bi-check-circle"></i> Save Show
                            </button>
                            <a href="${pageContext.request.contextPath}/theater?action=shows" class="btn-cancel">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>