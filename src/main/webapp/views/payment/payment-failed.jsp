<!DOCTYPE html>
<html>
<head>
  <title>CineBook | Payment Failed</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/payment.css" rel="stylesheet">
</head>

<body>

<div class="payment-wrapper">
  <div class="payment-card text-center">

    <div class="failed-icon">✕</div>

    <h2 class="mt-3">Payment Failed!</h2>

    <p class="text-secondary mt-3">
      Something went wrong while processing your payment.
    </p>

    <a class="btn cine-btn w-100 mt-3" href="${pageContext.request.contextPath}/payment">
      Retry Payment
    </a>

  </div>
</div>

</body>
</html>