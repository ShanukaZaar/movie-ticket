<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reserve Tickets - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }

        .page-header {
            background: linear-gradient(135deg, #1a0000, #0a0a0a);
            padding: 50px 0 30px;
            border-bottom: 2px solid #e50914;
        }
        .page-header h1 span { color: #e50914; }

        .section { padding: 40px 0; }

        /* Steps */
        .steps {
            display: flex;
            align-items: center;
            margin-bottom: 40px;
            gap: 0;
        }
        .step {
            flex: 1;
            text-align: center;
            padding: 15px;
            background: #1a1a1a;
            border: 1px solid #333;
            font-size: 0.85rem;
            color: #aaa;
            position: relative;
        }
        .step.active {
            background: #e50914;
            color: #fff;
            border-color: #e50914;
            font-weight: 700;
        }
        .step.completed {
            background: #1a3a1a;
            color: #51cf66;
            border-color: #28a745;
        }
        .step:first-child { border-radius: 10px 0 0 10px; }
        .step:last-child { border-radius: 0 10px 10px 0; }
        .step i { display: block; font-size: 1.2rem; margin-bottom: 5px; }

        /* Show Selection */
        .show-card {
            background: #1a1a1a;
            border: 2px solid #333;
            border-radius: 12px;
            padding: 15px 20px;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
            color: #fff;
            margin-bottom: 12px;
        }
        .show-card:hover { border-color: #e50914; color: #fff; }
        .show-card.selected { border-color: #e50914; background: #2a0000; color: #fff; }
        .show-time { font-size: 1.5rem; font-weight: 900; color: #e50914; }
        .show-info { color: #aaa; font-size: 0.85rem; }
        .show-price { font-weight: 700; color: #fff; }
        .date-label {
            color: #e50914;
            font-weight: 700;
            font-size: 0.9rem;
            margin-bottom: 10px;
            margin-top: 20px;
            padding-bottom: 5px;
            border-bottom: 1px solid #333;
        }

        /* Seat Map */
        .screen {
            background: linear-gradient(180deg, #e50914, #7a0008);
            height: 8px;
            border-radius: 5px;
            margin: 20px auto 10px;
            width: 80%;
            box-shadow: 0 5px 20px rgba(229,9,20,0.5);
        }
        .screen-label {
            text-align: center;
            color: #aaa;
            font-size: 0.8rem;
            margin-bottom: 25px;
        }
        .seats-container { max-width: 650px; margin: 0 auto; }
        .seat-row {
            display: flex;
            justify-content: center;
            gap: 6px;
            margin-bottom: 6px;
            align-items: center;
        }
        .row-label {
            width: 20px;
            text-align: center;
            color: #555;
            font-size: 0.8rem;
            font-weight: 700;
        }
        .seat {
            width: 35px;
            height: 35px;
            border-radius: 6px 6px 3px 3px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.6rem;
            font-weight: 700;
            transition: all 0.2s;
            border: none;
        }
        .seat.regular {
            background: #2a2a2a;
            color: #aaa;
            border: 2px solid #444;
        }
        .seat.regular:hover:not(.booked) {
            background: #e50914;
            color: #fff;
            border-color: #e50914;
        }
        .seat.premium {
            background: #1a1a3a;
            color: #7b8cde;
            border: 2px solid #3a3a7a;
        }
        .seat.premium:hover:not(.booked) {
            background: #3a3aaa;
            color: #fff;
            border-color: #5a5aff;
        }
        .seat.vip {
            background: #2a1a00;
            color: #f39c12;
            border: 2px solid #7a5000;
        }
        .seat.vip:hover:not(.booked) {
            background: #f39c12;
            color: #fff;
            border-color: #f39c12;
        }
        .seat.booked {
            background: #111;
            color: #222;
            border-color: #1a1a1a;
            cursor: not-allowed;
        }
        .seat.selected {
            background: #e50914 !important;
            color: #fff !important;
            border-color: #e50914 !important;
            transform: scale(1.1);
        }

        /* Legend */
        .legend {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin: 20px 0;
            flex-wrap: wrap;
        }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.8rem;
            color: #aaa;
        }
        .legend-box { width: 18px; height: 18px; border-radius: 3px; }

        /* Summary */
        .summary-card {
            background: #1a1a1a;
            border: 2px solid #333;
            border-radius: 15px;
            padding: 25px;
            position: sticky;
            top: 80px;
        }
        .summary-card h5 { color: #e50914; font-weight: 700; margin-bottom: 20px; }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: #ccc;
            font-size: 0.9rem;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            font-weight: 700;
            font-size: 1.1rem;
            border-top: 1px solid #333;
            padding-top: 10px;
            margin-top: 10px;
        }
        .summary-total span:last-child { color: #e50914; }
        .selected-seats-display {
            color: #e50914;
            font-weight: 600;
            font-size: 0.9rem;
            min-height: 20px;
            word-break: break-all;
        }
        .btn-checkout {
            background: #e50914;
            border: none;
            color: #fff;
            width: 100%;
            border-radius: 10px;
            padding: 14px;
            font-weight: 700;
            font-size: 1rem;
            transition: all 0.3s;
            margin-top: 15px;
            cursor: pointer;
        }
        .btn-checkout:hover { background: #b20710; }
        .btn-checkout:disabled { background: #333; color: #666; cursor: not-allowed; }

        .error-alert {
            background: rgba(229,9,20,0.15);
            border: 1px solid rgba(229,9,20,0.4);
            color: #ff6b6b;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .no-shows {
            text-align: center;
            padding: 40px;
            color: #aaa;
        }
        .no-shows i {
            font-size: 3rem;
            color: #333;
            display: block;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>Reserve Your <span>Tickets</span></h1>
        <p style="color:#aaa;">Select your show, seats and proceed to payment</p>
    </div>
</div>

<section class="section">
    <div class="container">

        <%-- Progress Steps --%>
        <div class="steps mb-4">
            <div class="step ${selectedShow == null ? 'active' : 'completed'}">
                <i class="bi bi-calendar3"></i>
                Select Show
            </div>
            <div class="step ${selectedShow != null ? 'active' : ''}">
                <i class="bi bi-grid-3x3"></i>
                Select Seats
            </div>
            <div class="step">
                <i class="bi bi-credit-card"></i>
                Payment
            </div>
        </div>

        <% if (request.getParameter("error") != null) { %>
            <div class="error-alert">
                <i class="bi bi-exclamation-circle"></i>
                Please select at least one seat before proceeding.
            </div>
        <% } %>

        <div class="row g-4">

            <%-- Left Column --%>
            <div class="col-lg-8">

                <%-- Step 1: Show Selection --%>
                <c:choose>
                    <c:when test="${empty selectedShow}">
                        <h4 style="font-weight:700; margin-bottom:20px;">
                            <i class="bi bi-calendar3" style="color:#e50914;"></i>
                            Available Shows
                        </h4>

                        <c:choose>
                            <c:when test="${not empty shows}">
                                <c:set var="currentDate" value=""/>
                                <c:forEach var="show" items="${shows}">
                                    <c:if test="${show.showDate != currentDate}">
                                        <c:set var="currentDate" value="${show.showDate}"/>
                                        <div class="date-label">
                                            <i class="bi bi-calendar-event"></i>
                                            ${show.showDate}
                                        </div>
                                    </c:if>
                                    <a href="${pageContext.request.contextPath}/reservation?movieId=${movieId}&showId=${show.id}"
                                       class="show-card">
                                        <div class="row align-items-center">
                                            <div class="col-md-4">
                                                <div class="show-time">${show.showTime}</div>
                                            </div>
                                            <div class="col-md-5">
                                                <div class="show-info">
                                                    <i class="bi bi-building"></i> ${show.theaterName}
                                                </div>
                                                <div class="show-info">
                                                    <i class="bi bi-display"></i> ${show.screenName}
                                                </div>
                                            </div>
                                            <div class="col-md-3 text-md-end">
                                                <div class="show-price">Rs. ${show.price}</div>
                                                <small style="color:#aaa;">per seat</small>
                                            </div>
                                        </div>
                                    </a>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="no-shows">
                                    <i class="bi bi-calendar-x"></i>
                                    <h5>No shows available</h5>
                                    <p>There are no upcoming shows for this movie.</p>
                                    <a href="${pageContext.request.contextPath}/movies?action=list"
                                       style="background:#e50914; color:#fff; border-radius:25px; padding:10px 25px; text-decoration:none; font-weight:700;">
                                        Browse Movies
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </c:when>

                    <%-- Step 2: Seat Selection --%>
                    <c:otherwise>
                        <div class="d-flex align-items-center gap-3 mb-4">
                            <a href="${pageContext.request.contextPath}/reservation?movieId=${movieId}"
                               style="color:#aaa; text-decoration:none;">
                                <i class="bi bi-arrow-left"></i> Back to Shows
                            </a>
                            <div>
                                <strong>${selectedShow.movieTitle}</strong>
                                <span style="color:#aaa; font-size:0.9rem;">
                                    — ${selectedShow.showDate} at ${selectedShow.showTime}
                                    — ${selectedShow.theaterName} — ${selectedShow.screenName}
                                </span>
                            </div>
                        </div>

                        <h4 style="font-weight:700; margin-bottom:5px;">
                            <i class="bi bi-grid-3x3" style="color:#e50914;"></i>
                            Select Your Seats
                        </h4>

                        <%-- Screen --%>
                        <div class="screen"></div>
                        <div class="screen-label">SCREEN</div>

                        <%-- Seat Map --%>
                        <div class="seats-container">
                            <c:set var="currentRow" value="X"/>
                            <c:forEach var="seat" items="${seats}">
                                <c:set var="rowLetter" value="${seat.seatNumber.substring(0,1)}"/>
                                <c:if test="${rowLetter != currentRow}">
                                    <c:if test="${currentRow != 'X'}">
                                        </div>
                                    </c:if>
                                    <c:set var="currentRow" value="${rowLetter}"/>
                                    <div class="seat-row">
                                    <span class="row-label">${rowLetter}</span>
                                </c:if>
                                <button type="button"
                                        class="seat ${seat.seatType} ${seat.booked ? 'booked' : ''}"
                                        data-seat-id="${seat.id}"
                                        data-seat-number="${seat.seatNumber}"
                                        data-seat-type="${seat.seatType}"
                                        ${seat.booked ? 'disabled' : ''}
                                        title="${seat.seatNumber} - ${seat.seatType}">
                                    ${seat.seatNumber.substring(1)}
                                </button>
                            </c:forEach>
                            </div>
                        </div>

                        <%-- Legend --%>
                        <div class="legend">
                            <div class="legend-item">
                                <div class="legend-box" style="background:#2a2a2a; border:2px solid #444;"></div>
                                Regular
                            </div>
                            <div class="legend-item">
                                <div class="legend-box" style="background:#1a1a3a; border:2px solid #3a3a7a;"></div>
                                Premium
                            </div>
                            <div class="legend-item">
                                <div class="legend-box" style="background:#2a1a00; border:2px solid #7a5000;"></div>
                                VIP
                            </div>
                            <div class="legend-item">
                                <div class="legend-box" style="background:#e50914;"></div>
                                Selected
                            </div>
                            <div class="legend-item">
                                <div class="legend-box" style="background:#111; border:2px solid #1a1a1a;"></div>
                                Booked
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <%-- Right Column - Summary --%>
            <div class="col-lg-4">
                <div class="summary-card">
                    <h5><i class="bi bi-receipt"></i> Booking Summary</h5>

                    <c:choose>
                        <c:when test="${empty selectedShow}">
                            <p style="color:#aaa; font-size:0.9rem; text-align:center; padding:20px 0;">
                                Select a show to see booking details
                            </p>
                        </c:when>
                        <c:otherwise>
                            <div class="summary-row">
                                <span>Movie</span>
                                <strong style="color:#fff; font-size:0.85rem;">${selectedShow.movieTitle}</strong>
                            </div>
                            <div class="summary-row">
                                <span>Theater</span>
                                <strong style="color:#fff;">${selectedShow.theaterName}</strong>
                            </div>
                            <div class="summary-row">
                                <span>Screen</span>
                                <strong style="color:#fff;">${selectedShow.screenName}</strong>
                            </div>
                            <div class="summary-row">
                                <span>Date</span>
                                <strong style="color:#fff;">${selectedShow.showDate}</strong>
                            </div>
                            <div class="summary-row">
                                <span>Time</span>
                                <strong style="color:#fff;">${selectedShow.showTime}</strong>
                            </div>
                            <div class="summary-row">
                                <span>Price per seat</span>
                                <strong style="color:#fff;">Rs. ${selectedShow.price}</strong>
                            </div>

                            <hr style="border-color:#333;">

                            <div class="summary-row">
                                <span>Selected Seats</span>
                            </div>
                            <div class="selected-seats-display" id="selectedSeatsList">
                                None selected
                            </div>

                            <div class="summary-total">
                                <span>Total</span>
                                <span id="totalAmount">Rs. 0.00</span>
                            </div>

                            <form action="${pageContext.request.contextPath}/reservation"
                                  method="post" id="reservationForm">
                                <input type="hidden" name="showId" value="${selectedShow.id}">
                                <input type="hidden" name="movieId" value="${movieId}">
                                <div id="seatInputs"></div>
                                <button type="submit" class="btn-checkout"
                                        id="checkoutBtn" disabled>
                                    <i class="bi bi-credit-card"></i> Proceed to Payment
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </div>
    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const pricePerSeat = ${selectedShow != null ? selectedShow.price : 0};
    let selectedSeats = [];

    document.querySelectorAll('.seat:not(.booked)').forEach(seat => {
        seat.addEventListener('click', function() {
            const seatId = this.dataset.seatId;
            const seatNumber = this.dataset.seatNumber;

            if (this.classList.contains('selected')) {
                this.classList.remove('selected');
                selectedSeats = selectedSeats.filter(s => s.id !== seatId);
            } else {
                this.classList.add('selected');
                selectedSeats.push({ id: seatId, number: seatNumber });
            }
            updateSummary();
        });
    });

    function updateSummary() {
        const count = selectedSeats.length;
        const total = count * pricePerSeat;

        if (count === 0) {
            document.getElementById('selectedSeatsList').textContent = 'None selected';
        } else {
            document.getElementById('selectedSeatsList').textContent =
                selectedSeats.map(s => s.number).join(', ');
        }

        document.getElementById('totalAmount').textContent =
            'Rs. ' + total.toFixed(2);
        document.getElementById('checkoutBtn').disabled = count === 0;

        const container = document.getElementById('seatInputs');
        container.innerHTML = '';
        selectedSeats.forEach(seat => {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'selectedSeats';
            input.value = seat.id;
            container.appendChild(input);
        });
    }
</script>
</body>
</html>