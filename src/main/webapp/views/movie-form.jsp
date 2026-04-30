<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>${movie == null ? 'Add Movie' : 'Edit Movie'}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>${movie == null ? 'Add New Movie' : 'Edit Movie'}</h2>

    <form action="movies" method="post">
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
            <label>Poster URL</label>
            <input type="text" name="posterUrl" class="form-control" value="${movie.posterUrl}">
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
        <a href="movies?action=list" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>