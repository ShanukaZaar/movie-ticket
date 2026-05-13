<!DOCTYPE html>
<html>
<head>
    <title>CineBook | Card Payment</title>

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

        <h2 class="text-center mb-2">Card Payment</h2>
        <p class="text-center text-secondary mb-4">Enter your credit card details securely</p>

        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
        <div class="error-box"><%= error %></div>
        <% } %>

        <form id="cardPaymentForm" action="${pageContext.request.contextPath}/card-payment" method="post">

            <input type="hidden" name="bookingId" value="<%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "1" %>">
            <input type="hidden" name="amount" value="<%= request.getAttribute("amount") != null ? request.getAttribute("amount") : "3010.24" %>">

            <div class="mb-3">
                <label class="form-label">Cardholder Name</label>
                <input type="text" class="form-control cine-input" name="cardholderName" id="cardholderName" required>
                <small class="error-text" id="nameError"></small>
            </div>

            <div class="mb-3">
                <label class="form-label">Card Number</label>
                <input type="text" class="form-control cine-input" name="cardNumber" id="cardNumber" maxlength="16" required>
                <small class="error-text" id="cardError"></small>
            </div>

            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Expiry Month</label>
                    <select class="form-select cine-input" name="expiryMonth" id="expiryMonth" required>
                        <option value="">MM</option>
                        <% for (int i = 1; i <= 12; i++) { %>
                        <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                        <% } %>
                    </select>
                    <small class="error-text" id="monthError"></small>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Expiry Year</label>
                    <select class="form-select cine-input" name="expiryYear" id="expiryYear" required>
                        <option value="">YYYY</option>
                        <% for (int y = 2026; y <= 2035; y++) { %>
                        <option value="<%= y %>"><%= y %></option>
                        <% } %>
                    </select>
                    <small class="error-text" id="yearError"></small>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">CVV</label>
                <input type="password" class="form-control cine-input" name="cvv" id="cvv" maxlength="3" required>
                <small class="error-text" id="cvvError"></small>
            </div>

            <div class="mb-3">
                <label class="form-label">Billing Email</label>
                <input type="email" class="form-control cine-input" name="billingEmail" id="billingEmail" required>
                <small class="error-text" id="emailError"></small>
            </div>

            <div class="mb-4">
                <label class="form-label">Amount</label>
                <input type="number" class="form-control cine-input" value="<%= request.getAttribute("amount") != null ? request.getAttribute("amount") : "3010.24" %>" readonly>
            </div>

            <button class="btn cine-btn w-100" type="submit">Pay Securely</button>

            <a class="back-link" href="${pageContext.request.contextPath}/payment">
                Back to Booking Summary
            </a>

        </form>

    </div>

</div>

<script src="${pageContext.request.contextPath}/js/payment.js"></script>
</body>
</html>