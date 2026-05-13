<!DOCTYPE html>
<html>
<head>
    <title>CineBook | Payment Success</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/payment.css" rel="stylesheet">
</head>

<body>

<div class="payment-wrapper">

    <div class="payment-card text-center">

        <div class="success-icon">✓</div>

        <h2 class="mt-3">Payment Successful!</h2>

        <p class="text-secondary mt-3">
            Your payment was completed securely.
        </p>

        <p class="text-secondary">
            Your booking status has been updated to <strong class="text-success">PAID</strong>.
        </p>

        <a class="btn cine-btn w-100 mt-3" href="${pageContext.request.contextPath}/payment?action=list">
            View Booking
        </a>

        <a class="record-link" href="${pageContext.request.contextPath}/">
            Back to Home
        </a>

    </div>

</div>

</body>
</html>