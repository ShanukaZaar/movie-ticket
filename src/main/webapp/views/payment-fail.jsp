<!DOCTYPE html>
<html>
<head>
    <title>Payment Failed</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #fee2e2;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .box {
            background: white;
            padding: 35px;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
            max-width: 420px;
        }

        h2 {
            color: #991b1b;
        }

        a {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 18px;
            border-radius: 12px;
            background: #facc15;
            color: #111827;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="box">
    <h2>Payment Failed!</h2>
    <p>Something went wrong. Please try again.</p>

    <a href="${pageContext.request.contextPath}/payment">Try Again</a>
</div>

</body>
</html>