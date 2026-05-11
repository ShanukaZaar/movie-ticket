<%@ page import="java.util.List" %>
<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
    <title>Payment List</title>
</head>
<body>

<h2>Payment Records</h2>

<a href="${pageContext.request.contextPath}/payment">Add New Payment</a>
<br><br>

<table border="1" cellpadding="10">
    <tr>
        <th>ID</th>
        <th>Booking ID</th>
        <th>Amount</th>
        <th>Method</th>
        <th>Status</th>
        <th>Date</th>
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
        <td><%= p.getAmount() %></td>
        <td><%= p.getPaymentMethod() %></td>
        <td><%= p.getStatus() %></td>
        <td><%= p.getPaymentDate() %></td>
        <td>
            <a href="${pageContext.request.contextPath}/payment?action=edit&id=<%= p.getId() %>">Edit</a>
            |
            <a href="${pageContext.request.contextPath}/payment?action=delete&id=<%= p.getId() %>"
               onclick="return confirm('Are you sure you want to delete this payment?');">
                Delete
            </a>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="7">No payment records found.</td>
    </tr>
    <%
        }
    %>

</table>

</body>
</html>
