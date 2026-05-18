<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports - CineBook Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header {
            background: linear-gradient(135deg, #1a0000, #0a0a0a);
            padding: 50px 0 30px;
            border-bottom: 2px solid #e50914;
        }
        .page-header h1 span { color: #e50914; }
        .section { padding: 40px 0; }

        /* Month Selector */
        .month-selector {
            background: #1a1a1a;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 30px;
            border: 1px solid #333;
        }
        .form-select, .form-control {
            background: #111;
            border: 2px solid #333;
            color: #fff;
            border-radius: 10px;
            padding: 10px 15px;
        }
        .form-select:focus { border-color: #e50914; box-shadow: none; background: #111; color: #fff; }
        .form-select option { background: #111; }
        .btn-filter {
            background: #e50914;
            border: none;
            color: #fff;
            border-radius: 10px;
            padding: 10px 25px;
            font-weight: 700;
            transition: all 0.3s;
        }
        .btn-filter:hover { background: #b20710; color: #fff; }

        /* Summary Cards */
        .stat-card {
            background: #1a1a1a;
            border-radius: 15px;
            padding: 25px;
            border: 1px solid #333;
            transition: all 0.3s;
            height: 100%;
        }
        .stat-card:hover { border-color: #e50914; transform: translateY(-3px); }
        .stat-card .stat-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
            display: block;
        }
        .stat-card .stat-value {
            font-size: 1.8rem;
            font-weight: 900;
            color: #e50914;
            display: block;
        }
        .stat-card .stat-label {
            color: #aaa;
            font-size: 0.9rem;
            margin-top: 5px;
        }
        .stat-card.green .stat-value { color: #51cf66; }
        .stat-card.yellow .stat-value { color: #f39c12; }
        .stat-card.blue .stat-value { color: #74c0fc; }
        .stat-card.purple .stat-value { color: #cc5de8; }

        /* Charts */
        .chart-card {
            background: #1a1a1a;
            border-radius: 15px;
            padding: 25px;
            border: 1px solid #333;
            margin-bottom: 25px;
        }
        .chart-card h5 {
            font-weight: 700;
            margin-bottom: 20px;
            color: #fff;
        }
        .chart-card h5 span { color: #e50914; }

        /* Table */
        .report-table {
            background: #1a1a1a;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 25px;
        }
        .report-table h5 {
            padding: 20px 25px;
            font-weight: 700;
            border-bottom: 1px solid #333;
            margin: 0;
        }
        .report-table h5 span { color: #e50914; }
        table { color: #fff; width: 100%; margin: 0; }
        thead { background: #e50914; }
        thead th { padding: 12px 15px; font-weight: 700; border: none; font-size: 0.85rem; }
        tbody tr { border-bottom: 1px solid #333; transition: background 0.2s; }
        tbody tr:hover { background: #222; }
        tbody td { padding: 12px 15px; vertical-align: middle; color: #ccc; font-size: 0.85rem; }
        .amount { color: #e50914; font-weight: 700; }
        .cancel-rate { color: #f39c12; font-weight: 600; }

        .section-title { font-size: 1.3rem; font-weight: 700; margin-bottom: 20px; }
        .section-title span { color: #e50914; }

        .most-booked {
            background: linear-gradient(135deg, #1a0000, #2a0000);
            border: 2px solid #e50914;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            margin-bottom: 25px;
        }
        .most-booked h6 { color: #aaa; font-size: 0.9rem; margin-bottom: 10px; }
        .most-booked h3 { color: #e50914; font-weight: 900; font-size: 1.5rem; }
    </style>
</head>
<body>

<c:set var="currentPage" value="dashboard" scope="request"/>
<%@ include file="navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>Admin <span>Reports</span></h1>
        <p style="color:#aaa;">Monthly summary and analytics</p>
    </div>
</div>

<section class="section">
    <div class="container">

        <%-- Month Selector --%>
        <div class="month-selector">
            <form action="${pageContext.request.contextPath}/reports" method="get"
                  class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label style="color:#ccc; font-size:0.9rem;">Select Month</label>
                    <select name="month" class="form-select">
                        <option value="1" ${month == 1 ? 'selected' : ''}>January</option>
                        <option value="2" ${month == 2 ? 'selected' : ''}>February</option>
                        <option value="3" ${month == 3 ? 'selected' : ''}>March</option>
                        <option value="4" ${month == 4 ? 'selected' : ''}>April</option>
                        <option value="5" ${month == 5 ? 'selected' : ''}>May</option>
                        <option value="6" ${month == 6 ? 'selected' : ''}>June</option>
                        <option value="7" ${month == 7 ? 'selected' : ''}>July</option>
                        <option value="8" ${month == 8 ? 'selected' : ''}>August</option>
                        <option value="9" ${month == 9 ? 'selected' : ''}>September</option>
                        <option value="10" ${month == 10 ? 'selected' : ''}>October</option>
                        <option value="11" ${month == 11 ? 'selected' : ''}>November</option>
                        <option value="12" ${month == 12 ? 'selected' : ''}>December</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label style="color:#ccc; font-size:0.9rem;">Select Year</label>
                    <select name="year" class="form-select">
                        <c:forEach begin="2024" end="${currentYear}" var="y">
                            <option value="${y}" ${year == y ? 'selected' : ''}>${y}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn-filter w-100">
                        <i class="bi bi-filter"></i> Apply Filter
                    </button>
                </div>
            </form>
        </div>

        <%-- Summary Stats --%>
        <h4 class="section-title">Monthly <span>Summary</span></h4>
        <div class="row g-4 mb-4">
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <span class="stat-icon"><i class="bi bi-currency-dollar" style="color:#e50914;"></i></span>
                    <span class="stat-value">
                        Rs. <fmt:formatNumber value="${monthlyRevenue}" maxFractionDigits="0"/>
                    </span>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card green">
                    <span class="stat-icon"><i class="bi bi-ticket-perforated" style="color:#51cf66;"></i></span>
                    <span class="stat-value">${monthlyBookings}</span>
                    <div class="stat-label">Total Bookings</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card yellow">
                    <span class="stat-icon"><i class="bi bi-x-circle" style="color:#f39c12;"></i></span>
                    <span class="stat-value">${monthlyCancellations}</span>
                    <div class="stat-label">Cancellations</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card yellow">
                    <span class="stat-icon"><i class="bi bi-percent" style="color:#f39c12;"></i></span>
                    <span class="stat-value">${cancellationRate}%</span>
                    <div class="stat-label">Cancellation Rate</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card blue">
                    <span class="stat-icon"><i class="bi bi-arrow-counterclockwise" style="color:#74c0fc;"></i></span>
                    <span class="stat-value">
                        Rs. <fmt:formatNumber value="${monthlyRefunds}" maxFractionDigits="0"/>
                    </span>
                    <div class="stat-label">Total Refunds</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card purple">
                    <span class="stat-icon"><i class="bi bi-cash-stack" style="color:#cc5de8;"></i></span>
                    <span class="stat-value">
                        Rs. <fmt:formatNumber value="${cancellationFees}" maxFractionDigits="0"/>
                    </span>
                    <div class="stat-label">Cancellation Fees Earned</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card green">
                    <span class="stat-icon"><i class="bi bi-graph-up" style="color:#51cf66;"></i></span>
                    <span class="stat-value">
                        Rs. <fmt:formatNumber value="${monthlyRevenue - monthlyRefunds}"
                             maxFractionDigits="0"/>
                    </span>
                    <div class="stat-label">Net Revenue</div>
                </div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-card">
                    <span class="stat-icon"><i class="bi bi-star-fill" style="color:#e50914;"></i></span>
                    <span class="stat-value" style="font-size:1rem;">${mostBookedMovie}</span>
                    <div class="stat-label">Most Booked Movie</div>
                </div>
            </div>
        </div>

        <%-- Charts Row --%>
        <div class="row g-4 mb-4">

            <%-- Daily Revenue Chart --%>
            <div class="col-lg-8">
                <div class="chart-card">
                    <h5>Daily <span>Revenue</span> Chart</h5>
                    <canvas id="revenueChart" height="120"></canvas>
                </div>
            </div>

            <%-- Bookings vs Cancellations Pie Chart --%>
            <div class="col-lg-4">
                <div class="chart-card">
                    <h5>Bookings <span>Overview</span></h5>
                    <canvas id="bookingChart" height="200"></canvas>
                </div>
            </div>
        </div>

        <%-- Movie Revenue Chart --%>
        <div class="chart-card mb-4">
            <h5>Revenue <span>Per Movie</span></h5>
            <canvas id="movieRevenueChart" height="80"></canvas>
        </div>

        <%-- Revenue Per Movie Table --%>
        <div class="report-table">
            <h5>Detailed <span>Movie Report</span></h5>
            <table>
                <thead>
                    <tr>
                        <th>Movie</th>
                        <th>Bookings</th>
                        <th>Revenue</th>
                        <th>Cancellations</th>
                        <th>Cancellation Rate</th>
                        <th>Cancellation Fees</th>
                        <th>Net Revenue</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="row" items="${revenuePerMovie}">
                        <tr>
                            <td style="color:#fff; font-weight:600;">${row.title}</td>
                            <td>${row.bookings}</td>
                            <td class="amount">
                                Rs. <fmt:formatNumber value="${row.revenue}" maxFractionDigits="2"/>
                            </td>
                            <td>${row.cancellations}</td>
                            <td class="cancel-rate">
                                <c:choose>
                                    <c:when test="${row.bookings + row.cancellations > 0}">
                                        <fmt:formatNumber
                                            value="${row.cancellations * 100.0 / (row.bookings + row.cancellations)}"
                                            maxFractionDigits="1"/>%
                                    </c:when>
                                    <c:otherwise>0%</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="color:#f39c12;">
                                Rs. <fmt:formatNumber value="${row.cancelFees}" maxFractionDigits="2"/>
                            </td>
                            <td class="amount">
                                Rs. <fmt:formatNumber value="${row.revenue - row.cancelFees}"
                                     maxFractionDigits="2"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty revenuePerMovie}">
                        <tr>
                            <td colspan="7" style="text-align:center; color:#aaa; padding:30px;">
                                No data available for this period
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Daily Revenue Chart
    const dailyData = [
        <c:forEach var="d" items="${dailyRevenue}" varStatus="s">
            { day: ${d.day}, revenue: ${d.revenue} }<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    const labels = dailyData.map(d => 'Day ' + d.day);
    const revenues = dailyData.map(d => d.revenue);

    new Chart(document.getElementById('revenueChart'), {
        type: 'line',
        data: {
            labels: labels.length > 0 ? labels : ['No Data'],
            datasets: [{
                label: 'Daily Revenue (Rs.)',
                data: revenues.length > 0 ? revenues : [0],
                borderColor: '#e50914',
                backgroundColor: 'rgba(229, 9, 20, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#e50914',
                pointRadius: 4
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { labels: { color: '#fff' } }
            },
            scales: {
                x: { ticks: { color: '#aaa' }, grid: { color: '#222' } },
                y: { ticks: { color: '#aaa' }, grid: { color: '#222' } }
            }
        }
    });

    // Bookings vs Cancellations Pie Chart
    new Chart(document.getElementById('bookingChart'), {
        type: 'doughnut',
        data: {
            labels: ['Confirmed', 'Cancelled'],
            datasets: [{
                data: [${monthlyBookings}, ${monthlyCancellations}],
                backgroundColor: ['#51cf66', '#e50914'],
                borderColor: ['#1a1a1a'],
                borderWidth: 3
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { labels: { color: '#fff' } }
            }
        }
    });

    // Revenue Per Movie Bar Chart
    const movieData = [
        <c:forEach var="row" items="${revenuePerMovie}" varStatus="s">
            { title: '${row.title}', revenue: ${row.revenue} }<c:if test="${!s.last}">,</c:if>
        </c:forEach>
    ];

    new Chart(document.getElementById('movieRevenueChart'), {
        type: 'bar',
        data: {
            labels: movieData.map(m => m.title),
            datasets: [{
                label: 'Revenue (Rs.)',
                data: movieData.map(m => m.revenue),
                backgroundColor: 'rgba(229, 9, 20, 0.7)',
                borderColor: '#e50914',
                borderWidth: 1,
                borderRadius: 5
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { labels: { color: '#fff' } }
            },
            scales: {
                x: { ticks: { color: '#aaa' }, grid: { color: '#222' } },
                y: { ticks: { color: '#aaa' }, grid: { color: '#222' } }
            }
        }
    });
</script>
</body>
</html>