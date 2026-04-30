<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>${movie.title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>${movie.title}</h2>
    <img src="${movie.posterUrl}" alt="Poster" style="max-height:300px;" class="mb-3">
    <p><strong>Genre:</strong> ${movie.genre}</p>
    <p><strong>Duration:</strong> ${movie.duration} minutes</p>
    <p><strong>Language:</strong> ${movie.language}</p>
    <p><strong>Release Date:</strong> ${movie.releaseDate}</p>
    <p><strong>Status:</strong> ${movie.status}</p>
    <p><strong>Description:</strong> ${movie.description}</p>

    <a href="movies?action=edit&id=${movie.id}" class="btn btn-warning">Edit</a>
    <a href="movies?action=list" class="btn btn-secondary">Back to List</a>
</div>
</body>
</html>