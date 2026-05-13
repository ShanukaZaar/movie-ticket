<%@ page import="java.util.List" %>
<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
    <title>CineBook | Payment Records</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            background: #0a0a0a;
            color: #fff;
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
            padding: 45px 15px;
        }

        .records-card {
            max-width: 1200px;
            margin: auto;
            background: #111;
            border: 1px solid #222;
            border-radius: 26px;
            padding: 30px;
            box-shadow: 0 0 35px rgba(229, 9, 20, 0.25);
        }

        .top-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 25px;
        }

        h1 {
            font-size: 36px;
            font-weight: bold;
            margin: 0;
        }

        .subtitle {
            color: #aaa;
            margin-top: 6px;
        }

        .add-btn {
            background: #e50914;
            color: white;
            padding: 12px 20px;
            border-radius: 14px;
            text-decoration: none;
            font-weight: bold;
            transition: 0.3s;
        }

        .add-btn:hover {
            background: #b00610;
            color: white;
            transform: translateY(-2px);
        }

        .table-box {
            overflow-x: auto;
            border-radius: 18px;
            border: 1px solid #2a2a2a;
        }

        table {
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
        }

        thead th {
            background: #e50914;
            color: white;
            padding: 16px;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        tbody td {
            background: #181818;
            color: #f5f5f5;
            padding: 16px;
            border-bottom: 1px solid #2a2a2a;
            vertical-align: middle;
        }

        tbody tr:hover td {
            background: #222;
            transition: 0.3s;
        }

        .payment-id {
            color: #e50914;
            font-weight: bold;
        }

        .amount {
            font-weight: bold;
        }

        .method-badge {
            background: #262626;
            color: #ddd;
            border: 1px solid #333;
            padding: 7px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .status-badge {
            padding: 7px 13px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            text-transform: capitalize;
            display: inline-block;
        }

        .success-badge {
            background: rgba(34, 197, 94, 0.18);
            color: #22c55e;
            border: 1px solid rgba(34, 197, 94, 0.35);
        }

        .failed-badge {
            background: rgba(229, 9, 20, 0.18);
            color: #ff4d57;
            border: 1px solid rgba(229, 9, 20, 0.45);
        }

        .pending-badge {
            background: rgba(250, 204, 21, 0.16);
            color: #facc15;
            border: 1px solid rgba(250, 204, 21, 0.35);
        }

        .refunded-badge {
            background: rgba(59, 130, 246, 0.16);
            color: #60a5fa;
            border: 1px solid rgba(59, 130, 246, 0.35);
        }

        .action-btn {
            padding: 8px 14px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
            transition: 0.3s;
            display: inline-block;
            margin-right: 8px;
        }

        .edit-btn {
            border: 1px solid #2563eb;
            color: #60a5fa;
        }

        .edit-btn:hover {
            background: #2563eb;
            color: white;
        }

        .delete-btn {
            border: 1px solid #e50914;
            color: #ff4d57;
        }

        .delete-btn:hover {
            background: #e50914;
            color: white;
        }

        .empty-box {
            padding: 45px 20px;
            text-align: center;
            background: #181818;
            border-radius: 18px;
            color: #aaa;
        }

        .safe-note {
            margin-top: 18px;
            color: #777;
            font-size: 14px;
        }

        @media(max-width:768px) {

            h1 {
                font-size: 28px;
            }

            .records-card {
                padding: 20px;
            }

            thead th,
            tbody td {
                padding: 12px;
                font-size: 14px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar navbar-dark cine-navbar">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/payment">
            CineBook
        </a>
    </div>
</nav>

<div class="page-wrapper">

    <div class="records-card">

        <div class="top-section">

            <div>
                <h1>Payment Records</h1>
                <p class="subtitle">
                    View and manage all payment transactions
                </p>
            </div>

            <a class="add-btn"
               href="${pageContext.request.contextPath}/payment">
                + Add Payment
            </a>

        </div>

        <%
            List<Payment> payments =
                    (List<Payment>) request.getAttribute("payments");

            if (payments != null && !payments.isEmpty()) {
        %>

        <div class="table-box">

            <table>

                <thead>
                <tr>
                    <th>ID</th>
                    <th>Booking ID</th>
                    <th>Amount</th>
                    <th>Method</th>
                    <th>Status</th>
                    <th>Email</th>
                    <th>Card</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>

                <%
                    for (Payment p : payments) {

                        String status =
                                p.getPaymentStatus();

                        String statusClass =
                                "pending-badge";

                        if ("success".equalsIgnoreCase(status)) {
                            statusClass = "success-badge";
                        }
                        else if ("failed".equalsIgnoreCase(status)) {
                            statusClass = "failed-badge";
                        }
                        else if ("refunded".equalsIgnoreCase(status)) {
                            statusClass = "refunded-badge";
                        }
                %>

                <tr>

                    <td class="payment-id">
                        #<%= p.getId() %>
                    </td>

                    <td>
                        <%= p.getBookingId() %>
                    </td>

                    <td class="amount">
                        LKR <%= p.getAmount() %>
                    </td>

                    <td>
                        <span class="method-badge">
                            <%= p.getPaymentMethod() %>
                        </span>
                    </td>

                    <td>
                        <span class="status-badge <%= statusClass %>">
                            <%= p.getPaymentStatus() %>
                        </span>
                    </td>

                    <td>
                        <%= p.getBillingEmail() %>
                    </td>

                    <td>
                        **** <%= p.getLastFourDigits() %>
                    </td>

                    <td>
                        <%= p.getPaymentDate() %>
                    </td>

                    <td>

                        <a class="action-btn edit-btn"
                           href="${pageContext.request.contextPath}/payment?action=edit&id=<%= p.getId() %>">
                            Edit
                        </a>

                        <a class="action-btn delete-btn"
                           href="${pageContext.request.contextPath}/payment?action=delete&id=<%= p.getId() %>"
                           onclick="return confirm('Delete this payment record?');">
                            Delete
                        </a>

                    </td>

                </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

        <p class="safe-note">
            Secure payment system enabled.
            Full card numbers and CVV are never stored.
        </p>

        <%
        } else {
        %>

        <div class="empty-box">

            <h4>No Payment Records Found</h4>

            <p>
                No payment transactions have been created yet.
            </p>

            <a class="add-btn d-inline-block mt-3"
               href="${pageContext.request.contextPath}/payment">
                Create Payment
            </a>

        </div>

        <%
            }
        %>

    </div>

</div>

</body>
</html>