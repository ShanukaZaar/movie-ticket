<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${theater == null ? 'Add Theater' : 'Edit Theater'} - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .form-section { padding: 50px 0; }
        .form-card { background: #1a1a1a; border-radius: 20px; border: 1px solid #333; padding: 40px; }
        .form-card h2 span { color: #e50914; }
        .form-label { color: #ccc; font-weight: 500; }
        .form-control { background: #111; border: 2px solid #333; color: #fff; border-radius: 10px; padding: 12px 15px; }
        .form-control:focus { background: #111; border-color: #e50914; color: #fff; box-shadow: none; }
        .form-control::placeholder { color: #555; }
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
                    <h2 class="mb-4">${theater == null ? '➕ Add New' : '✏️ Edit'} <span>Theater</span></h2>

                    <form action="${pageContext.request.contextPath}/theater" method="post">
                        <input type="hidden" name="action" value="saveTheater">
                        <input type="hidden" name="id" value="${theater.id}">

                        <div class="mb-3">
                            <label class="form-label">Theater Name *</label>
                            <input type="text" name="name" class="form-control"
                                   value="${theater.name}" placeholder="e.g. CineBook Colombo" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Location</label>
                            <input type="text" name="location" class="form-control"
                                   value="${theater.location}" placeholder="e.g. 123 Cinema Street, Colombo">
                        </div>
                        <div class="mb-4">
                            <label class="form-label">Total Screens</label>
                            <input type="number" name="totalScreens" class="form-control"
                                   value="${theater.totalScreens}" placeholder="e.g. 3">
                        </div>

                        <div class="d-flex gap-3">
                            <button type="submit" class="btn btn-save">
                                <i class="bi bi-check-circle"></i> Save Theater
                            </button>
                            <a href="${pageContext.request.contextPath}/theater?action=list" class="btn-cancel">
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