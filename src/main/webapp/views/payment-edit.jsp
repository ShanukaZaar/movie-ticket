<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
    <title>CineBook | Edit Payment</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            background: #0a0a0a;
            color: white;
            font-family: Arial, sans-serif;
        }

        .cine-navbar {
            background: #111;
            border-bottom: 1px solid #e50914;
            padding: 15px 0;
        }

        .navbar-brand {
            color: #e50914 !important;
            font-size: 28px;
            font-weight: bold;
        }

        .page-wrapper {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 50px 15px;
        }

        .edit-card {
            width: 100%;
            max-width: 520px;
            background: #111;
            border: 1px solid #222;
            border-radius: 26px;
            padding: 30px;
            box-shadow: 0 0 35px rgba(229, 9, 20, 0.25);
        }

        .info-box {
            background: #181818;
            border: 1px solid #2a2a2a;
            border-radius: 18px;
            padding: 20px;
            margin-bottom: 22px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            color: #ddd;
        }

        .cine-input {
            background: #1c1c1c;
            border: 1px solid #333;
            color: white;
            border-radius: 12px;
            padding: 13px;
        }

        .cine-input:focus {
            background: #1c1c1c;
            color: white;
            border-color: #e50914;
            box-shadow: 0 0 0 0.25rem rgba(229, 9, 20, 0.25);
        }

        .cine-btn {
            background: #e50914;
            color: white;
            border-radius: 14px;
            padding: 14px;
            font-weight: bold;
            border: none;
            transition: 0.3s;
        }

        .cine-btn:hover {
            background: #b00610;
            color: white;
            transform: translateY(-2px);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 18px;
            color: #e50914;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-dark cine-navbar">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/payment">CineBook</a>
    </div>
</nav>

<div class="page-wrapper">

    <div class="edit-card">

        <h2 class="text-center mb-2">Edit Payment Status</h2>
        <p class="text-center text-secondary mb-4">Update payment record information</p>

        <%
            Payment payment = (Payment) request.getAttribute("payment");
        %>

        <% if (payment != null) { %>

        <div class="info-box">
            <div class="info-row">
                <span>Payment ID</span>
                <strong>#<%= payment.getId() %></strong>
            </div>

            <div class="info-row">
                <span>Booking ID</span>
                <strong><%= payment.getBookingId() %></strong>
            </div>

            <div class="info-row">
                <span>Amount</span>
                <strong>LKR <%= payment.getAmount() %></strong>
            </div>

            <div class="info-row">
                <span>Method</span>
                <strong><%= payment.getPaymentMethod() %></strong>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/payment" method="post">

            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= payment.getId() %>">

            <div class="mb-4">
                <label class="form-label">Payment Status</label>

                <select name="paymentStatus" class="form-select cine-input" required>
                    <option value="success" <%= "success".equalsIgnoreCase(payment.getPaymentStatus()) ? "selected" : "" %>>
                        Success
                    </option>

                    <option value="failed" <%= "failed".equalsIgnoreCase(payment.getPaymentStatus()) ? "selected" : "" %>>
                        Failed
                    </option>

                    <option value="pending" <%= "pending".equalsIgnoreCase(payment.getPaymentStatus()) ? "selected" : "" %>>
                        Pending
                    </option>

                    <option value="refunded" <%= "refunded".equalsIgnoreCase(payment.getPaymentStatus()) ? "selected" : "" %>>
                        Refunded
                    </option>
                </select>
            </div>

            <button type="submit" class="btn cine-btn w-100">
                Update Payment
            </button>

        </form>

        <% } else { %>

        <div class="info-box text-center">
            <p class="text-secondary">Payment record not found.</p>
        </div>

        <% } %>

        <a class="back-link" href="${pageContext.request.contextPath}/payment?action=list">
            Back to Payment Records
        </a>

    </div>

</div>

</body>
</html>