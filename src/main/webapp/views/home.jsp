<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>CineBook - Movie Ticket Reservation</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', sans-serif;
                    background: #0a0a0a;
                    color: #fff;
                }

                .hero {
                    height: 100vh;
                    background: linear-gradient(135deg, #0a0a0a 0%, #1a0a0a 50%, #0a0a1a 100%);
                    display: flex;
                    align-items: center;
                    position: relative;
                    overflow: hidden;
                }

                .hero::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background: url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=1920') center/cover;
                    opacity: 0.15;
                }

                .hero-content {
                    position: relative;
                    z-index: 1;
                }

                .hero h1 {
                    font-size: 4rem;
                    font-weight: 900;
                    line-height: 1.1;
                }

                .hero h1 span {
                    color: #e50914;
                }

                .hero p {
                    font-size: 1.3rem;
                    color: #ccc;
                    margin: 20px 0;
                }

                .btn-book {
                    background: #e50914;
                    color: #fff;
                    border: none;
                    padding: 15px 40px;
                    border-radius: 50px;
                    font-size: 1.1rem;
                    font-weight: 700;
                    transition: all 0.3s;
                    text-decoration: none;
                    display: inline-block;
                }

                .btn-book:hover {
                    background: #b20710;
                    transform: scale(1.05);
                    color: #fff;
                }

                .btn-explore {
                    background: transparent;
                    color: #fff;
                    border: 2px solid #fff;
                    padding: 15px 40px;
                    border-radius: 50px;
                    font-size: 1.1rem;
                    font-weight: 700;
                    transition: all 0.3s;
                    margin-left: 15px;
                    text-decoration: none;
                    display: inline-block;
                }

                .btn-explore:hover {
                    background: #fff;
                    color: #000;
                }

                .stats-bar {
                    background: #e50914;
                    padding: 20px 0;
                }

                .stat-item {
                    text-align: center;
                }

                .stat-item h3 {
                    font-size: 2rem;
                    font-weight: 900;
                }

                .stat-item p {
                    font-size: 0.9rem;
                    opacity: 0.9;
                    margin: 0;
                }

                .section-title {
                    font-size: 2rem;
                    font-weight: 800;
                    margin-bottom: 30px;
                }

                .section-title span {
                    color: #e50914;
                }

                .now-showing-section {
                    background: #111;
                    padding: 60px 0;
                }

                .coming-soon-section {
                    background: #0d0d0d;
                    padding: 60px 0;
                }

                .movie-card {
                    background: #1a1a1a;
                    border-radius: 12px;
                    overflow: hidden;
                    transition: transform 0.3s;
                    cursor: pointer;
                    height: 100%;
                    border: 1px solid #222;
                }

                .movie-card:hover {
                    transform: translateY(-10px);
                    border-color: #e50914;
                }

                .movie-card img {
                    width: 100%;
                    height: 280px;
                    object-fit: cover;
                }

                .no-poster {
                    width: 100%;
                    height: 280px;
                    background: linear-gradient(135deg, #222, #333);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 4rem;
                }

                .card-info {
                    padding: 15px;
                }

                .card-info h6 {
                    font-weight: 700;
                    margin-bottom: 5px;
                    white-space: nowrap;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }

                .genre {
                    color: #aaa;
                    font-size: 0.85rem;
                }

                .badge-now {
                    background: #e50914;
                    color: #fff;
                    padding: 3px 10px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                }

                .badge-soon {
                    background: #f39c12;
                    color: #fff;
                    padding: 3px 10px;
                    border-radius: 20px;
                    font-size: 0.75rem;
                }

                .empty-section {
                    text-align: center;
                    padding: 40px 0;
                    color: #aaa;
                }

                .empty-section i {
                    font-size: 3rem;
                    color: #333;
                    display: block;
                    margin-bottom: 10px;
                }

                .services-section {
                    background: #0a0a0a;
                    padding: 60px 0;
                }

                .service-card {
                    background: #1a1a1a;
                    border-radius: 15px;
                    padding: 30px;
                    text-align: center;
                    transition: all 0.3s;
                    border: 1px solid #222;
                    height: 100%;
                }

                .service-card:hover {
                    border-color: #e50914;
                    transform: translateY(-5px);
                }

                .service-icon {
                    font-size: 3rem;
                    color: #e50914;
                    margin-bottom: 15px;
                }

                .service-card h5 {
                    font-weight: 700;
                    margin-bottom: 10px;
                }

                .service-card p {
                    color: #aaa;
                    font-size: 0.9rem;
                }

                .quicklinks-section {
                    background: #111;
                    padding: 60px 0;
                }

                .quick-btn {
                    display: block;
                    background: #1a1a1a;
                    border: 2px solid #333;
                    color: #fff;
                    border-radius: 12px;
                    padding: 20px;
                    text-align: center;
                    text-decoration: none;
                    transition: all 0.3s;
                    margin-bottom: 15px;
                }

                .quick-btn:hover {
                    border-color: #e50914;
                    color: #e50914;
                    transform: scale(1.03);
                }

                .quick-btn i {
                    font-size: 2rem;
                    display: block;
                    margin-bottom: 8px;
                }

                .quick-btn span {
                    font-weight: 600;
                    font-size: 0.9rem;
                }

                .footer {
                    background: #000;
                    padding: 50px 0 20px;
                    border-top: 3px solid #e50914;
                }

                .footer h5 {
                    color: #e50914;
                    font-weight: 700;
                    margin-bottom: 20px;
                }

                .footer p {
                    color: #aaa;
                    font-size: 0.9rem;
                }

                .footer a {
                    color: #aaa;
                    text-decoration: none;
                    display: block;
                    margin-bottom: 8px;
                    font-size: 0.9rem;
                    transition: color 0.3s;
                }

                .footer a:hover {
                    color: #e50914;
                }

                .social-icon {
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: #1a1a1a;
                    color: #fff;
                    margin-right: 10px;
                    font-size: 1.2rem;
                    text-decoration: none;
                    transition: all 0.3s;
                }

                .social-icon:hover {
                    background: #e50914;
                    color: #fff;
                    transform: scale(1.1);
                }

                .footer-bottom {
                    border-top: 1px solid #222;
                    margin-top: 30px;
                    padding-top: 20px;
                    text-align: center;
                    color: #555;
                    font-size: 0.85rem;
                }

                .carousel-inner {
                    border-radius: 15px;
                }

                /* Movie Slider */
                .movies-slider {
                    display: flex;
                    gap: 15px;
                    overflow-x: auto;
                    padding-bottom: 15px;
                    scroll-behavior: smooth;
                    scrollbar-width: thin;
                    scrollbar-color: #e50914 #1a1a1a;
                }

                .movies-slider::-webkit-scrollbar {
                    height: 5px;
                }

                .movies-slider::-webkit-scrollbar-track {
                    background: #1a1a1a;
                    border-radius: 5px;
                }

                .movies-slider::-webkit-scrollbar-thumb {
                    background: #e50914;
                    border-radius: 5px;
                }

                .slide-item {
                    min-width: 200px;
                    max-width: 200px;
                    flex-shrink: 0;
                }

                .empty-section {
                    text-align: center;
                    padding: 40px 0;
                    color: #aaa;
                }

                .empty-section i {
                    font-size: 3rem;
                    color: #333;
                    display: block;
                    margin-bottom: 10px;
                }

                .movie-card img {
                    height: 260px;
                }

                .no-poster {
                    height: 260px;
                }
            </style>
            </style>
        </head>

        <body>

            <%-- Shared Navbar --%>
                <c:set var="currentPage" value="home" scope="request" />
                <%@ include file="navbar.jsp" %>

                    <%-- Hero Banner --%>
                        <section class="hero">
                            <div class="container hero-content">
                                <div class="row align-items-center">
                                    <div class="col-lg-7">
                                        <p
                                            style="color:#e50914; font-weight:700; letter-spacing:3px; text-transform:uppercase;">
                                            Welcome to CineBook
                                        </p>
                                        <h1>Experience <span>Cinema</span> Like Never Before</h1>
                                        <p>Book your favorite movie tickets online. Choose your seats, pick your
                                            showtime,
                                            and enjoy the magic of movies.</p>
                                        <a href="${pageContext.request.contextPath}/movies?action=list"
                                            class="btn-book">
                                            Book Now
                                        </a>
                                        <a href="#now-showing" class="btn-explore">Explore Movies</a>
                                    </div>
                                    <div class="col-lg-5 d-none d-lg-block text-center">
                                        <div style="font-size:15rem; opacity:0.3;">🎭</div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <%-- Stats Bar --%>
                            <div class="stats-bar">
                                <div class="container">
                                    <div class="row">
                                        <div class="col-3 stat-item">
                                            <h3>50+</h3>
                                            <p>Movies</p>
                                        </div>
                                        <div class="col-3 stat-item">
                                            <h3>10+</h3>
                                            <p>Theaters</p>
                                        </div>
                                        <div class="col-3 stat-item">
                                            <h3>5000+</h3>
                                            <p>Happy Customers</p>
                                        </div>
                                        <div class="col-3 stat-item">
                                            <h3>24/7</h3>
                                            <p>Support</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- Now Showing Section --%>
                                <section class="now-showing-section" id="now-showing">
                                    <div class="container">
                                        <div class="d-flex justify-content-between align-items-center mb-4">
                                            <h2 class="section-title mb-0">Now <span>Showing</span></h2>
                                            <a href="${pageContext.request.contextPath}/movies?action=list"
                                                style="color:#e50914; text-decoration:none; font-weight:600; font-size:0.9rem;">
                                                View All <i class="bi bi-chevron-right"></i>
                                            </a>
                                        </div>

                                        <c:set var="hasNowShowing" value="false" />
                                        <c:forEach var="movie" items="${movies}">
                                            <c:if test="${movie.status == 'now_showing'}">
                                                <c:set var="hasNowShowing" value="true" />
                                            </c:if>
                                        </c:forEach>

                                        <c:choose>
                                            <c:when test="${hasNowShowing == 'true'}">
                                                <div class="movies-slider" id="nowShowingSlider">
                                                    <c:forEach var="movie" items="${movies}">
                                                        <c:if test="${movie.status == 'now_showing'}">
                                                            <div class="slide-item">
                                                                <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                                                    style="text-decoration:none; color:inherit;">
                                                                    <div class="movie-card">
                                                                        <c:choose>
                                                                            <c:when
                                                                                test="${not empty movie.posterPath}">
                                                                                <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                                                    alt="${movie.title}">
                                                                            </c:when>
                                                                            <c:when test="${not empty movie.posterUrl}">
                                                                                <img src="${movie.posterUrl}"
                                                                                    alt="${movie.title}"
                                                                                    onerror="this.style.display='none'">
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <div class="no-poster"><i
                                                                                        class="bi bi-film"></i></div>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                        <div class="card-info">
                                                                            <h6>${movie.title}</h6>
                                                                            <span class="genre">${movie.genre} •
                                                                                ${movie.duration} min</span><br>
                                                                            <span class="badge-now">Now Showing</span>
                                                                        </div>
                                                                    </div>
                                                                </a>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="empty-section">
                                                    <i class="bi bi-camera-reels"></i>
                                                    <p>No movies currently showing</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="text-center mt-4">
                                            <a href="${pageContext.request.contextPath}/movies?action=list"
                                                class="btn-book">
                                                View All Now Showing
                                            </a>
                                        </div>
                                    </div>
                                </section>

                                <%-- Coming Soon Section --%>
                                    <section class="coming-soon-section" id="coming-soon">
                                        <div class="container">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h2 class="section-title mb-0">Coming <span>Soon</span></h2>
                                                <a href="${pageContext.request.contextPath}/movies?action=list"
                                                    style="color:#f39c12; text-decoration:none; font-weight:600; font-size:0.9rem;">
                                                    View All <i class="bi bi-chevron-right"></i>
                                                </a>
                                            </div>

                                            <c:set var="hasComingSoon" value="false" />
                                            <c:forEach var="movie" items="${movies}">
                                                <c:if test="${movie.status == 'coming_soon'}">
                                                    <c:set var="hasComingSoon" value="true" />
                                                </c:if>
                                            </c:forEach>

                                            <c:choose>
                                                <c:when test="${hasComingSoon == 'true'}">
                                                    <div class="movies-slider" id="comingSoonSlider">
                                                        <c:forEach var="movie" items="${movies}">
                                                            <c:if test="${movie.status == 'coming_soon'}">
                                                                <div class="slide-item">
                                                                    <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                                                        style="text-decoration:none; color:inherit;">
                                                                        <div class="movie-card"
                                                                            style="border-color:#f39c12;">
                                                                            <c:choose>
                                                                                <c:when
                                                                                    test="${not empty movie.posterPath}">
                                                                                    <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                                                        alt="${movie.title}"
                                                                                        style="filter:brightness(0.8);">
                                                                                </c:when>
                                                                                <c:when
                                                                                    test="${not empty movie.posterUrl}">
                                                                                    <img src="${movie.posterUrl}"
                                                                                        alt="${movie.title}"
                                                                                        style="filter:brightness(0.8);"
                                                                                        onerror="this.style.display='none'">
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <div class="no-poster"><i
                                                                                            class="bi bi-film"></i>
                                                                                    </div>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                            <div class="card-info">
                                                                                <h6>${movie.title}</h6>
                                                                                <span class="genre">${movie.genre} •
                                                                                    ${movie.duration} min</span><br>
                                                                                <span class="badge-soon">Coming
                                                                                    Soon</span>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </c:if>
                                                        </c:forEach>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="empty-section">
                                                        <i class="bi bi-hourglass-split"></i>
                                                        <p>No upcoming movies at the moment</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>

                                            <div class="text-center mt-4">
                                                <a href="${pageContext.request.contextPath}/movies?action=list" style="background:#f39c12; color:#fff; border-radius:50px; padding:12px 35px;
                      font-weight:700; text-decoration:none; display:inline-block;">
                                                    View All Coming Soon
                                                </a>
                                            </div>
                                        </div>
                                    </section>

                                    <%-- Action Movies Section --%>
                                        <section class="now-showing-section">
                                            <div class="container">
                                                <div class="d-flex justify-content-between align-items-center mb-4">
                                                    <h2 class="section-title mb-0">Action <span>Movies</span></h2>
                                                    <a href="${pageContext.request.contextPath}/movies?action=list&search=action"
                                                        style="color:#e50914; text-decoration:none; font-weight:600; font-size:0.9rem;">
                                                        View All <i class="bi bi-chevron-right"></i>
                                                    </a>
                                                </div>

                                                <c:set var="hasAction" value="false" />
                                                <c:forEach var="movie" items="${movies}">
                                                    <c:if test="${movie.genre.toLowerCase().contains('action')}">
                                                        <c:set var="hasAction" value="true" />
                                                    </c:if>
                                                </c:forEach>

                                                <c:choose>
                                                    <c:when test="${hasAction == 'true'}">
                                                        <div class="movies-slider" id="actionSlider">
                                                            <c:forEach var="movie" items="${movies}">
                                                                <c:if
                                                                    test="${movie.genre.toLowerCase().contains('action')}">
                                                                    <div class="slide-item">
                                                                        <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                                                            style="text-decoration:none; color:inherit;">
                                                                            <div class="movie-card">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${not empty movie.posterPath}">
                                                                                        <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                                                            alt="${movie.title}">
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${not empty movie.posterUrl}">
                                                                                        <img src="${movie.posterUrl}"
                                                                                            alt="${movie.title}"
                                                                                            onerror="this.style.display='none'">
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <div class="no-poster"><i
                                                                                                class="bi bi-film"></i>
                                                                                        </div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                                <div class="card-info">
                                                                                    <h6>${movie.title}</h6>
                                                                                    <span class="genre">${movie.genre} •
                                                                                        ${movie.duration} min</span><br>
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${movie.status == 'now_showing'}">
                                                                                            <span class="badge-now">Now
                                                                                                Showing</span>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <span
                                                                                                class="badge-soon">Coming
                                                                                                Soon</span>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                </div>
                                                                            </div>
                                                                        </a>
                                                                    </div>
                                                                </c:if>
                                                            </c:forEach>
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="empty-section">
                                                            <i class="bi bi-film"></i>
                                                            <p>No action movies available</p>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </section>

                                        <%-- Hindi Movies Section --%>
                                            <section class="coming-soon-section">
                                                <div class="container">
                                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                                        <h2 class="section-title mb-0">Hindi <span>Movies</span></h2>
                                                        <a href="${pageContext.request.contextPath}/movies?action=list&search=hindi"
                                                            style="color:#e50914; text-decoration:none; font-weight:600; font-size:0.9rem;">
                                                            View All <i class="bi bi-chevron-right"></i>
                                                        </a>
                                                    </div>

                                                    <c:set var="hasHindi" value="false" />
                                                    <c:forEach var="movie" items="${movies}">
                                                        <c:if test="${movie.language.toLowerCase().contains('hindi')}">
                                                            <c:set var="hasHindi" value="true" />
                                                        </c:if>
                                                    </c:forEach>

                                                    <c:choose>
                                                        <c:when test="${hasHindi == 'true'}">
                                                            <div class="movies-slider" id="hindiSlider">
                                                                <c:forEach var="movie" items="${movies}">
                                                                    <c:if
                                                                        test="${movie.language.toLowerCase().contains('hindi')}">
                                                                        <div class="slide-item">
                                                                            <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                                                                style="text-decoration:none; color:inherit;">
                                                                                <div class="movie-card">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${not empty movie.posterPath}">
                                                                                            <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                                                                alt="${movie.title}">
                                                                                        </c:when>
                                                                                        <c:when
                                                                                            test="${not empty movie.posterUrl}">
                                                                                            <img src="${movie.posterUrl}"
                                                                                                alt="${movie.title}"
                                                                                                onerror="this.style.display='none'">
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <div class="no-poster"><i
                                                                                                    class="bi bi-film"></i>
                                                                                            </div>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    <div class="card-info">
                                                                                        <h6>${movie.title}</h6>
                                                                                        <span
                                                                                            class="genre">${movie.genre}
                                                                                            • ${movie.duration}
                                                                                            min</span><br>
                                                                                        <span
                                                                                            class="badge-now">Hindi</span>
                                                                                    </div>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="empty-section">
                                                                <i class="bi bi-film"></i>
                                                                <p>No Hindi movies available</p>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </section>

                                            <%-- Sci-Fi Movies Section --%>
                                                <section class="now-showing-section">
                                                    <div class="container">
                                                        <div
                                                            class="d-flex justify-content-between align-items-center mb-4">
                                                            <h2 class="section-title mb-0">Sci-Fi <span>Movies</span>
                                                            </h2>
                                                            <a href="${pageContext.request.contextPath}/movies?action=list&search=sci-fi"
                                                                style="color:#e50914; text-decoration:none; font-weight:600; font-size:0.9rem;">
                                                                View All <i class="bi bi-chevron-right"></i>
                                                            </a>
                                                        </div>

                                                        <c:set var="hasScifi" value="false" />
                                                        <c:forEach var="movie" items="${movies}">
                                                            <c:if test="${movie.genre.toLowerCase().contains('sci')}">
                                                                <c:set var="hasScifi" value="true" />
                                                            </c:if>
                                                        </c:forEach>

                                                        <c:choose>
                                                            <c:when test="${hasScifi == 'true'}">
                                                                <div class="movies-slider" id="scifiSlider">
                                                                    <c:forEach var="movie" items="${movies}">
                                                                        <c:if
                                                                            test="${movie.genre.toLowerCase().contains('sci')}">
                                                                            <div class="slide-item">
                                                                                <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                                                                    style="text-decoration:none; color:inherit;">
                                                                                    <div class="movie-card">
                                                                                        <c:choose>
                                                                                            <c:when
                                                                                                test="${not empty movie.posterPath}">
                                                                                                <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                                                                    alt="${movie.title}">
                                                                                            </c:when>
                                                                                            <c:when
                                                                                                test="${not empty movie.posterUrl}">
                                                                                                <img src="${movie.posterUrl}"
                                                                                                    alt="${movie.title}"
                                                                                                    onerror="this.style.display='none'">
                                                                                            </c:when>
                                                                                            <c:otherwise>
                                                                                                <div class="no-poster">
                                                                                                    <i
                                                                                                        class="bi bi-film"></i>
                                                                                                </div>
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                        <div class="card-info">
                                                                                            <h6>${movie.title}</h6>
                                                                                            <span
                                                                                                class="genre">${movie.genre}
                                                                                                • ${movie.duration}
                                                                                                min</span><br>
                                                                                            <span
                                                                                                class="badge-now">Sci-Fi</span>
                                                                                        </div>
                                                                                    </div>
                                                                                </a>
                                                                            </div>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="empty-section">
                                                                    <i class="bi bi-film"></i>
                                                                    <p>No Sci-Fi movies available</p>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </section>

                                                <%-- Coming Soon Section --%>
                                                    <section class="coming-soon-section" id="coming-soon">
                                                        <div class="container">
                                                            <h2 class="section-title">Coming <span>Soon</span></h2>
                                                            <div class="row g-4 mb-4">
                                                                <c:set var="hasComingSoon" value="false" />
                                                                <c:forEach var="movie" items="${movies}">
                                                                    <c:if test="${movie.status == 'coming_soon'}">
                                                                        <c:set var="hasComingSoon" value="true" />
                                                                        <div class="col-6 col-md-3">
                                                                            <a href="${pageContext.request.contextPath}/movies?action=detail&id=${movie.id}"
                                                                                style="text-decoration:none; color:inherit;">
                                                                                <div class="movie-card"
                                                                                    style="border-color:#f39c12;">
                                                                                    <c:choose>
                                                                                        <c:when
                                                                                            test="${not empty movie.posterPath}">
                                                                                            <img src="${pageContext.request.contextPath}/${movie.posterPath}"
                                                                                                alt="${movie.title}"
                                                                                                style="filter:brightness(0.8);">
                                                                                        </c:when>
                                                                                        <c:when
                                                                                            test="${not empty movie.posterUrl}">
                                                                                            <img src="${movie.posterUrl}"
                                                                                                alt="${movie.title}"
                                                                                                style="filter:brightness(0.8);"
                                                                                                onerror="this.style.display='none'">
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <div class="no-poster"><i
                                                                                                    class="bi bi-film"></i>
                                                                                            </div>
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                                    <div class="card-info">
                                                                                        <h6>${movie.title}</h6>
                                                                                        <span
                                                                                            class="genre">${movie.genre}
                                                                                            •
                                                                                            ${movie.duration}
                                                                                            min</span><br>
                                                                                        <span class="badge-soon">Coming
                                                                                            Soon</span>
                                                                                        <div class="mt-2">
                                                                                            <span
                                                                                                class="btn btn-sm w-100"
                                                                                                style="border:1px solid #f39c12; color:#f39c12; font-size:0.8rem;">
                                                                                                <i
                                                                                                    class="bi bi-clock"></i>
                                                                                                Coming Soon
                                                                                            </span>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </a>
                                                                        </div>
                                                                    </c:if>
                                                                </c:forEach>
                                                                <c:if test="${hasComingSoon == 'false'}">
                                                                    <div class="empty-section">
                                                                        <i class="bi bi-hourglass-split"></i>
                                                                        <p>No upcoming movies at the moment</p>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                            <div class="text-center">
                                                                <a href="${pageContext.request.contextPath}/movies?action=list"
                                                                    style="background:#f39c12; color:#fff; border-radius:50px; padding:12px 35px;
                      font-weight:700; text-decoration:none; display:inline-block;">
                                                                    View All Coming Soon
                                                                </a>
                                                            </div>
                                                        </div>
                                                    </section>

                                                    <%-- Services Section --%>
                                                        <section class="services-section">
                                                            <div class="container">
                                                                <h2 class="section-title text-center">Why Choose
                                                                    <span>CineBook?</span>
                                                                </h2>
                                                                <div class="row g-4">
                                                                    <div class="col-md-3">
                                                                        <div class="service-card">
                                                                            <div class="service-icon"><i
                                                                                    class="bi bi-ticket-perforated"></i>
                                                                            </div>
                                                                            <h5>Easy Booking</h5>
                                                                            <p>Book tickets in just a few clicks from
                                                                                anywhere anytime.
                                                                            </p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <div class="service-card">
                                                                            <div class="service-icon"><i
                                                                                    class="bi bi-grid-3x3"></i>
                                                                            </div>
                                                                            <h5>Seat Selection</h5>
                                                                            <p>Choose your preferred seats with our
                                                                                interactive seat
                                                                                map.</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <div class="service-card">
                                                                            <div class="service-icon"><i
                                                                                    class="bi bi-shield-check"></i>
                                                                            </div>
                                                                            <h5>Secure Payment</h5>
                                                                            <p>100% secure payment processing for all
                                                                                transactions.</p>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <div class="service-card">
                                                                            <div class="service-icon"><i
                                                                                    class="bi bi-bell"></i></div>
                                                                            <h5>Instant Confirmation</h5>
                                                                            <p>Get instant booking confirmation and
                                                                                e-tickets.</p>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </section>

                                                        <%-- Quick Links Section --%>
                                                            <section class="quicklinks-section">
                                                                <div class="container">
                                                                    <h2 class="section-title text-center">Quick
                                                                        <span>Links</span>
                                                                    </h2>
                                                                    <div class="row g-3">
                                                                        <div class="col-6 col-md-2">
                                                                            <a href="${pageContext.request.contextPath}/movies?action=list"
                                                                                class="quick-btn">
                                                                                <i class="bi bi-film"></i>
                                                                                <span>Movies</span>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-6 col-md-2">
                                                                            <a href="${pageContext.request.contextPath}/theater?action=shows"
                                                                                class="quick-btn">
                                                                                <i class="bi bi-display"></i>
                                                                                <span>Shows</span>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-6 col-md-2">
                                                                            <a href="${pageContext.request.contextPath}/booking?action=myBookings"
                                                                                class="quick-btn">
                                                                                <i class="bi bi-ticket"></i>
                                                                                <span>My Bookings</span>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-6 col-md-2">
                                                                            <a href="${pageContext.request.contextPath}/theater?action=list"
                                                                                class="quick-btn">
                                                                                <i class="bi bi-building"></i>
                                                                                <span>Theaters</span>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-6 col-md-2">
                                                                            <a href="${pageContext.request.contextPath}/dashboard"
                                                                                class="quick-btn">
                                                                                <i class="bi bi-speedometer2"></i>
                                                                                <span>Dashboard</span>
                                                                            </a>
                                                                        </div>
                                                                        <div class="col-6 col-md-2">
                                                                            <a href="${pageContext.request.contextPath}/login"
                                                                                class="quick-btn">
                                                                                <i class="bi bi-person-circle"></i>
                                                                                <span>Profile</span>
                                                                            </a>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </section>

                                                            <%-- Footer --%>
                                                                <footer class="footer">
                                                                    <div class="container">
                                                                        <div class="row">
                                                                            <div class="col-md-4 mb-4">
                                                                                <h4
                                                                                    style="color:#e50914; font-weight:900; font-size:1.8rem;">
                                                                                    CineBook</h4>
                                                                                <p class="mt-3">Your ultimate
                                                                                    destination for movie
                                                                                    ticket booking.
                                                                                    Experience cinema like never before.
                                                                                </p>
                                                                                <div class="mt-3">
                                                                                    <a href="https://facebook.com"
                                                                                        target="_blank"
                                                                                        class="social-icon">
                                                                                        <i
                                                                                            class="bi bi-facebook"></i></a>
                                                                                    <a href="https://twitter.com"
                                                                                        target="_blank"
                                                                                        class="social-icon">
                                                                                        <i
                                                                                            class="bi bi-twitter-x"></i></a>
                                                                                    <a href="https://instagram.com"
                                                                                        target="_blank"
                                                                                        class="social-icon">
                                                                                        <i
                                                                                            class="bi bi-instagram"></i></a>
                                                                                    <a href="https://youtube.com"
                                                                                        target="_blank"
                                                                                        class="social-icon">
                                                                                        <i
                                                                                            class="bi bi-youtube"></i></a>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-md-2 mb-4">
                                                                                <h5>Quick Links</h5>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/home">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Home</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/movies?action=list">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Movies</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/theater?action=shows">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Shows</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/booking?action=myBookings">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Booking</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/dashboard">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Dashboard</a>
                                                                            </div>
                                                                            <div class="col-md-2 mb-4">
                                                                                <h5>Account</h5>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/login">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Login</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/register">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Register</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/register?type=admin">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Admin
                                                                                    Register</a>
                                                                                <a
                                                                                    href="${pageContext.request.contextPath}/dashboard">
                                                                                    <i class="bi bi-chevron-right"></i>
                                                                                    Profile</a>
                                                                            </div>
                                                                            <div class="col-md-4 mb-4">
                                                                                <h5>Theater and Contact</h5>
                                                                                <p><i class="bi bi-geo-alt-fill"
                                                                                        style="color:#e50914;"></i>
                                                                                    123 Cinema Street, Colombo 03, Sri
                                                                                    Lanka</p>
                                                                                <p><i class="bi bi-geo-alt-fill"
                                                                                        style="color:#e50914;"></i>
                                                                                    456 Movie Avenue, Kandy, Sri Lanka
                                                                                </p>
                                                                                <p>
                                                                                    <a href="tel:+94112345678"
                                                                                        style="color:#aaa; text-decoration:none;">
                                                                                        <i class="bi bi-telephone-fill"
                                                                                            style="color:#e50914;"></i>
                                                                                        +94 11 234 5678
                                                                                    </a>
                                                                                </p>
                                                                                <p>
                                                                                    <a href="mailto:info@cinebook.lk"
                                                                                        style="color:#aaa; text-decoration:none;">
                                                                                        <i class="bi bi-envelope-fill"
                                                                                            style="color:#e50914;"></i>
                                                                                        info@cinebook.lk
                                                                                    </a>
                                                                                </p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="footer-bottom">
                                                                            <p>2024 CineBook. All rights reserved.</p>
                                                                        </div>
                                                                    </div>
                                                                </footer>

                                                                <script
                                                                    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                                                                <script>
                                                                    // Smooth scroll for anchor links only
                                                                    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                                                                        anchor.addEventListener('click', function (e) {
                                                                            const href = this.getAttribute('href');
                                                                            if (href === '#') return;
                                                                            const target = document.querySelector(href);
                                                                            if (target) {
                                                                                e.preventDefault();
                                                                                target.scrollIntoView({ behavior: 'smooth' });
                                                                            }
                                                                        });
                                                                    });
                                                                </script>
        </body>

        </html>