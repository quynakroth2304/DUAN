<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng ký - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<style>
    /* BỘ CSS ĐỘC LẬP HOÀN TOÀN CHO TRANG ĐĂNG KÝ */
    .register-standalone-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 80vh;
        padding: 40px 20px;
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    }

    .register-standalone-card {
        background: #ffffff;
        width: 100%;
        max-width: 520px;
        border-radius: 16px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        padding: 40px;
        box-sizing: border-box;
    }

    .register-standalone-title {
        text-align: center;
        color: #1f2937;
        font-size: 28px;
        font-weight: 700;
        margin-top: 0;
        margin-bottom: 30px;
    }

    .register-standalone-alert {
        background-color: #fee2e2;
        border: 1px solid #f87171;
        color: #b91c1c;
        padding: 14px 16px;
        border-radius: 8px;
        margin-bottom: 24px;
        font-size: 14px;
        text-align: center;
        font-weight: 500;
    }

    .register-standalone-group {
        margin-bottom: 20px;
    }

    .register-standalone-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        color: #4b5563;
        margin-bottom: 8px;
    }

    .register-standalone-input {
        width: 100%;
        padding: 14px 16px;
        font-size: 15px;
        border: 1.5px solid #e5e7eb;
        border-radius: 8px;
        box-sizing: border-box;
        transition: all 0.3s ease;
        background-color: #f9fafb;
    }

    .register-standalone-input:focus {
        outline: none;
        border-color: #3b82f6;
        box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
        background-color: #ffffff;
    }

    .register-standalone-row {
        display: flex;
        gap: 16px;
    }

    .register-standalone-row .register-standalone-group {
        flex: 1;
        margin-bottom: 20px;
    }

    .register-standalone-btn {
        width: 100%;
        background-color: #3b82f6;
        color: #ffffff;
        font-size: 16px;
        font-weight: bold;
        padding: 16px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.1s;
        margin-top: 10px;
        box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    }

    .register-standalone-btn:hover {
        background-color: #2563eb;
        box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
    }

    .register-standalone-btn:active {
        transform: translateY(2px);
    }

    .register-standalone-footer {
        text-align: center;
        margin-top: 25px;
        font-size: 15px;
        color: #6b7280;
    }

    .register-standalone-footer a {
        color: #3b82f6;
        font-weight: 600;
        text-decoration: none;
        transition: color 0.2s;
    }

    .register-standalone-footer a:hover {
        color: #1e40af;
        text-decoration: underline;
    }

    /* Tự động xếp chồng cột mật khẩu khi dùng điện thoại */
    @media (max-width: 480px) {
        .register-standalone-row {
            flex-direction: column;
            gap: 0;
        }
        .register-standalone-card {
            padding: 30px 20px;
        }
    }
</style>

<div class="register-standalone-wrapper">
    <div class="register-standalone-card">
        <h2 class="register-standalone-title">Tạo tài khoản mới</h2>

        <c:if test="${not empty error}">
            <div class="register-standalone-alert">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/dang-ky" method="post">
            <div class="register-standalone-group">
                <label>Họ và tên</label>
                <input type="text" class="register-standalone-input" name="fullName" value="${fullName}" placeholder="Nhập họ và tên của bạn" required>
            </div>

            <div class="register-standalone-group">
                <label>Email</label>
                <input type="email" class="register-standalone-input" name="email" value="${email}" placeholder="VD: user@quannuoc.com" required>
            </div>

            <div class="register-standalone-group">
                <label>Số điện thoại</label>
                <input type="text" class="register-standalone-input" name="phone" value="${phone}" placeholder="Nhập số điện thoại">
            </div>

            <div class="register-standalone-row">
                <div class="register-standalone-group">
                    <label>Mật khẩu</label>
                    <input type="password" class="register-standalone-input" name="password" placeholder="Tạo mật khẩu" required>
                </div>
                <div class="register-standalone-group">
                    <label>Xác nhận mật khẩu</label>
                    <input type="password" class="register-standalone-input" name="confirmPassword" placeholder="Nhập lại mật khẩu" required>
                </div>
            </div>

            <button type="submit" class="register-standalone-btn">Đăng ký tài khoản</button>
        </form>

        <div class="register-standalone-footer">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập tại đây</a>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />