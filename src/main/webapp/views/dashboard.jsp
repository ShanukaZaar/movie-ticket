<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Movie Ticket Reservation</title>
    <!-- Bootstrap CSS CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="#">🎬 MovieTicket</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link active" href="dashboard.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Movies</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Bookings</a>
                </li>
            </ul>
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="container mt-4">
    <h2>Welcome to the Dashboard</h2>
    <p class="text-muted">This is the main dashboard. Team members will add their components here.</p>

    <div class="row mt-4">
        <!-- Card 1 -->
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <h5 class="card-title">Movies</h5>
                    <p class="card-text">Manage movies and listings.</p>
                </div>
            </div>
        </div>
        <!-- Card 2 -->
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <h5 class="card-title">Bookings</h5>
                    <p class="card-text">View and manage bookings.</p>
                </div>
            </div>
        </div>
        <!-- Card 3 -->
        <div class="col-md-4 mb-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <h5 class="card-title">Reports</h5>
                    <p class="card-text">View system reports.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS CDN -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
