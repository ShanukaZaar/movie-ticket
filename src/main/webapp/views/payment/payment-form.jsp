<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; }
        .page-header { background: linear-gradient(135deg, #1a0000, #0a0a0a); padding: 50px 0 30px; border-bottom: 2px solid #e50914; }
        .page-header h1 span { color: #e50914; }
        .section { padding: 50px 0; }
        .payment-card { background: #1a1a1a; border-radius: 20px; border: 1px solid #333; padding: 40px; }
        .payment-card h4 { font-weight: 700; margin-bottom: 25px; color: #fff; }
        .method-btn {
            background: #111;
            border: 2px solid #333;
            color: #fff;
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-bottom: 15px;
        }
        .method-btn:hover, .method-btn.active {
            border-color: #e50914;
            background: #1a1a1a;
            color: #e50914;
        }
        .method-btn i { font-size: 2rem; display: block; margin-bottom: 8px; }
        .method-btn span { font-weight: 600; font-size: 0.95rem; }
        .summary-card { background: #111; border: 1px solid #333; border-radius: 15px; padding: 25px; }
        .summary-row { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px solid #222; color: #ccc; font-size: 0.9rem; }
        .summary-row:last-child { border-bottom: none; }
        .summary-total { display: flex; justify-content: space-between; padding: 12px 0; font-weight: 700; font-size: 1.1rem; }
        .summary-total span:last-child { color: #e50914; }
        .btn-proceed { background: #e50914; border: none; color: #fff; border-radius: 12px; padding: 14px 40px; font-weight: 700; font-size: 1rem; transition: all 0.3s; width: 100%; margin-top: 20px; }
        .btn-proceed:hover { background: #b20710; color: #fff; transform: translateY(-2px); }
        .btn-proceed:disabled { background: #333; color: #666; cursor: not-allowed; transform: none; }
    </style>
</head>
<body>

<c:set var="currentPage" value="booking" scope="request"/>
<%@ include file="../navbar.jsp" %>

<div class="page-header">
    <div class="container">
        <h1>Secure <span>Payment</span></h1>
        <p style="color:#aaa;">Choose your preferred payment method</p>
    </div>
</div>

<section class="section">
    <div class="container">
        <div class="row g-4">

            <%-- Payment Methods --%>
            <div class="col-lg-7">
                <div class="payment-card">
                    <h4><i class="bi bi-credit-card" style="color:#e50914;"></i> Select Payment Method</h4>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-danger" style="background:rgba(229,9,20,0.15); border:1px solid rgba(229,9,20,0.4); color:#ff6b6b; border-radius:10px;">
                            <%= request.getAttribute("error") %>
                        </div>
                    <% } %>

                    <div class="row g-3 mb-4">
                        <div class="col-4">
                            <button class="method-btn" onclick="selectMethod('credit_card', this)">
                                <i class="bi bi-credit-card"></i>
                                <span>Credit Card</span>
                            </button>
                        </div>
                        <div class="col-4">
                            <button class="method-btn" onclick="selectMethod('debit_card', this)">
                                <i class="bi bi-bank"></i>
                                <span>Debit Card</span>
                            </button>
                        </div>
                        <div class="col-4">
                            <button class="method-btn" onclick="selectMethod('online_banking', this)">
                                <i class="bi bi-laptop"></i>
                                <span>Online Banking</span>
                            </button>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/card-payment" method="post" id="paymentForm">
                        <input type="hidden" name="bookingId" value="${bookingId}">
                        <input type="hidden" name="amount" value="${amount}">
                        <input type="hidden" name="paymentMethod" id="paymentMethod" value="">

                        <div id="cardFields" style="display:none;">
                            <div class="mb-3">
                                <label style="color:#ccc; font-weight:500;">Card Holder Name</label>
                                <input type="text" name="cardHolderName" class="form-control"
                                       placeholder="Name on card"
                                       style="background:#111; border:2px solid #333; color:#fff; border-radius:10px; padding:12px;">
                            </div>
                            <div class="mb-3">
                                <label style="color:#ccc; font-weight:500;">Card Number</label>
                                <input type="text" name="cardNumber" class="form-control"
                                       placeholder="1234 5678 9012 3456" maxlength="19"
                                       style="background:#111; border:2px solid #333; color:#fff; border-radius:10px; padding:12px;"
                                       oninput="formatCardNumber(this)">
                            </div>
                            <div class="row g-3 mb-3">
                                <div class="col-4">
                                    <label style="color:#ccc; font-weight:500;">Expiry Month</label>
                                    <select name="expiryMonth" class="form-select"
                                            style="background:#111; border:2px solid #333; color:#fff; border-radius:10px; padding:12px;">
                                        <option value="">MM</option>
                                        <c:forEach begin="1" end="12" var="m">
                                            <option value="${m < 10 ? '0' : ''}${m}">${m < 10 ? '0' : ''}${m}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-4">
                                    <label style="color:#ccc; font-weight:500;">Expiry Year</label>
                                    <select name="expiryYear" class="form-select"
                                            style="background:#111; border:2px solid #333; color:#fff; border-radius:10px; padding:12px;">
                                        <option value="">YYYY</option>
                                        <c:forEach begin="2024" end="2035" var="y">
                                            <option value="${y}">${y}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-4">
                                    <label style="color:#ccc; font-weight:500;">CVV</label>
                                    <input type="password" name="cvv" class="form-control"
                                           placeholder="123" maxlength="4"
                                           style="background:#111; border:2px solid #333; color:#fff; border-radius:10px; padding:12px;">
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn-proceed" id="proceedBtn" disabled>
                            <i class="bi bi-lock"></i> Pay Rs. ${amount}
                        </button>
                    </form>
                </div>
            </div>

            <%-- Order Summary --%>
            <div class="col-lg-5">
                <div class="summary-card">
                    <h5 style="color:#e50914; font-weight:700; margin-bottom:20px;">
                        <i class="bi bi-receipt"></i> Order Summary
                    </h5>
                    <div class="summary-row">
                        <span>Booking ID</span>
                        <strong style="color:#fff;">#${bookingId}</strong>
                    </div>
                    <div class="summary-row">
                        <span>Payment Method</span>
                        <strong style="color:#fff;" id="selectedMethodDisplay">Not selected</strong>
                    </div>
                    <div class="summary-total">
                        <span>Total Amount</span>
                        <span>Rs. ${amount}</span>
                    </div>

                    <div style="margin-top:20px; padding:15px; background:#0a0a0a; border-radius:10px; text-align:center;">
                        <i class="bi bi-shield-lock" style="color:#e50914; font-size:1.5rem;"></i>
                        <p style="color:#aaa; font-size:0.85rem; margin:8px 0 0;">
                            Your payment is secured with 256-bit SSL encryption
                        </p>
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
    function selectMethod(method, btn) {
        document.querySelectorAll('.method-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        document.getElementById('paymentMethod').value = method;
        document.getElementById('cardFields').style.display = 'block';
        document.getElementById('proceedBtn').disabled = false;

        const labels = { credit_card: 'Credit Card', debit_card: 'Debit Card', online_banking: 'Online Banking' };
        document.getElementById('selectedMethodDisplay').textContent = labels[method];
    }

    function formatCardNumber(input) {
        let value = input.value.replace(/\s/g, '').replace(/\D/g, '');
        let formatted = value.match(/.{1,4}/g);
        input.value = formatted ? formatted.join(' ') : value;
    }
</script>
</body>
</html>