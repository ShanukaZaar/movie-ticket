<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Card Payment - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 span { color: #e50914; }
        .section { padding: 50px 0; }
        .payment-card { background: #1a1a1a; border-radius: 20px; border: 1px solid #333; padding: 40px; }
        .form-label { color: #ccc; font-weight: 500; }
        .form-control, .form-select {
            background: #111;
            border: 2px solid #333;
            color: #fff;
            border-radius: 10px;
            padding: 12px 15px;
        }
        .form-control:focus, .form-select:focus {
            background: #111;
            border-color: #e50914;
            color: #fff;
            box-shadow: 0 0 0 3px rgba(229,9,20,0.15);
        }
        .form-control::placeholder { color: #555; }
        .form-select option { background: #111; }
        .btn-pay {
            background: #e50914;
            border: none;
            color: #fff;
            border-radius: 12px;
            padding: 14px;
            font-weight: 700;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s;
            margin-top: 10px;
        }
        .btn-pay:hover { background: #b20710; color: #fff; transform: translateY(-2px); }
        .btn-back {
            background: transparent;
            border: 2px solid #555;
            color: #aaa;
            border-radius: 12px;
            padding: 14px;
            font-weight: 700;
            width: 100%;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
            text-align: center;
            margin-top: 10px;
        }
        .btn-back:hover { border-color: #fff; color: #fff; }
        .summary-card { background: #111; border: 1px solid #333; border-radius: 15px; padding: 25px; }
        .summary-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #222; color: #ccc; font-size: 0.9rem; }
        .summary-row:last-child { border-bottom: none; }
        .summary-total { display: flex; justify-content: space-between; padding: 12px 0; font-weight: 700; font-size: 1.1rem; }
        .summary-total span:last-child { color: #e50914; }
        .card-visual {
            background: linear-gradient(135deg, #e50914, #7a0008);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            position: relative;
            min-height: 160px;
        }
        .card-visual .card-number { font-size: 1.3rem; letter-spacing: 3px; margin-top: 20px; }
        .card-visual .card-name { font-size: 0.9rem; color: rgba(255,255,255,0.8); margin-top: 15px; }
        .error-alert {
            background: rgba(229,9,20,0.15);
            border: 1px solid rgba(229,9,20,0.4);
            color: #ff6b6b;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>Card <span>Payment</span></h1>
        <p style="color:#aaa;">Enter your card details to complete payment</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <div class="row g-4">

            <div class="col-lg-7">
                <div class="payment-card">

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="error-alert">
                            <i class="bi bi-exclamation-circle"></i>
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <%-- Card Visual --%>
                    <div class="card-visual">
                        <div style="display:flex; justify-content:space-between; align-items:center;">
                            <span style="font-weight:700; font-size:1.1rem;">CineBook Pay</span>
                            <i class="bi bi-credit-card-2-front" style="font-size:2rem;"></i>
                        </div>
                        <div class="card-number" id="cardDisplay">**** **** **** ****</div>
                        <div class="card-name" id="nameDisplay">CARD HOLDER NAME</div>
                    </div>

                    <form action="${pageContext.request.contextPath}/card-payment" method="post">
                        <input type="hidden" name="bookingId" value="${bookingId}">
                        <input type="hidden" name="amount" value="${amount}">
                        <input type="hidden" name="paymentMethod" value="credit_card">

                        <div class="mb-3">
                            <label class="form-label">Card Holder Name</label>
                            <input type="text" name="cardHolderName" class="form-control"
                                   placeholder="Name as on card" required
                                   oninput="document.getElementById('nameDisplay').textContent = this.value.toUpperCase() || 'CARD HOLDER NAME'">
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Card Number</label>
                            <input type="text" name="cardNumber" class="form-control"
                                   placeholder="1234 5678 9012 3456" maxlength="19" required
                                   oninput="formatCard(this)">
                        </div>
                        <div class="row g-3 mb-3">
                            <div class="col-4">
                                <label class="form-label">Expiry Month</label>
                                <select name="expiryMonth" class="form-select" required>
                                    <option value="">MM</option>
                                    <c:forEach begin="1" end="12" var="m">
                                        <option value="${m < 10 ? '0' : ''}${m}">${m < 10 ? '0' : ''}${m}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-4">
                                <label class="form-label">Expiry Year</label>
                                <select name="expiryYear" class="form-select" required>
                                    <option value="">YYYY</option>
                                    <c:forEach begin="2024" end="2035" var="y">
                                        <option value="${y}">${y}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-4">
                                <label class="form-label">CVV</label>
                                <input type="password" name="cvv" class="form-control"
                                       placeholder="123" maxlength="4" required>
                            </div>
                        </div>

                        <button type="submit" class="btn-pay">
                            <i class="bi bi-lock"></i> Pay Rs. ${amount} Securely
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/booking?action=myBookings"
                       class="btn-back">Cancel</a>
                </div>
            </div>

            <div class="col-lg-5">
                <div class="summary-card">
                    <h5 style="color:#e50914; font-weight:700; margin-bottom:20px;">
                        <i class="bi bi-receipt"></i> Payment Summary
                    </h5>
                    <div class="summary-row">
                        <span>Booking ID</span>
                        <strong style="color:#fff;">#${bookingId}</strong>
                    </div>
                    <div class="summary-row">
                        <span>Payment Method</span>
                        <strong style="color:#fff;">Credit Card</strong>
                    </div>
                    <div class="summary-total">
                        <span>Total</span>
                        <span>Rs. ${amount}</span>
                    </div>

                    <div style="margin-top:20px; padding:15px; background:#0a0a0a; border-radius:10px;">
                        <div style="display:flex; align-items:center; gap:10px; margin-bottom:8px;">
                            <i class="bi bi-shield-check" style="color:#28a745; font-size:1.2rem;"></i>
                            <span style="color:#aaa; font-size:0.85rem;">SSL Encrypted Payment</span>
                        </div>
                        <div style="display:flex; align-items:center; gap:10px; margin-bottom:8px;">
                            <i class="bi bi-lock" style="color:#28a745; font-size:1.2rem;"></i>
                            <span style="color:#aaa; font-size:0.85rem;">Secure 256-bit encryption</span>
                        </div>
                        <div style="display:flex; align-items:center; gap:10px;">
                            <i class="bi bi-patch-check" style="color:#28a745; font-size:1.2rem;"></i>
                            <span style="color:#aaa; font-size:0.85rem;">PCI DSS Compliant</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<footer style="background:#000; border-top:2px solid #e50914; padding:20px 0; text-align:center; color:#555;">
    <p>2024 CineBook. All rights reserved.</p>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function formatCard(input) {
        let value = input.value.replace(/\s/g, '').replace(/\D/g, '');
        let formatted = value.match(/.{1,4}/g);
        input.value = formatted ? formatted.join(' ') : value;

        let display = value.padEnd(16, '*').match(/.{1,4}/g);
        document.getElementById('cardDisplay').textContent =
            display ? display.join(' ') : '**** **** **** ****';
    }
</script>
</body>
</html>