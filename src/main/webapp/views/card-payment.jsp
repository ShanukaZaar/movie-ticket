<!DOCTYPE html>
<html>
<head>
    <title>Card Payment</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
</head>
<body>

<div class="payment-page">
    <div class="payment-card">

        <div class="payment-header">
            <h1>Card Payment</h1>
            <p>Enter your card details securely</p>
        </div>

        <div class="payment-content">

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
            <div class="error-box"><%= error %></div>
            <% } %>

            <form id="cardPaymentForm" action="${pageContext.request.contextPath}/payment" method="post">

                <input type="hidden" name="bookingId" value="<%= request.getAttribute("bookingId") != null ? request.getAttribute("bookingId") : "1" %>">
                <input type="hidden" name="amount" value="<%= request.getAttribute("amount") != null ? request.getAttribute("amount") : "3010.24" %>">

                <label>Cardholder Name</label>
                <input type="text" name="cardholderName" id="cardholderName" required>
                <small class="error" id="nameError"></small>

                <label>Card Number</label>
                <input type="text" name="cardNumber" id="cardNumber" maxlength="16" required>
                <small class="error" id="cardError"></small>

                <div class="input-row">
                    <div>
                        <label>Expiry Month</label>
                        <select name="expiryMonth" id="expiryMonth" required>
                            <option value="">MM</option>
                            <% for (int i = 1; i <= 12; i++) { %>
                            <option value="<%= String.format("%02d", i) %>"><%= String.format("%02d", i) %></option>
                            <% } %>
                        </select>
                        <small class="error" id="monthError"></small>
                    </div>

                    <div>
                        <label>Expiry Year</label>
                        <select name="expiryYear" id="expiryYear" required>
                            <option value="">YYYY</option>
                            <% for (int y = 2026; y <= 2035; y++) { %>
                            <option value="<%= y %>"><%= y %></option>
                            <% } %>
                        </select>
                        <small class="error" id="yearError"></small>
                    </div>
                </div>

                <label>CVV</label>
                <input type="password" name="cvv" id="cvv" maxlength="3" required>
                <small class="error" id="cvvError"></small>

                <label>Billing Email</label>
                <input type="email" name="billingEmail" id="billingEmail" required>
                <small class="error" id="emailError"></small>

                <label>Payment Amount</label>
                <input type="number" value="<%= request.getAttribute("amount") != null ? request.getAttribute("amount") : "3010.24" %>" readonly>

                <button class="pay-btn" type="submit">Submit Payment</button>

                <a class="back-link" href="${pageContext.request.contextPath}/payment">
                    Back to Booking Summary
                </a>

            </form>

        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/payment.js"></script>
</body>
</html>