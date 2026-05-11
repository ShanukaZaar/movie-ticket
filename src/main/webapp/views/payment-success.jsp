<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
</head>
<body>

<h2>Payment Successful!</h2>

<p>Your payment has been saved successfully.</p>

<a href="${pageContext.request.contextPath}/payment">Make another payment</a>
<br>
<a href="${pageContext.request.contextPath}/payment?action=list">View Payments</a>

</body>
</html>