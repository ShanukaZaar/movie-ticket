<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CineBook</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #0a0a0a; color: #fff; min-height: 100vh; display: flex; align-items: center; }
        .register-card { background: #1a1a1a; border-radius: 20px; border: 1px solid #333; padding: 40px; }
        .form-control { background: #222; border: 1px solid #444; color: #fff; }
        .form-control:focus { background: #222; border-color: #e50914; color: #fff; box-shadow: 0 0 0 0.25rem rgba(229,9,20,0.25); }
        .btn-type { border: 2px solid #333; background: #111; color: #aaa; border-radius: 10px; padding: 15px; transition: all 0.3s; cursor: pointer; width: 100%; }
        .btn-type.active, .btn-type:hover { border-color: #e50914; color: #fff; background: #1a1a1a; }
        .btn-type i { font-size: 2rem; display: block; margin-bottom: 8px; }
        label { color: #ccc; }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="text-center mb-4">
                <a href="${pageContext.request.contextPath}/home" style="color:#e50914; font-size:1.8rem; font-weight:900; text-decoration:none;">CineBook</a>
            </div>
            <div class="register-card">
                <h3 class="text-center mb-4">Create Account</h3>

                <%-- Error message --%>
                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error") %>
                    </div>
                <% } %>

                <%-- Registration type selector --%>
                <p class="text-center" style="color:#aaa;">Register as:</p>
                <div class="row g-3 mb-4">
                    <div class="col-6">
                        <button class="btn-type ${registerType == 'admin' ? 'active' : ''}"
                                onclick="setType('admin')" type="button">
                            <i class="bi bi-shield-lock" style="color:#e50914;"></i>
                            Admin
                        </button>
                    </div>
                    <div class="col-6">
                        <button class="btn-type ${registerType != 'admin' ? 'active' : ''}"
                                onclick="setType('customer')" type="button">
                            <i class="bi bi-person" style="color:#e50914;"></i>
                            Customer
                        </button>
                    </div>
                </div>

                <form action="${pageContext.request.contextPath}/register" method="post">
                    <input type="hidden" name="registerType" id="registerType"
                           value="${not empty registerType ? registerType : 'customer'}">

                    <div class="mb-3">
                        <label>Full Name</label>
                        <input type="text" name="name" class="form-control"
                               placeholder="Enter your full name" required>
                    </div>
                    <div class="mb-3">
                        <label>Email Address</label>
                        <input type="email" name="email" class="form-control"
                               placeholder="Enter your email" required>
                    </div>
                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control"
                               placeholder="Create a password" required>
                    </div>
                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <input type="password" name="confirmPassword" class="form-control"
                               placeholder="Confirm your password" required>
                    </div>

                    <%-- Admin code field - only shown for admin --%>
                    <div class="mb-3" id="adminCodeField"
                         style="display:${registerType == 'admin' ? 'block' : 'none'}">
                        <label><i class="bi bi-shield-lock" style="color:#e50914;"></i> Admin Secret Code</label>
                        <input type="password" name="adminCode" class="form-control"
                               placeholder="Enter admin secret code">
                        <small style="color:#aaa;">Contact your system administrator for the code.</small>
                    </div>

                    <button type="submit" class="btn w-100 mt-2"
                            style="background:#e50914; color:#fff; border-radius:10px; padding:12px; font-weight:700;">
                        Create Account
                    </button>
                </form>

                <hr style="border-color:#333;">
                <p class="text-center" style="color:#aaa;">
                    Already have an account?
                    <a href="${pageContext.request.contextPath}/login" style="color:#e50914;">Login here</a>
                </p>
            </div>
        </div>
    </div>
</div>

<script>
    function setType(type) {
        document.getElementById('registerType').value = type;
        document.getElementById('adminCodeField').style.display = type === 'admin' ? 'block' : 'none';
        document.querySelectorAll('.btn-type').forEach(b => b.classList.remove('active'));
        event.target.closest('.btn-type').classList.add('active');
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>