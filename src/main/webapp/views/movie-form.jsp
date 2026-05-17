<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${movie == null ? 'Add Movie' : 'Edit Movie'} - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .form-section { padding: 50px 0; }
        .form-card { background: #1a1a1a; border-radius: 20px; border: 1px solid #333; padding: 40px; }
        .form-card h2 { font-weight: 900; margin-bottom: 30px; }
        .form-card h2 span { color: #e50914; }
        .form-label { color: #ccc; font-weight: 500; }
        .form-control, .form-select { background: #111; border: 2px solid #333; color: #fff; border-radius: 10px; padding: 12px 15px; }
        .form-control:focus, .form-select:focus { background: #111; border-color: #e50914; color: #fff; box-shadow: 0 0 0 0.25rem rgba(229,9,20,0.25); }
        .form-select option { background: #111; }
        .form-control::placeholder { color: #555; }
        .btn-save { background: #e50914; border: none; color: #fff; border-radius: 30px; padding: 12px 40px; font-weight: 700; font-size: 1rem; transition: all 0.3s; }
        .btn-save:hover { background: #b20710; color: #fff; transform: scale(1.05); }
        .btn-cancel { background: transparent; border: 2px solid #555; color: #aaa; border-radius: 30px; padding: 12px 40px; font-weight: 700; font-size: 1rem; transition: all 0.3s; }
        .btn-cancel:hover { border-color: #fff; color: #fff; }
        .section-divider { border-color: #333; margin: 25px 0; }
        .current-poster { border-radius: 10px; max-height: 150px; border: 2px solid #333; }
        small { color: #666; }
    </style>
</head>
<body>

<%-- Navbar --%>
<c:set var="currentPage" value="movies" scope="request"/>
<%@ include file="navbar.jsp" %>

<div class="form-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="form-card">
                    <h2>${movie == null ? 'Add New <span>Movie</span>' : ' Edit <span>Movie</span>'}</h2>

                    <form action="${pageContext.request.contextPath}/movies" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="${movie == null ? 'add' : 'update'}">
                        <input type="hidden" name="id" value="${movie.id}">

                        <%-- Basic Info --%>
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label">Movie Title *</label>
                                <input type="text" name="title" class="form-control"
                                       value="${movie.title}" placeholder="Enter movie title" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Genre</label>
                                <input type="text" name="genre" class="form-control"
                                       value="${movie.genre}" placeholder="e.g. Action, Drama">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Duration (minutes)</label>
                                <input type="number" name="duration" class="form-control"
                                       value="${movie.duration}" placeholder="e.g. 120">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Language</label>
                                <input type="text" name="language" class="form-control"
                                       value="${movie.language}" placeholder="e.g. English, Sinhala">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Release Date</label>
                                <input type="date" name="releaseDate" class="form-control"
                                       value="${movie.releaseDate}">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Status</label>
                                <select name="status" class="form-select">
                                    <option value="now_showing" ${movie.status == 'now_showing' ? 'selected' : ''}>Now Showing</option>
                                    <option value="coming_soon" ${movie.status == 'coming_soon' ? 'selected' : ''}>Coming Soon</option>
                                    <option value="ended" ${movie.status == 'ended' ? 'selected' : ''}>Ended</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Description</label>
                                <textarea name="description" class="form-control" rows="4"
                                          placeholder="Enter movie description...">${movie.description}</textarea>
                            </div>
                        </div>

                        <hr class="section-divider">

                        <%-- Poster --%>
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label"><i class="bi bi-image" style="color:#e50914;"></i> Movie Poster</label>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Upload Poster Image</label>
                                <input type="file" name="posterFile" class="form-control" accept="image/*">
                                <small>JPG, PNG recommended</small>
                                <c:if test="${not empty movie.posterPath}">
                                    <div class="mt-2">
                                        <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                             class="current-poster" alt="Current poster">
                                        <small class="d-block mt-1">Current poster</small>
                                    </div>
                                </c:if>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Or Poster URL</label>
                                <input type="text" name="posterUrl" class="form-control"
                                       value="${movie.posterUrl}"
                                       placeholder="https://example.com/poster.jpg">
                                <small>Paste an image link from the web</small>
                            </div>
                        </div>

                        <hr class="section-divider">

                        <%-- Trailer --%>
                        <div class="mb-3">
                            <label class="form-label"><i class="bi bi-play-circle" style="color:#e50914;"></i> Trailer</label>
                            <input type="text" name="trailerUrl" class="form-control"
                                   value="${movie.trailerUrl}"
                                   placeholder="https://www.youtube.com/embed/xxxxxx">
                            <small>Go to YouTube → Share → Embed → copy the URL from src=""</small>
                        </div>

                        <%-- Buttons --%>
                        <div class="d-flex gap-3 mt-4">
                            <button type="submit" class="btn btn-save">
                                <i class="bi bi-check-circle"></i> Save Movie
                            </button>
                            <a href="${pageContext.request.contextPath}/movies?action=list" class="btn btn-cancel">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555; margin-top:20px;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
