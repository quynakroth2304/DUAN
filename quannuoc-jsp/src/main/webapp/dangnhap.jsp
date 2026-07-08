<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Đăng nhập - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
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
                <label>Email</label>
                <input type="email" name="email" value="${email}" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="btn">Đăng nhập</button>
        </form>

        <p style="margin-top:16px;font-size:14px;">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/dang-ky">Đăng ký ngay</a>
        </p>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
