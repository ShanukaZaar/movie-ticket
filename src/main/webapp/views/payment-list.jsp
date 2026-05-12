<%@ page import="java.util.List" %>
<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment Records</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">
</head>
<body>

<div class="list-container">

    <div class="list-top">
        <h2>Payment Records</h2>
        <a class="add-btn" href="${pageContext.request.contextPath}/payment">Add Payment</a>
    </div>

    <table>
        <tr>
            <th>ID</th>
            <th>Booking ID</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
            List<Payment> payments = (List<Payment>) request.getAttribute("payments");

            if (payments != null && !payments.isEmpty()) {
                for (Payment p : payments) {
        %>

        <tr>
            <td><%= p.getId() %></td>
            <td><%= p.getBookingId() %></td>
            <td>LKR <%= p.getAmount() %></td>
            <td><%= p.getPaymentMethod() %></td>
            <td>
                <span class="status <%= p.getPaymentStatus() %>">
                    <%= p.getPaymentStatus() %>
                </span>
            </td>
            <td>
                <a class="action delete"
                   href="${pageContext.request.contextPath}/payment?action=delete&id=<%= p.getId() %>"
                   onclick="return confirm('Delete this payment record?');">
                    Delete
                </a>
            </td>
        </tr>

        <%
            }
        } else {
        %>

        <tr>
            <td colspan="6" style="text-align:center; padding:25px;">
                No payment records found.
            </td>
        </tr>

        <%
            }
        %>
    </table>

</div>

</body>
</html>