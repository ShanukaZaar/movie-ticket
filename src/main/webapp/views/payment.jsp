<!DOCTYPE html>
<html>
<head>
    <title>Payment</title>
</head>
<body>

<h2>Make Payment</h2>

<form action="${pageContext.request.contextPath}/payment" method="post">

    <label>Booking ID:</label><br>
    <input type="number" name="bookingId" required><br><br>

    <label>Amount:</label><br>
    <input type="number" name="amount" step="0.01" required><br><br>

    <label>Payment Method:</label><br>
    <select name="paymentMethod" required>
        <option value="credit_card">Credit Card</option>
        <option value="debit_card">Debit Card</option>
        <option value="online_banking">Online Banking</option>
    </select><br><br>

    <button type="submit">Pay Now</button>

</form>

</body>
</html>