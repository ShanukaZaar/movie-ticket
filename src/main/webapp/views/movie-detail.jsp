<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>${movie.title} - CineBook</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
            <style>
                body {
                    background: #0a0a0a;
                    color: #fff;
                    min-height: 100vh;
                }

                .movie-hero {
                    background: linear-gradient(135deg, #1a0000, #0a0a0a);
                    padding: 60px 0;
                    border-bottom: 1px solid #222;
                }

                .movie-poster {
                    border-radius: 15px;
                    box-shadow: 0 20px 60px rgba(229, 9, 20, 0.3);
                    width: 100%;
                    max-width: 320px;
                    height: 420px;
                    object-fit: cover;
                }

                .no-poster-detail {
                    width: 100%;
                    max-width: 320px;
                    height: 420px;
                    background: linear-gradient(135deg, #222, #333);
                    border-radius: 15px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 8rem;
                }

                .movie-title {
                    font-size: 2.5rem;
                    font-weight: 900;
                    margin-bottom: 10px;
                }

                .badge-now {
                    background: #e50914;
                    color: #fff;
                    padding: 5px 15px;
                    border-radius: 20px;
                    font-size: 0.85rem;
                }

                .badge-soon {
                    background: #f39c12;
                    color: #fff;
                    padding: 5px 15px;
                    border-radius: 20px;
                    font-size: 0.85rem;
                }

                .badge-ended {
                    background: #555;
                    color: #fff;
                    padding: 5px 15px;
                    border-radius: 20px;
                    font-size: 0.85rem;
                }

                .info-item {
                    display: flex;
                    align-items: center;
                    gap: 10px;
                    margin-bottom: 12px;
                    color: #ccc;
                }

                .info-item i {
                    color: #e50914;
                    font-size: 1.1rem;
                    width: 20px;
                }

                .info-item strong {
                    color: #fff;
                }

                .btn-book {
                    background: #e50914;
                    border: none;
                    color: #fff;
                    border-radius: 30px;
                    padding: 12px 35px;
                    font-size: 1rem;
                    font-weight: 700;
                    transition: all 0.3s;
                }

                .btn-book:hover {
                    background: #b20710;
                    transform: scale(1.05);
                    color: #fff;
                }

                .btn-back {
                    background: transparent;
                    border: 2px solid #555;
                    color: #aaa;
                    border-radius: 30px;
                    padding: 12px 35px;
                    font-size: 1rem;
                    transition: all 0.3s;
                }

                .btn-back:hover {
                    border-color: #fff;
                    color: #fff;
                }

                .btn-admin {
                    background: #f39c12;
                    border: none;
                    color: #fff;
                    border-radius: 30px;
                    padding: 10px 25px;
                    font-weight: 600;
                    transition: all 0.3s;
                }

                .btn-admin:hover {
                    background: #d68910;
                    color: #fff;
                }

                .btn-admin-delete {
                    background: #333;
                    border: none;
                    color: #fff;
                    border-radius: 30px;
                    padding: 10px 25px;
                    font-weight: 600;
                    transition: all 0.3s;
                }

                .btn-admin-delete:hover {
                    background: #e50914;
                    color: #fff;
                }

                .description-section {
                    background: #111;
                    border-radius: 15px;
                    padding: 25px;
                    margin-top: 30px;
                    border: 1px solid #222;
                }

                .trailer-section {
                    background: #111;
                    border-radius: 15px;
                    padding: 25px;
                    margin-top: 20px;
                    border: 1px solid #222;
                }

                .trailer-section h4 {
                    color: #e50914;
                    font-weight: 700;
                    margin-bottom: 20px;
                }

                .trailer-section iframe {
                    border-radius: 10px;
                    width: 100%;
                    height: 400px;
                }

                .reservation-section {
                    background: linear-gradient(135deg, #1a0000, #0a0000);
                    border: 2px solid #e50914;
                    border-radius: 15px;
                    padding: 30px;
                    margin-top: 20px;
                    text-align: center;
                }

                .reservation-section h4 {
                    color: #e50914;
                    font-weight: 700;
                }
            </style>
        </head>

        <body>

            <%-- Navbar --%>
                <c:set var="currentPage" value="movies" scope="request" />
                <%@ include file="navbar.jsp" %>

                    <%-- Movie Hero --%>
                        <div class="movie-hero">
                            <div class="container">
                                <div class="row g-5 align-items-start">

                                    <%-- Poster --%>
                                        <div class="col-md-4 text-center text-md-start">
                                            <c:choose>
                                                <c:when test="${not empty movie.posterPath}">
                                                    <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                        alt="${movie.title}" class="movie-poster">
                                                </c:when>
                                                <c:when test="${not empty movie.posterUrl}">
                                                    <img src="${movie.posterUrl}" alt="${movie.title}"
                                                        class="movie-poster" onerror="this.style.display='none'">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-poster-detail">🎬</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <%-- Info --%>
                                            <div class="col-md-8">
                                                <div class="mb-3">
                                                    <c:choose>
                                                        <c:when test="${movie.status == 'now_showing'}"><span
                                                                class="badge-now">Now Showing</span></c:when>
                                                        <c:when test="${movie.status == 'coming_soon'}"><span
                                                                class="badge-soon">Coming Soon</span></c:when>
                                                        <c:otherwise><span class="badge-ended">Ended</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                                <h1 class="movie-title">${movie.title}</h1>

                                                <div class="mt-3">
                                                    <div class="info-item"><i
                                                            class="bi bi-film"></i><span><strong>Genre:</strong>
                                                            ${movie.genre}</span></div>
                                                    <div class="info-item"><i
                                                            class="bi bi-clock"></i><span><strong>Duration:</strong>
                                                            ${movie.duration} minutes</span></div>
                                                    <div class="info-item"><i
                                                            class="bi bi-translate"></i><span><strong>Language:</strong>
                                                            ${movie.language}</span></div>
                                                    <div class="info-item"><i
                                                            class="bi bi-calendar3"></i><span><strong>Release
                                                                Date:</strong> ${movie.releaseDate}</span></div>
                                                </div>

                                                <div class="mt-4 d-flex flex-wrap gap-2">
                                                    <%-- Book Now - only for logged in customers --%>
                                                        <c:if test="${movie.status == 'now_showing'}">
                                                            <c:choose>
                                                                <c:when test="${sessionScope.user != null}">
                                                                    <a href="#reservation" class="btn btn-book">
                                                                        <i class="bi bi-ticket-perforated"></i> Book
                                                                        Tickets
                                                                    </a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <a href="${pageContext.request.contextPath}/login"
                                                                        class="btn btn-book">
                                                                        <i class="bi bi-ticket-perforated"></i> Login to
                                                                        Book
                                                                    </a>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:if>

                                                        <%-- Admin buttons --%>
                                                            <c:if test="${sessionScope.userRole == 'admin'}">
                                                                <a href="${pageContext.request.contextPath}/movies?action=edit&id=${movie.id}"
                                                                    class="btn btn-admin">
                                                                    <i class="bi bi-pencil"></i> Edit Movie
                                                                </a>
                                                                <a href="${pageContext.request.contextPath}/movies?action=delete&id=${movie.id}"
                                                                    class="btn btn-admin-delete"
                                                                    onclick="return confirm('Delete this movie?')">
                                                                    <i class="bi bi-trash"></i> Delete
                                                                </a>
                                                            </c:if>

                                                            <a href="${pageContext.request.contextPath}/movies?action=list"
                                                                class="btn btn-back">
                                                                <i class="bi bi-arrow-left"></i> Back
                                                            </a>
                                                </div>
                                            </div>
                                </div>

                                <%-- Description --%>
                                    <c:if test="${not empty movie.description}">
                                        <div class="description-section mt-4">
                                            <h5><i class="bi bi-info-circle" style="color:#e50914;"></i> About the Movie
                                            </h5>
                                            <p style="color:#ccc; margin:0; line-height:1.8;">${movie.description}</p>
                                        </div>
                                    </c:if>

                                    <%-- Trailer --%>
                                        <c:if test="${not empty movie.trailerUrl}">
                                            <div class="trailer-section">
                                                <h4><i class="bi bi-play-circle"></i> Official Trailer</h4>
                                                <iframe src="${movie.trailerUrl}" frameborder="0" width="100%"
                                                    height="400"
                                                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                                    allowfullscreen>
                                                </iframe>
                                            </div>
                                        </c:if>

                                        <%-- Reservation Section --%>
                                            <c:if test="${movie.status == 'now_showing'}">
                                                <div class="reservation-section" id="reservation">
                                                    <h4><i class="bi bi-ticket-perforated"></i> Book Your Tickets</h4>
                                                    <p style="color:#ccc;">Select a show time for ${movie.title}</p>
                                                    <c:choose>
                                                        <c:when test="${sessionScope.user != null}">
                                                            <a href="${pageContext.request.contextPath}/booking?action=shows&movieId=${movie.id}"
                                                                class="btn btn-book mt-2">
                                                                <i class="bi bi-calendar-check"></i> View Available
                                                                Shows
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p style="color:#aaa;">Please login to book tickets.</p>
                                                            <a href="${pageContext.request.contextPath}/login"
                                                                class="btn btn-book mt-2">
                                                                <i class="bi bi-box-arrow-in-right"></i> Login to Book
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:if>

                                            <%-- Footer --%>
                                                <footer
                                                    style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555; margin-top:0;">
                                                    <p>© 2024 CineBook. All rights reserved.</p>
                                                </footer>

                                                <script
                                                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>