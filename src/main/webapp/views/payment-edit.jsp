<%@ page import="com.movieticket.model.Payment" %>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Payment</title>
</head>
<body>

<h2>Update Payment Status</h2>

<%
    Payment payment = (Payment) request.getAttribute("payment");
%>

<% if (payment != null) { %>

<form action="${pageContext.request.contextPath}/payment" method="post">

    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%= payment.getId() %>">

    <p><strong>Payment ID:</strong> <%= payment.getId() %></p>
    <p><strong>Booking ID:</strong> <%= payment.getBookingId() %></p>
    <p><strong>Amount:</strong> <%= payment.getAmount() %></p>
    <p><strong>Method:</strong> <%= payment.getPaymentMethod() %></p>

    <label>Status:</label><br>
    <select name="status" required>
        <option value="success" <%= "success".equals(payment.getStatus()) ? "selected" : "" %>>Success</option>
        <option value="failed" <%= "failed".equals(payment.getStatus()) ? "selected" : "" %>>Failed</option>
        <option value="refunded" <%= "refunded".equals(payment.getStatus()) ? "selected" : "" %>>Refunded</option>
        <option value="pending" <%= "pending".equals(payment.getStatus()) ? "selected" : "" %>>Pending</option>
    </select>

    <br><br>
    <button type="submit">Update Status</button>

</form>

<% } else { %>
<p>Payment not found.</p>
<% } %>

<br>
<a href="${pageContext.request.contextPath}/payment?action=list">Back to Payment List</a>

</body>
</html>