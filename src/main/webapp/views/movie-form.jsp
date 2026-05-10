<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${movie == null ? 'Add Movie' : 'Edit Movie'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>${movie == null ? 'Add New Movie' : 'Edit Movie'}</h2>

    <form action="${pageContext.request.contextPath}/movies" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="${movie == null ? 'add' : 'update'}">
        <input type="hidden" name="id" value="${movie.id}">

        <div class="mb-3">
            <label>Title</label>
            <input type="text" name="title" class="form-control" value="${movie.title}" required>
        </div>
        <div class="mb-3">
            <label>Genre</label>
            <input type="text" name="genre" class="form-control" value="${movie.genre}">
        </div>
        <div class="mb-3">
            <label>Duration (minutes)</label>
            <input type="number" name="duration" class="form-control" value="${movie.duration}">
        </div>
        <div class="mb-3">
            <label>Language</label>
            <input type="text" name="language" class="form-control" value="${movie.language}">
        </div>
        <div class="mb-3">
            <label>Release Date</label>
            <input type="date" name="releaseDate" class="form-control" value="${movie.releaseDate}">
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control">${movie.description}</textarea>
        </div>

        <div class="mb-3">
            <label>Upload Poster Image</label>
            <input type="file" name="posterFile" class="form-control" accept="image/*">
            <small class="text-muted">Upload a poster image (JPG, PNG)</small>
            <c:if test="${not empty movie.posterPath}">
                <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                     style="height:100px; margin-top:10px;" class="d-block">
            </c:if>
        </div>

        <div class="mb-3">
            <label>Or Poster URL (paste image link)</label>
            <input type="text" name="posterUrl" class="form-control" value="${movie.posterUrl}"
                   placeholder="https://example.com/poster.jpg">
        </div>

        <div class="mb-3">
            <label>Trailer YouTube URL</label>
            <input type="text" name="trailerUrl" class="form-control" value="${movie.trailerUrl}"
                   placeholder="https://www.youtube.com/embed/xxxxxx">
            <small class="text-muted">Go to YouTube → Share → Embed → copy the URL after src=</small>
        </div>

        <div class="mb-3">
            <label>Status</label>
            <select name="status" class="form-select">
                <option value="now_showing" ${movie.status == 'now_showing' ? 'selected' : ''}>Now Showing</option>
                <option value="coming_soon" ${movie.status == 'coming_soon' ? 'selected' : ''}>Coming Soon</option>
                <option value="ended" ${movie.status == 'ended' ? 'selected' : ''}>Ended</option>
            </select>
        </div>

        <button type="submit" class="btn btn-primary">Save</button>
        <a href="${pageContext.request.contextPath}/movies?action=list" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>