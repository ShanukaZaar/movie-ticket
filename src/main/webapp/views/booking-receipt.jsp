<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
  <title>CineBook | Booking Receipt</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

  <style>
    body { background:#0a0a0a; color:white; font-family:Arial,sans-serif; }
    .receipt-card {
      max-width: 520px;
      margin: 60px auto;
      background:#111;
      border:1px solid #222;
      border-radius:26px;
      padding:30px;
      box-shadow:0 0 35px rgba(229,9,20,0.25);
    }
    .brand { color:#e50914; font-weight:bold; }
    .row-line {
      display:flex;
      justify-content:space-between;
      padding:12px 0;
      border-bottom:1px solid #222;
    }
    .success { color:#22c55e; font-weight:bold; }
    .btn-red {
      background:#e50914;
      color:white;
      border-radius:14px;
      padding:13px;
      text-decoration:none;
      display:block;
      text-align:center;
      margin-top:20px;
      font-weight:bold;
    }
  </style>
</head>
<body>

<%
  Payment payment = (Payment) request.getAttribute("payment");
%>

<div class="receipt-card">

  <h2 class="brand text-center">CineBook Receipt</h2>

  <% if (payment != null) { %>

  <p class="text-center text-secondary">Your booking has been confirmed.</p>

  <div class="row-line">
    <span>Transaction ID</span>
    <strong><%= payment.getTransactionId() %></strong>
  </div>

  <div class="row-line">
    <span>Booking ID</span>
    <strong><%= payment.getBookingId() %></strong>
  </div>

  <div class="row-line">
    <span>Amount</span>
    <strong>LKR <%= payment.getAmount() %></strong>
  </div>

  <div class="row-line">
    <span>Payment Method</span>
    <strong><%= payment.getPaymentMethod() %></strong>
  </div>

  <div class="row-line">
    <span>Card</span>
    <strong>**** <%= payment.getLastFourDigits() %></strong>
  </div>

  <div class="row-line">
    <span>Email</span>
    <strong><%= payment.getBillingEmail() %></strong>
  </div>

  <div class="row-line">
    <span>Status</span>
    <strong class="success"><%= payment.getPaymentStatus() %></strong>
  </div>

  <div class="row-line">
    <span>Email Confirmation</span>
    <strong><%= payment.getEmailSent() %></strong>
  </div>

  <a class="btn-red" href="${pageContext.request.contextPath}/payment?action=list">
    View Payment Records
  </a>

  <% } else { %>

  <p class="text-center text-danger">Receipt not found.</p>

  <a class="btn-red" href="${pageContext.request.contextPath}/payment">
    Back to Payment
  </a>

  <% } %>

</div>

</body>
</html>