<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng ký - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <div class="card-box">
        <h2>Tạo tài khoản mới</h2>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/dang-ky" method="post">
            <div class="form-group">
                <label>Họ và tên</label>
                <input type="text" name="fullName" value="${fullName}" required>
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" value="${email}" required>
            </div>
            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="text" name="phone" value="${phone}">
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" required>
            </div>
            <div class="form-group">
                <label>Nhập lại mật khẩu</label>
                <input type="password" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn">Đăng ký</button>
        </form>

        <p style="margin-top:16px;font-size:14px;">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a>
        </p>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
