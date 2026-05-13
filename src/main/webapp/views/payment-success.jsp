<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/payment.css">

    <style>
        .success-page {
            min-height: 100vh;
            background: #111827;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 30px 15px;
        }

        .success-card {
            width: 100%;
            max-width: 460px;
            background: white;
            border-radius: 28px;
            padding: 40px 28px;
            text-align: center;
            box-shadow: 0 25px 60px rgba(0,0,0,0.35);
        }

        .success-icon {
            width: 90px;
            height: 90px;
            margin: 0 auto 22px;
            border-radius: 50%;
            background: #dcfce7;
            color: #166534;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            font-weight: bold;
        }

        .success-card h1 {
            margin: 0;
            font-size: 34px;
            color: #111827;
        }

        .success-card p {
            color: #4b5563;
            font-size: 17px;
            line-height: 1.6;
        }

        .status-box {
            background: #f9fafb;
            border: 1px solid #e5e7eb;
            border-radius: 18px;
            padding: 18px;
            margin: 24px 0;
        }

        .status-row {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            font-size: 16px;
        }

        .paid {
            color: #166534;
            font-weight: bold;
        }

        .success-btn {
            display: block;
            width: 100%;
            background: #f7d046;
            color: #111827;
            padding: 15px;
            border-radius: 16px;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
            margin-top: 14px;
        }

        .success-btn:hover {
            background: #eab308;
        }

        .secondary-link {
            display: block;
            margin-top: 18px;
            color: #2563eb;
            font-weight: bold;
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="success-page">

    <div class="success-card">

        <div class="success-icon">✓</div>

        <h1>Payment Successful!</h1>

        <p>Your payment was completed securely.</p>

        <div class="status-box">
            <div class="status-row">
                <span>Payment Status</span>
                <span class="paid">PAID</span>
            </div>

            <div class="status-row">
                <span>Booking Status</span>
                <span class="paid">PAID</span>
            </div>
        </div>

        <p>Your booking status has been updated successfully.</p>

        <a class="success-btn" href="${pageContext.request.contextPath}/payment">
            Make Another Payment
        </a>

        <a class="secondary-link" href="${pageContext.request.contextPath}/payment?action=list">
            View Payment Records
        </a>

    </div>

</div>

</body>
</html>