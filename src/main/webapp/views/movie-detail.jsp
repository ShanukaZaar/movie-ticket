<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${movie.title}</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>${movie.title}</h2>

    <%-- Show uploaded poster --%>
    <c:if test="${not empty movie.posterPath}">
        <img src="${pageContext.request.contextPath}/${movie.posterPath}"
        onerror="this.style.display='none'"
        alt="Poster" style="max-height:300px;" class="mb-3 d-block">
    </c:if>

    <%-- Show poster URL if no uploaded poster --%>
    <c:if test="${empty movie.posterPath and not empty movie.posterUrl}">
        <img src="${movie.posterUrl}"
             alt="Poster" style="max-height:300px;" class="mb-3 d-block">
    </c:if>

    <p><strong>Genre:</strong> ${movie.genre}</p>
    <p><strong>Duration:</strong> ${movie.duration} minutes</p>
    <p><strong>Language:</strong> ${movie.language}</p>
    <p><strong>Release Date:</strong> ${movie.releaseDate}</p>
    <p><strong>Status:</strong> ${movie.status}</p>
    <p><strong>Description:</strong> ${movie.description}</p>

    <%-- Show trailer --%>
    <c:if test="${not empty movie.trailerUrl}">
        <h4 class="mt-4">Trailer</h4>
        <iframe width="560" height="315"
                src="${movie.trailerUrl}"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
        </iframe>
    </c:if>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/movies?action=edit&id=${movie.id}"
           class="btn btn-warning">Edit</a>
        <a href="${pageContext.request.contextPath}/movies?action=list"
           class="btn btn-secondary">Back to List</a>
    </div>
</div>
</body>
</html>