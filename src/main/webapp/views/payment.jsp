<!DOCTYPE html>
<html>
<head>
    <title>Payment Page</title>
</head>
<body>

<h2>Make Payment</h2>

<form action="/payment" method="post">

    Booking ID:<br>
    <input type="number" name="bookingId" required><br><br>

    Amount:<br>
    <input type="number" name="amount" required><br><br>

    Payment Method:<br>
    <select name="paymentMethod">
        <option value="card">Card</option>
        <option value="cash">Cash</option>
    </select><br><br>

    <button type="submit">Pay Now</button>

</form>

</body>
</html>