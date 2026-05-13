<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Payment</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #111827, #374151);
        }

        .page {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px;
        }

        .card {
            width: 100%;
            max-width: 450px;
            background: white;
            border-radius: 20px;
            padding: 28px;
            box-shadow: 0 18px 45px rgba(0,0,0,0.3);
        }

        h2 {
            margin-top: 0;
            text-align: center;
        }

        .info {
            background: #f9fafb;
            padding: 16px;
            border-radius: 14px;
            margin-bottom: 20px;
            border: 1px solid #e5e7eb;
        }

        .info p {
            margin: 8px 0;
        }

        label {
            font-weight: bold;
        }

        select {
            width: 100%;
            padding: 13px;
            border-radius: 12px;
            border: 1px solid #d1d5db;
            margin-top: 8px;
            margin-bottom: 18px;
        }

        .btn {
            width: 100%;
            padding: 14px;
            border: none;
            border-radius: 12px;
            background: #facc15;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
        }

        .btn:hover {
            background: #eab308;
        }

        .back {
            display: block;
            margin-top: 18px;
            text-align: center;
            color: #2563eb;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="page">
    <div class="card">

        <h2>Update Payment</h2>

        <%
            Payment payment = (Payment) request.getAttribute("payment");
        %>

        <% if (payment != null) { %>

        <div class="info">
            <p><strong>Payment ID:</strong> <%= payment.getId() %></p>
            <p><strong>Booking ID:</strong> <%= payment.getBookingId() %></p>
            <p><strong>Amount:</strong> LKR <%= payment.getAmount() %></p>
            <p><strong>Method:</strong> <%= payment.getPaymentMethod() %></p>
        </div>

        <form action="${pageContext.request.contextPath}/payment" method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= payment.getId() %>">

            <label>Status</label>
            <select name="status" required>
                <option value="success" <%= "success".equals(payment.getStatus()) ? "selected" : "" %>>Success</option>
                <option value="failed" <%= "failed".equals(payment.getStatus()) ? "selected" : "" %>>Failed</option>
                <option value="refunded" <%= "refunded".equals(payment.getStatus()) ? "selected" : "" %>>Refunded</option>
                <option value="pending" <%= "pending".equals(payment.getStatus()) ? "selected" : "" %>>Pending</option>
            </select>

            <button class="btn" type="submit">Update Status</button>

        </form>

        <% } else { %>
        <p>Payment not found.</p>
        <% } %>

        <a class="back" href="${pageContext.request.contextPath}/payment?action=list">
            Back to Payment List
        </a>

    </div>
</div>

</body>
</html>