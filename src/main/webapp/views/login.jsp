<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            min-height: 100vh;
            background: #0a0a0a;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }

        .login-wrapper {
            display: flex;
            width: 900px;
            min-height: 560px;
            border-radius: 25px;
            overflow: hidden;
            box-shadow: 0 30px 80px rgba(229,9,20,0.3);
        }

        /* Left Panel */
        .login-left {
            flex: 1;
            background: linear-gradient(135deg, #e50914 0%, #b20710 50%, #7a0008 100%);
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .login-left::before {
            content: '🎬';
            font-size: 20rem;
            position: absolute;
            opacity: 0.08;
            top: -50px;
            right: -50px;
        }
        .login-left h2 {
            font-size: 2.5rem;
            font-weight: 900;
            color: #fff;
            margin-bottom: 15px;
        }
        .login-left p {
            color: rgba(255,255,255,0.85);
            font-size: 1rem;
            line-height: 1.6;
            margin-bottom: 30px;
        }
        .feature-item {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
            text-align: left;
        }
        .feature-item i { font-size: 1.3rem; color: #fff; }
        .feature-item span { color: rgba(255,255,255,0.9); font-size: 0.95rem; }

        /* Right Panel */
        .login-right {
            flex: 1;
            background: #1a1a1a;
            padding: 50px 45px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .brand-link {
            color: #e50914;
            font-size: 1.5rem;
            font-weight: 900;
            text-decoration: none;
            display: block;
            margin-bottom: 30px;
        }
        .login-right h3 {
            font-size: 1.8rem;
            font-weight: 800;
            color: #fff;
            margin-bottom: 5px;
        }
        .login-right .subtitle {
            color: #aaa;
            font-size: 0.95rem;
            margin-bottom: 30px;
        }

        .form-label { color: #ccc; font-weight: 500; font-size: 0.9rem; margin-bottom: 6px; }
        .input-group-icon { position: relative; }
        .input-group-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #555;
            font-size: 1rem;
            z-index: 1;
        }
        .input-group-icon input {
            background: #111;
            border: 2px solid #333;
            color: #fff;
            border-radius: 12px;
            padding: 12px 15px 12px 42px;
            width: 100%;
            font-size: 0.95rem;
            transition: all 0.3s;
        }
        .input-group-icon input:focus {
            outline: none;
            border-color: #e50914;
            background: #111;
            box-shadow: 0 0 0 3px rgba(229,9,20,0.15);
            color: #fff;
        }
        .input-group-icon input::placeholder { color: #555; }

        .btn-login-submit {
            width: 100%;
            background: linear-gradient(135deg, #e50914, #b20710);
            border: none;
            color: #fff;
            border-radius: 12px;
            padding: 14px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            margin-top: 10px;
        }
        .btn-login-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(229,9,20,0.4);
        }

        .divider {
            display: flex;
            align-items: center;
            gap: 15px;
            margin: 20px 0;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #333;
        }
        .divider span { color: #555; font-size: 0.85rem; }

        .alert-danger-custom {
            background: rgba(229,9,20,0.15);
            border: 1px solid rgba(229,9,20,0.4);
            color: #ff6b6b;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }
        .alert-success-custom {
            background: rgba(40,167,69,0.15);
            border: 1px solid rgba(40,167,69,0.4);
            color: #51cf66;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
            font-size: 0.9rem;
        }

        .register-link {
            text-align: center;
            margin-top: 20px;
            color: #aaa;
            font-size: 0.9rem;
        }
        .register-link a {
            color: #e50914;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link a:hover { text-decoration: underline; }

        @media (max-width: 768px) {
            .login-wrapper { flex-direction: column; width: 95%; }
            .login-left { padding: 30px; min-height: 200px; }
            .login-right { padding: 30px; }
        }
    </style>
</head>
<body>

<div class="login-wrapper">

    <%-- Left Panel --%>
    <div class="login-left">
        <h2>Welcome Back!</h2>
        <p>Login to book your favorite movie tickets and enjoy the cinema experience.</p>
        <div class="feature-item">
            <i class="bi bi-ticket-perforated"></i>
            <span>Easy ticket booking</span>
        </div>
        <div class="feature-item">
            <i class="bi bi-grid-3x3"></i>
            <span>Choose your own seats</span>
        </div>
        <div class="feature-item">
            <i class="bi bi-shield-check"></i>
            <span>Secure & fast payment</span>
        </div>
        <div class="feature-item">
            <i class="bi bi-bell"></i>
            <span>Instant confirmation</span>
        </div>
    </div>

    <%-- Right Panel --%>
    <div class="login-right">
        <a href="${pageContext.request.contextPath}/home" class="brand-link">CineBook</a>
        <h3>Sign In</h3>
        <p class="subtitle">Enter your credentials to access your account</p>

        <%-- Success message after registration --%>
        <% if ("true".equals(request.getParameter("registered"))) { %>
            <div class="alert-success-custom">
                <i class="bi bi-check-circle"></i> Registration successful! Please login.
            </div>
        <% } %>

        <%-- Error message --%>
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert-danger-custom">
                <i class="bi bi-exclamation-circle"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group-icon">
                    <i class="bi bi-envelope"></i>
                    <input type="email" name="email" placeholder="Enter your email" required>
                </div>
            </div>
            <div class="mb-4">
                <label class="form-label">Password</label>
                <div class="input-group-icon">
                    <i class="bi bi-lock"></i>
                    <input type="password" name="password" placeholder="Enter your password" required>
                </div>
            </div>

            <button type="submit" class="btn-login-submit">
                <i class="bi bi-box-arrow-in-right"></i> Sign In
            </button>
        </form>

        <div class="divider"><span>or</span></div>

        <div class="register-link">
            Don't have an account?
            <a href="${pageContext.request.contextPath}/register">Create one here</a>
        </div>
        <div class="register-link mt-2">
            <a href="${pageContext.request.contextPath}/register?type=admin">
                Register as Admin
            </a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>