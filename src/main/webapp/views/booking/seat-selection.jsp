<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Seats - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 { font-size: 2rem; font-weight: 900; }
        .page-header h1 span { color: #e50914; }

        /* Screen */
        .screen { background: linear-gradient(180deg, #e50914, #7a0008); height: 8px; border-radius: 5px; margin: 30px auto 40px; width: 80%; box-shadow: 0 5px 20px rgba(229,9,20,0.5); }
        .screen-label { text-align: center; color: #aaa; font-size: 0.85rem; margin-bottom: 30px; }

        /* Seats */
        .seats-container { max-width: 700px; margin: 0 auto; }
        .seat-row { display: flex; justify-content: center; gap: 8px; margin-bottom: 8px; align-items: center; }
        .row-label { width: 25px; text-align: center; color: #555; font-size: 0.85rem; font-weight: 700; }
        .seat {
            width: 38px; height: 38px; border-radius: 8px 8px 4px 4px;
            cursor: pointer; display: flex; align-items: center; justify-content: center;
            font-size: 0.65rem; font-weight: 700; transition: all 0.2s; border: none;
            position: relative;
        }
        .seat.regular { background: #2a2a2a; color: #aaa; border: 2px solid #444; }
        .seat.regular:hover:not(.booked) { background: #e50914; color: #fff; border-color: #e50914; }
        .seat.premium { background: #1a1a3a; color: #7b8cde; border: 2px solid #3a3a7a; }
        .seat.premium:hover:not(.booked) { background: #3a3aaa; color: #fff; border-color: #5a5aff; }
        .seat.vip { background: #2a1a00; color: #f39c12; border: 2px solid #7a5000; }
        .seat.vip:hover:not(.booked) { background: #f39c12; color: #fff; border-color: #f39c12; }
        .seat.booked { background: #1a1a1a; color: #333; border-color: #222; cursor: not-allowed; }
        .seat.selected { background: #e50914 !important; color: #fff !important; border-color: #e50914 !important; transform: scale(1.1); }

        /* Legend */
        .legend { display: flex; gap: 20px; justify-content: center; margin: 30px 0; flex-wrap: wrap; }
        .legend-item { display: flex; align-items: center; gap: 8px; font-size: 0.85rem; color: #aaa; }
        .legend-box { width: 20px; height: 20px; border-radius: 4px; }

        /* Summary */
        .booking-summary { background: #1a1a1a; border: 2px solid #333; border-radius: 15px; padding: 25px; position: sticky; top: 80px; }
        .booking-summary h5 { color: #e50914; font-weight: 700; margin-bottom: 20px; }
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 10px; color: #ccc; font-size: 0.9rem; }
        .summary-total { display: flex; justify-content: space-between; font-weight: 700; font-size: 1.1rem; border-top: 1px solid #333; padding-top: 10px; margin-top: 10px; }
        .summary-total span:last-child { color: #e50914; }
        .btn-confirm { background: #e50914; border: none; color: #fff; width: 100%; border-radius: 10px; padding: 14px; font-weight: 700; font-size: 1rem; transition: all 0.3s; margin-top: 15px; }
        .btn-confirm:hover { background: #b20710; }
        .btn-confirm:disabled { background: #333; color: #666; cursor: not-allowed; }
        .selected-seats-list { color: #e50914; font-weight: 600; font-size: 0.9rem; min-height: 25px; }

        .section { padding: 40px 0; }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>🎭 Select Your <span>Seats</span></h1>
        <p style="color:#aaa;">
            ${show.movieTitle} •
            ${show.showDate} at ${show.showTime} •
            ${show.theaterName}
        </p>
    </div>
</div>

<section class="section">
    <div class="container">
        <div class="row">

            <%-- Seat Map --%>
            <div class="col-lg-8">
                <div class="screen"></div>
                <div class="screen-label">🎬 SCREEN</div>

                <div class="seats-container">
                    <c:set var="currentRow" value=""/>
                    <c:forEach var="seat" items="${seats}">
                        <c:set var="rowLetter" value="${fn:substring(seat.seatNumber, 0, 1)}"/>
                        <c:if test="${rowLetter != currentRow}">
                            <c:if test="${currentRow != ''}"></div></c:if>
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
                            ${fn:substring(seat.seatNumber, 1, fn:length(seat.seatNumber))}
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
                        <div class="legend-box" style="background:#1a1a1a; border:2px solid #222;"></div>
                        Booked
                    </div>
                </div>
            </div>

            <%-- Booking Summary --%>
            <div class="col-lg-4">
                <div class="booking-summary">
                    <h5><i class="bi bi-receipt"></i> Booking Summary</h5>

                    <div class="summary-row">
                        <span>Movie</span>
                        <span style="color:#fff;">${show.movieTitle}</span>
                    </div>
                    <div class="summary-row">
                        <span>Date</span>
                        <span style="color:#fff;">${show.showDate}</span>
                    </div>
                    <div class="summary-row">
                        <span>Time</span>
                        <span style="color:#fff;">${show.showTime}</span>
                    </div>
                    <div class="summary-row">
                        <span>Theater</span>
                        <span style="color:#fff;">${show.theaterName}</span>
                    </div>
                    <div class="summary-row">
                        <span>Price per seat</span>
                        <span style="color:#fff;">Rs. ${show.price}</span>
                    </div>

                    <hr style="border-color:#333;">

                    <div class="summary-row">
                        <span>Selected Seats</span>
                    </div>
                    <div class="selected-seats-list" id="selectedSeatsList">None selected</div>

                    <div class="summary-total">
                        <span>Total</span>
                        <span id="totalAmount">Rs. 0.00</span>
                    </div>

                    <form action="${pageContext.request.contextPath}/booking" method="post" id="bookingForm">
                        <input type="hidden" name="action" value="confirmBooking">
                        <input type="hidden" name="showId" value="${show.id}">
                        <div id="seatInputs"></div>
                        <button type="submit" class="btn-confirm" id="confirmBtn" disabled>
                            <i class="bi bi-ticket-perforated"></i> Confirm Booking
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>© 2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const pricePerSeat = ${show.price};
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

        document.getElementById('totalAmount').textContent = 'Rs. ' + total.toFixed(2);
        document.getElementById('confirmBtn').disabled = count === 0;

        // Update hidden inputs
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
