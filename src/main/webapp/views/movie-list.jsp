<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movies - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }

        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 60px 0 40px; border-bottom: 2px solid #e50914; }
        .page-header h1 { font-size: 2.5rem; font-weight: 900; }
        .page-header h1 span { color: #e50914; }

        .search-bar .form-control { background: #1a1a1a; border: 2px solid #333; color: #fff; border-radius: 30px 0 0 30px; padding: 12px 20px; }
        .search-bar .form-control:focus { border-color: #e50914; box-shadow: none; background: #1a1a1a; color: #fff; }
        .search-bar .btn-search { background: #e50914; border: none; color: #fff; border-radius: 0 30px 30px 0; padding: 12px 25px; font-weight: 700; }
        .search-bar .btn-search:hover { background: #b20710; }

        .btn-add { background: #e50914; border: none; color: #fff; border-radius: 30px; padding: 10px 25px; font-weight: 700; transition: all 0.3s; }
        .btn-add:hover { background: #b20710; transform: scale(1.05); color: #fff; }

        .filter-btn { background: #1a1a1a; border: 2px solid #333; color: #aaa; border-radius: 20px; padding: 6px 18px; font-size: 0.85rem; cursor: pointer; transition: all 0.3s; margin: 3px; }
        .filter-btn:hover, .filter-btn.active { border-color: #e50914; color: #e50914; }

        .movie-card { background: #1a1a1a; border-radius: 15px; overflow: hidden; transition: all 0.3s; border: 1px solid #222; height: 100%; }
        .movie-card:hover { transform: translateY(-8px); border-color: #e50914; box-shadow: 0 20px 40px rgba(229,9,20,0.2); }
        .movie-card img { width: 100%; height: 320px; object-fit: cover; }
        .no-poster { width: 100%; height: 320px; background: linear-gradient(135deg, #222, #333); display: flex; align-items: center; justify-content: center; font-size: 5rem; }
        .card-body { padding: 15px; }
        .movie-title { font-weight: 700; font-size: 1rem; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .movie-genre { color: #aaa; font-size: 0.85rem; }
        .badge-now { background: #e50914; color: #fff; padding: 3px 10px; border-radius: 20px; font-size: 0.75rem; }
        .badge-soon { background: #f39c12; color: #fff; padding: 3px 10px; border-radius: 20px; font-size: 0.75rem; }
        .badge-ended { background: #555; color: #fff; padding: 3px 10px; border-radius: 20px; font-size: 0.75rem; }

        .btn-view { background: #e50914; border: none; color: #fff; border-radius: 8px; padding: 7px 15px; font-size: 0.85rem; font-weight: 600; transition: all 0.3s; width: 100%; }
        .btn-view:hover { background: #b20710; color: #fff; }
        .btn-edit { background: #f39c12; border: none; color: #fff; border-radius: 8px; padding: 7px 10px; font-size: 0.85rem; transition: all 0.3s; }
        .btn-edit:hover { background: #d68910; color: #fff; }
        .btn-delete { background: #333; border: none; color: #fff; border-radius: 8px; padding: 7px 10px; font-size: 0.85rem; transition: all 0.3s; }
        .btn-delete:hover { background: #e50914; color: #fff; }

        .movies-section { padding: 40px 0; }
        .results-count { color: #aaa; font-size: 0.9rem; margin-bottom: 20px; }

        .empty-state { text-align: center; padding: 80px 0; color: #aaa; }
        .empty-state i { font-size: 5rem; color: #333; display: block; margin-bottom: 20px; }
    </style>
</head>
<body>

<%-- Include Navbar --%>
<c:set var="currentPage" value="movies" scope="request"/>
<%@ include file="navbar.jsp" %>

<%-- Page Header --%>
<div class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1>All <span>Movies</span></h1>
                <p style="color:#aaa;">Discover and book your favorite movies</p>
            </div>
            <div class="col-md-6">
                <%-- Search Bar --%>
                <form action="${pageContext.request.contextPath}/movies" method="get" class="search-bar">
                    <input type="hidden" name="action" value="list">
                    <div class="input-group">
                        <input type="text" name="search" class="form-control"
                               placeholder="Search movies..." value="${param.search}">
                        <button type="submit" class="btn-search">
                            <i class="bi bi-search"></i> Search
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <%-- Admin Add Button --%>
        <c:if test="${sessionScope.userRole == 'admin'}">
            <div class="mt-3">
                <a href="${pageContext.request.contextPath}/movies?action=new" class="btn-add">
                    <i class="bi bi-plus-circle"></i> Add New Movie
                </a>
            </div>
        </c:if>
    </div>
</div>

<%-- Movies Grid --%>
<section class="movies-section">
    <div class="container">

        <p class="results-count">
            <i class="bi bi-film"></i>
            Showing <strong>${movies.size()}</strong> movies
            <c:if test="${not empty param.search}">
                for "<strong>${param.search}</strong>"
            </c:if>
        </p>

        <c:choose>
            <c:when test="${not empty movies}">
                <div class="row g-4">
                    <c:forEach var="movie" items="${movies}">
                        <div class="col-6 col-md-4 col-lg-3">
                            <div class="movie-card">
                                <%-- Poster --%>
                                <c:choose>
                                    <c:when test="${not empty movie.posterPath}">
                                        <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                             alt="${movie.title}"
                                             onerror="this.parentElement.innerHTML='<div class=\'no-poster\'>🎬</div>'">
                                    </c:when>
                                    <c:when test="${not empty movie.posterUrl}">
                                        <img src="${movie.posterUrl}" alt="${movie.title}"
                                             onerror="this.parentElement.innerHTML='<div class=\'no-poster\'>🎬</div>'">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-poster">🎬</div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="card-body">
                                    <div class="movie-title">${movie.title}</div>
                                    <div class="movie-genre">${movie.genre} • ${movie.duration} min</div>
                                    <div class="my-2">
                                        <c:choose>
                                            <c:when test="${movie.status == 'now_showing'}">
                                                <span class="badge-now">Now Showing</span>
                                            </c:when>
                                            <c:when test="${movie.status == 'coming_soon'}">
                                                <span class="badge-soon">Coming Soon</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-ended">Ended</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <%-- Buttons --%>
                                    <div class="d-flex gap-1 mt-2">
                                        <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                           class="btn-view">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                        <%-- Admin only buttons --%>
                                        <c:if test="${sessionScope.userRole == 'admin'}">
                                            <a href="${pageContext.request.contextPath}/movies?action=edit&id=${movie.id}"
                                               class="btn-edit">
                                                <i class="bi bi-pencil"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/movies?action=delete&id=${movie.id}"
                                               class="btn-delete"
                                               onclick="return confirm('Delete this movie?')">
                                                <i class="bi bi-trash"></i>
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="bi bi-film"></i>
                    <h4>No movies found</h4>
                    <p>Try a different search term</p>
                    <a href="${pageContext.request.contextPath}/movies?action=list"
                       class="btn" style="background:#e50914; color:#fff; border-radius:25px; padding:10px 30px;">
                        View All Movies
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<%-- Footer --%>
<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555; margin-top:40px;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>