<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng nhập - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<style>
    /* CSS làm đẹp giao diện đăng nhập */
    .login-wrapper {
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 60vh; /* Chiều cao tối thiểu để căn giữa màn hình */
        padding: 40px 20px;
        background-color: #f8f9fa; /* Màu nền nhẹ nhàng */
    }

    .card-box {
        background: #ffffff;
        padding: 40px;
        border-radius: 12px;
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08); /* Đổ bóng tạo chiều sâu */
        width: 100%;
        max-width: 420px;
    }

    .card-box h2 {
        margin-top: 0;
        margin-bottom: 24px;
        color: #333333;
        text-align: center;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        font-weight: 600;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        margin-bottom: 8px;
        color: #555555;
        font-weight: 500;
        font-size: 14px;
    }

    .form-group input {
        width: 100%;
        padding: 12px 16px;
        border: 1px solid #cccccc;
        border-radius: 8px;
        font-size: 15px;
        transition: all 0.3s ease;
        box-sizing: border-box; /* Đảm bảo padding không làm tràn width */
    }

    .form-group input:focus {
        border-color: #4CAF50; /* Màu chủ đạo (Xanh lá) */
        outline: none;
        box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.15);
    }

    .btn {
        width: 100%;
        padding: 14px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.1s ease;
        margin-top: 10px;
    }

    .btn:hover {
        background-color: #43a047;
    }

    .btn:active {
        transform: scale(0.98);
    }

    .alert {
        padding: 12px 16px;
        border-radius: 8px;
        margin-bottom: 20px;
        font-size: 14px;
        text-align: center;
    }

    .alert-error {
        background-color: #ffebee;
        color: #c62828;
        border: 1px solid #ffcdd2;
    }

    .alert-success {
        background-color: #e8f5e9;
        color: #2e7d32;
        border: 1px solid #c8e6c9;
    }

    .auth-links {
        margin-top: 24px;
        text-align: center;
        font-size: 14px;
        color: #666666;
    }

    .auth-links a {
        color: #4CAF50;
        text-decoration: none;
        font-weight: 600;
        transition: color 0.2s;
    }

    .auth-links a:hover {
        color: #388e3c;
        text-decoration: underline;
    }
</style>

<div class="login-wrapper">
    <div class="card-box">
        <h2>Đăng nhập</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/dang-nhap" method="post">
            <input type="hidden" name="redirect" value="${param.redirect}" />

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${email}" placeholder="VD: user@quannuoc.com" required>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu</label>
                <input type="password" id="password" name="password" placeholder="Nhập mật khẩu của bạn" required>
            </div>

            <button type="submit" class="btn">Đăng nhập</button>
        </form>

        <p class="auth-links">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/dang-ky">Đăng ký ngay</a>
        </p>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />