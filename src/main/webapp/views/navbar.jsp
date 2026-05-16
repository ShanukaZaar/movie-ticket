<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            .main-navbar {
                background: rgba(0, 0, 0, 0.97) !important;
                border-bottom: 2px solid #e50914;
                padding: 12px 0;
            }

            .main-navbar .navbar-brand {
                font-size: 1.8rem;
                font-weight: 900;
                color: #e50914 !important;
            }

            .main-navbar .nav-link {
                color: #fff !important;
                font-weight: 500;
                margin: 0 3px;
                transition: color 0.3s;
            }

            .main-navbar .nav-link:hover {
                color: #e50914 !important;
            }

            .main-navbar .nav-link.active {
                color: #e50914 !important;
            }

            .btn-nav-login {
                border: 2px solid #e50914 !important;
                color: #e50914 !important;
                border-radius: 25px !important;
                padding: 5px 20px !important;
            }

            .btn-nav-login:hover {
                background: #e50914 !important;
                color: #fff !important;
            }

            .btn-nav-register {
                background: #e50914 !important;
                color: #fff !important;
                border-radius: 25px !important;
                padding: 5px 20px !important;
            }

            .btn-nav-register:hover {
                background: #b20710 !important;
            }

            .dropdown-menu {
                background: #1a1a1a;
                border: 1px solid #333;
            }

            .dropdown-item {
                color: #fff;
            }

            .dropdown-item:hover {
                background: #e50914;
                color: #fff;
            }
        </style>

        <nav class="navbar navbar-expand-lg navbar-dark main-navbar sticky-top">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/home">CineBook</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="mainNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link ${currentPage == 'home' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/home">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${currentPage == 'movies' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/movies?action=list">Movies</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${currentPage == 'theater' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/theater?action=shows">Shows</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${currentPage == 'booking' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/booking?action=myBookings">
                                <i class="bi bi-ticket-perforated"></i> My Bookings
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${currentPage == 'theater' ? 'active' : ''}"
                                href="${pageContext.request.contextPath}/theater?action=list">Theaters</a>
                        </li>

                        <%-- Admin only links --%>
                            <c:if test="${sessionScope.userRole == 'admin'}">
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"
                                        style="color:#ffffff !important; font-weight:700;">
                                        <i class="bi bi-speedometer2"></i> Dashboard
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/theater?action=list"
                                        style="color:#ffffff !important; font-weight:700;">
                                        <i class="bi bi-building"></i> Manage Theaters
                                    </a>
                                </li>
                            </c:if>
                    </ul>

                    <ul class="navbar-nav">
                        <c:choose>
                            <c:when test="${sessionScope.user != null}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                                        👤 ${sessionScope.userName}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end">
                                        <li>
                                            <a class="dropdown-item"
                                                href="${pageContext.request.contextPath}/dashboard">
                                                <i class="bi bi-speedometer2"></i> Dashboard
                                            </a>
                                        </li>
                                        <c:if test="${sessionScope.userRole == 'admin'}">
                                            <li>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/theater?action=list">
                                                    <i class="bi bi-building"></i> Theaters
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/theater?action=shows">
                                                    <i class="bi bi-camera-reels"></i> Shows
                                                </a>
                                            </li>
                                            <li>
                                                <a class="dropdown-item"
                                                    href="${pageContext.request.contextPath}/booking?action=allBookings">
                                                    <i class="bi bi-list-ul"></i> All Bookings
                                                </a>
                                            </li>
                                        </c:if>
                                        <li>
                                            <hr class="dropdown-divider" style="border-color:#333;">
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                                <i class="bi bi-box-arrow-right"></i> Logout
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="nav-link btn-nav-login me-2"
                                        href="${pageContext.request.contextPath}/login">Login</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link btn-nav-register"
                                        href="${pageContext.request.contextPath}/register">Register</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>