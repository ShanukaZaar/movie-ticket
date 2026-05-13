<!DOCTYPE html>
<html>
<head>
    <title>CineBook | Payment</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/payment.css" rel="stylesheet">
</head>

<body>

<nav class="navbar navbar-dark cine-navbar">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">CineBook</a>
    </div>
</nav>

<div class="payment-wrapper">

    <div class="payment-card">

        <h2 class="text-center mb-2">Payment Checkout</h2>
        <p class="text-center text-secondary mb-4">Complete your movie ticket payment</p>

        <div class="summary-box mb-4">
            <h4>Booking Summary</h4>

            <div class="summary-row">
                <span>Movie</span>
                <strong>Selected Movie</strong>
            </div>

            <div class="summary-row">
                <span>Cinema</span>
                <strong>Main Theater</strong>
            </div>

            <div class="summary-row">
                <span>Seats</span>
                <strong>A1, A2</strong>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/payment" method="get">

            <input type="hidden" name="action" value="selectMethod">

            <div class="mb-3">
                <label class="form-label">Booking ID</label>
                <input type="number" class="form-control cine-input" name="bookingId" value="1" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Amount</label>
                <input type="number" class="form-control cine-input" name="amount" value="3010.24" step="0.01" required>
            </div>

            <div class="mb-4">
                <label class="form-label">Payment Method</label>
                <select class="form-select cine-input" name="paymentMethod" required>
                    <option value="credit_card">Credit Card</option>
                    <option value="debit_card">Debit Card</option>
                    <option value="online_banking">Online Banking</option>
                </select>
            </div>

            <button type="submit" class="btn cine-btn w-100">Pay Now</button>

        </form>

        <a class="record-link" href="${pageContext.request.contextPath}/payment?action=list">
            View Payment Records
        </a>

    </div>

</div>

</body>
</html>