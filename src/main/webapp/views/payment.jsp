<!DOCTYPE html>
<html>
<head>
    <title>Payment Checkout</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
</head>
<body>

<div class="payment-page">
    <div class="payment-card">

        <div class="payment-header">
            <h1>Payment Checkout</h1>
            <p>Complete your movie ticket payment</p>
        </div>

        <div class="payment-content">

            <div class="summary-box">
                <h2>Booking Summary</h2>

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

                <label>Booking ID</label>
                <input type="number" name="bookingId" value="1" required>

                <label>Amount</label>
                <input type="number" name="amount" value="3010.24" step="0.01" required>

                <label>Payment Method</label>
                <select name="paymentMethod" required>
                    <option value="credit_card">Credit Card</option>
                    <option value="debit_card">Debit Card</option>
                    <option value="online_banking">Online Banking</option>
                </select>

                <button class="pay-btn" type="submit">Pay Now</button>
            </form>

            <a class="records-link" href="${pageContext.request.contextPath}/payment?action=list">
                View Payment Records
            </a>

        </div>
    </div>
</div>

</body>
</html>