<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movies</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h2>Movies</h2>

    <%-- Search Bar --%>
   <form action="${pageContext.request.contextPath}/movies" method="get" class="d-flex mb-3">
        <input type="hidden" name="action" value="list">
        <input type="text" name="search" class="form-control me-2" placeholder="Search by title...">
        <button type="submit" class="btn btn-primary">Search</button>
    </form>

    <%-- Admin: Add New Movie button --%>
    <a href="${pageContext.request.contextPath}/movies?action=new" class="btn btn-success mb-3">+ Add Movie</a>

    <%-- Movie Table --%>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Title</th><th>Genre</th><th>Duration</th>
                <th>Language</th><th>Status</th><th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="movie" items="${movies}">
                <tr>
                    <td>${movie.title}</td>
                    <td>${movie.genre}</td>
                    <td>${movie.duration} min</td>
                    <td>${movie.language}</td>
                    <td>${movie.status}</td>
                    <td>
                        <a href="movies?action=detail&id=${movie.id}" class="btn btn-info btn-sm">View</a>
                        <a href="movies?action=edit&id=${movie.id}" class="btn btn-warning btn-sm">Edit</a>
                        <a href="movies?action=delete&id=${movie.id}"
                           onclick="return confirm('Delete this movie?')"
                           class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>