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
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body { font-family: 'Segoe UI', sans-serif; background: #0a0a0a; color: #fff; }

        /* Navbar */
        .navbar { background: rgba(0,0,0,0.95) !important; border-bottom: 2px solid #e50914; padding: 15px 0; }
        .navbar-brand { font-size: 1.8rem; font-weight: 900; color: #e50914 !important; }
        .nav-link { color: #fff !important; font-weight: 500; margin: 0 5px; transition: color 0.3s; }
        .nav-link:hover { color: #e50914 !important; }
        .btn-login { background: transparent; border: 2px solid #e50914; color: #e50914 !important; border-radius: 25px; padding: 5px 20px; }
        .btn-login:hover { background: #e50914; color: #fff !important; }
        .btn-register-nav { background: #e50914; color: #fff !important; border-radius: 25px; padding: 5px 20px; }
        .btn-register-nav:hover { background: #b20710; }

        /* Hero Banner */
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
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=1920') center/cover;
            opacity: 0.15;
        }
        .hero-content { position: relative; z-index: 1; }
        .hero h1 { font-size: 4rem; font-weight: 900; line-height: 1.1; }
        .hero h1 span { color: #e50914; }
        .hero p { font-size: 1.3rem; color: #ccc; margin: 20px 0; }
        .btn-book { background: #e50914; color: #fff; border: none; padding: 15px 40px; border-radius: 50px; font-size: 1.1rem; font-weight: 700; transition: all 0.3s; }
        .btn-book:hover { background: #b20710; transform: scale(1.05); color: #fff; }
        .btn-explore { background: transparent; color: #fff; border: 2px solid #fff; padding: 15px 40px; border-radius: 50px; font-size: 1.1rem; font-weight: 700; transition: all 0.3s; margin-left: 15px; }
        .btn-explore:hover { background: #fff; color: #000; }

        /* Stats bar */
        .stats-bar { background: #e50914; padding: 20px 0; }
        .stat-item { text-align: center; }
        .stat-item h3 { font-size: 2rem; font-weight: 900; }
        .stat-item p { font-size: 0.9rem; opacity: 0.9; margin: 0; }

        /* Section titles */
        .section-title { font-size: 2rem; font-weight: 800; margin-bottom: 30px; }
        .section-title span { color: #e50914; }
        .section { padding: 60px 0; }

        /* Movie slider */
        .movies-section { background: #111; padding: 60px 0; }
        .movie-card { background: #1a1a1a; border-radius: 12px; overflow: hidden; transition: transform 0.3s; cursor: pointer; height: 100%; border: 1px solid #222; }
        .movie-card:hover { transform: translateY(-10px); border-color: #e50914; }
        .movie-card img { width: 100%; height: 280px; object-fit: cover; }
        .movie-card .no-poster { width: 100%; height: 280px; background: linear-gradient(135deg, #222, #333); display: flex; align-items: center; justify-content: center; font-size: 4rem; }
        .movie-card .card-info { padding: 15px; }
        .movie-card .card-info h6 { font-weight: 700; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .movie-card .badge-status { background: #e50914; color: #fff; padding: 3px 10px; border-radius: 20px; font-size: 0.75rem; }
        .movie-card .genre { color: #aaa; font-size: 0.85rem; }

        /* Services section */
        .services-section { background: #0a0a0a; padding: 60px 0; }
        .service-card { background: #1a1a1a; border-radius: 15px; padding: 30px; text-align: center; transition: all 0.3s; border: 1px solid #222; height: 100%; }
        .service-card:hover { border-color: #e50914; transform: translateY(-5px); }
        .service-icon { font-size: 3rem; color: #e50914; margin-bottom: 15px; }
        .service-card h5 { font-weight: 700; margin-bottom: 10px; }
        .service-card p { color: #aaa; font-size: 0.9rem; }

        /* Quick links section */
        .quicklinks-section { background: #111; padding: 60px 0; }
        .quick-btn { display: block; background: #1a1a1a; border: 2px solid #333; color: #fff; border-radius: 12px; padding: 20px; text-align: center; text-decoration: none; transition: all 0.3s; margin-bottom: 15px; }
        .quick-btn:hover { border-color: #e50914; color: #e50914; transform: scale(1.03); }
        .quick-btn i { font-size: 2rem; display: block; margin-bottom: 8px; }
        .quick-btn span { font-weight: 600; font-size: 0.9rem; }

        /* Footer */
        .footer { background: #000; padding: 50px 0 20px; border-top: 3px solid #e50914; }
        .footer h5 { color: #e50914; font-weight: 700; margin-bottom: 20px; }
        .footer p { color: #aaa; font-size: 0.9rem; }
        .footer a { color: #aaa; text-decoration: none; display: block; margin-bottom: 8px; font-size: 0.9rem; transition: color 0.3s; }
        .footer a:hover { color: #e50914; }
        .social-icon { display: inline-flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 50%; background: #1a1a1a; color: #fff; margin-right: 10px; font-size: 1.2rem; text-decoration: none; transition: all 0.3s; }
        .social-icon:hover { background: #e50914; color: #fff; transform: scale(1.1); }
        .footer-bottom { border-top: 1px solid #222; margin-top: 30px; padding-top: 20px; text-align: center; color: #555; font-size: 0.85rem; }

        /* Carousel custom */
        .carousel-inner { border-radius: 15px; }
    </style>
</head>
<body>

<%-- Navbar --%>
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">CineBook</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/movies?action=list">Movies</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Shows</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Booking</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Theaters</a></li>
            </ul>
            <ul class="navbar-nav">
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/dashboard">👤 ${sessionScope.userName}</a></li>
                        <li class="nav-item"><a class="nav-link btn-login ms-2" href="${pageContext.request.contextPath}/logout">Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link btn-login" href="${pageContext.request.contextPath}/login">Login</a></li>
                        <li class="nav-item"><a class="nav-link btn-register-nav ms-2" href="${pageContext.request.contextPath}/register">Register</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<%-- Hero Banner --%>
<section class="hero">
    <div class="container hero-content">
        <div class="row align-items-center">
            <div class="col-lg-7">
                <p style="color:#e50914; font-weight:700; letter-spacing:3px; text-transform:uppercase;">Welcome to CineBook</p>
                <h1>Experience <span>Cinema</span> Like Never Before</h1>
                <p>Book your favorite movie tickets online. Choose your seats, pick your showtime, and enjoy the magic of movies.</p>
                <a href="${pageContext.request.contextPath}/movies?action=list" class="btn btn-book">Book Now</a>
                <a href="#movies-section" class="btn btn-explore">Explore Movies</a>
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

<%-- Newly Released Movies Slider --%>
<section class="movies-section" id="movies-section">
    <div class="container">
        <h2 class="section-title">Newly <span>Released</span> Movies</h2>

        <c:choose>
            <c:when test="${not empty movies}">
                <div id="movieCarousel" class="carousel slide mb-5" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <c:forEach var="movie" items="${movies}" varStatus="status">
                            <div class="carousel-item ${status.first ? 'active' : ''}">
                                <div class="row g-3">
                                    <%-- Show up to 4 movies per slide --%>
                                    <c:forEach var="m" items="${movies}" begin="${status.index}" end="${status.index + 3}">
                                        <div class="col-md-3">
                                            <div class="movie-card">
                                                <c:choose>
                                                    <c:when test="${not empty m.posterPath}">
                                                        <img src="${pageContext.request.contextPath}/${m.posterPath}" alt="${m.title}">
                                                    </c:when>
                                                    <c:when test="${not empty m.posterUrl}">
                                                        <img src="${m.posterUrl}" alt="${m.title}" onerror="this.parentElement.innerHTML='<div class=\'no-poster\'>🎬</div>'">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="no-poster">🎬</div>
                                                    </c:otherwise>
                                                </c:choose>
                                                <div class="card-info">
                                                    <h6>${m.title}</h6>
                                                    <span class="genre">${m.genre}</span><br>
                                                    <span class="badge-status">${m.status}</span>
                                                    <div class="mt-2">
                                                        <a href="${pageContext.request.contextPath}/movies?action=detail&id=${m.id}"
                                                           class="btn btn-sm btn-outline-light w-100">View Details</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#movieCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon"></span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#movieCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon"></span>
                    </button>
                </div>
            </c:when>
            <c:otherwise>
                <div class="text-center py-5">
                    <p style="color:#aaa; font-size:1.2rem;">No movies available yet. Check back soon!</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="text-center">
            <a href="${pageContext.request.contextPath}/movies?action=list" class="btn btn-book">View All Movies</a>
        </div>
    </div>
</section>

<%-- Services Section --%>
<section class="services-section">
    <div class="container">
        <h2 class="section-title text-center">Why Choose <span>CineBook?</span></h2>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="service-card">
                    <div class="service-icon"><i class="bi bi-ticket-perforated"></i></div>
                    <h5>Easy Booking</h5>
                    <p>Book tickets in just a few clicks from anywhere anytime.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="service-card">
                    <div class="service-icon"><i class="bi bi-grid-3x3"></i></div>
                    <h5>Seat Selection</h5>
                    <p>Choose your preferred seats with our interactive seat map.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="service-card">
                    <div class="service-icon"><i class="bi bi-shield-check"></i></div>
                    <h5>Secure Payment</h5>
                    <p>100% secure payment processing for all transactions.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="service-card">
                    <div class="service-icon"><i class="bi bi-bell"></i></div>
                    <h5>Instant Confirmation</h5>
                    <p>Get instant booking confirmation and e-tickets.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- Quick Links Section --%>
<section class="quicklinks-section">
    <div class="container">
        <h2 class="section-title text-center">Quick <span>Links</span></h2>
        <div class="row g-3">
            <div class="col-6 col-md-2">
                <a href="${pageContext.request.contextPath}/movies?action=list" class="quick-btn">
                    <i class="bi bi-film"></i>
                    <span>Movies</span>
                </a>
            </div>
            <div class="col-6 col-md-2">
                <a href="#" class="quick-btn">
                    <i class="bi bi-display"></i>
                    <span>Shows</span>
                </a>
            </div>
            <div class="col-6 col-md-2">
                <a href="#" class="quick-btn">
                    <i class="bi bi-ticket"></i>
                    <span>Booking</span>
                </a>
            </div>
            <div class="col-6 col-md-2">
                <a href="#" class="quick-btn">
                    <i class="bi bi-building"></i>
                    <span>Theaters</span>
                </a>
            </div>
            <div class="col-6 col-md-2">
                <a href="${pageContext.request.contextPath}/dashboard" class="quick-btn">
                    <i class="bi bi-speedometer2"></i>
                    <span>Dashboard</span>
                </a>
            </div>
            <div class="col-6 col-md-2">
                <a href="${pageContext.request.contextPath}/login" class="quick-btn">
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

            <%-- Brand --%>
            <div class="col-md-4 mb-4">
                <h4 style="color:#e50914; font-weight:900; font-size:1.8rem;">CineBook</h4>
                <p class="mt-3">Your ultimate destination for movie ticket booking. Experience cinema like never before with our easy and fast booking system.</p>
                <div class="mt-3">
                    <a href="https://facebook.com" target="_blank" class="social-icon"><i class="bi bi-facebook"></i></a>
                    <a href="https://twitter.com" target="_blank" class="social-icon"><i class="bi bi-twitter-x"></i></a>
                    <a href="https://instagram.com" target="_blank" class="social-icon"><i class="bi bi-instagram"></i></a>
                    <a href="https://youtube.com" target="_blank" class="social-icon"><i class="bi bi-youtube"></i></a>
                </div>
            </div>

            <%-- Quick Links --%>
            <div class="col-md-2 mb-4">
                <h5>Quick Links</h5>
                <a href="${pageContext.request.contextPath}/home"><i class="bi bi-chevron-right"></i> Home</a>
                <a href="${pageContext.request.contextPath}/movies?action=list"><i class="bi bi-chevron-right"></i> Movies</a>
                <a href="#"><i class="bi bi-chevron-right"></i> Shows</a>
                <a href="#"><i class="bi bi-chevron-right"></i> Booking</a>
                <a href="${pageContext.request.contextPath}/dashboard"><i class="bi bi-chevron-right"></i> Dashboard</a>
            </div>

            <%-- Account --%>
            <div class="col-md-2 mb-4">
                <h5>Account</h5>
                <a href="${pageContext.request.contextPath}/login"><i class="bi bi-chevron-right"></i> Login</a>
                <a href="${pageContext.request.contextPath}/register"><i class="bi bi-chevron-right"></i> Register</a>
                <a href="${pageContext.request.contextPath}/register?type=admin"><i class="bi bi-chevron-right"></i> Admin Register</a>
                <a href="${pageContext.request.contextPath}/dashboard"><i class="bi bi-chevron-right"></i> Profile</a>
            </div>

            <%-- Theater & Contact --%>
            <div class="col-md-4 mb-4">
                <h5>Theater & Contact</h5>
                <p><i class="bi bi-geo-alt-fill" style="color:#e50914;"></i> 123 Cinema Street, Colombo 03, Sri Lanka</p>
                <p><i class="bi bi-geo-alt-fill" style="color:#e50914;"></i> 456 Movie Avenue, Kandy, Sri Lanka</p>
                <p class="mt-2">
                    <a href="tel:+94112345678" style="color:#aaa; text-decoration:none;">
                        <i class="bi bi-telephone-fill" style="color:#e50914;"></i> +94 11 234 5678
                    </a>
                </p>
                <p>
                    <a href="tel:+94812345678" style="color:#aaa; text-decoration:none;">
                        <i class="bi bi-telephone-fill" style="color:#e50914;"></i> +94 81 234 5678
                    </a>
                </p>
                <p>
                    <a href="mailto:info@cinebook.lk" style="color:#aaa; text-decoration:none;">
                        <i class="bi bi-envelope-fill" style="color:#e50914;"></i> info@cinebook.lk
                    </a>
                </p>
            </div>

        </div>
        <div class="footer-bottom">
            <p>© 2024 CineBook. All rights reserved by WD105. </p>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-slide carousel
    var myCarousel = document.getElementById('movieCarousel');
    if (myCarousel) {
        new bootstrap.Carousel(myCarousel, { interval: 5000, wrap: true });
    }
</script>
</body>
</html>