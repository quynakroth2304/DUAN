<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${sessionScope.currentUser}" />
<c:set var="cart" value="${sessionScope.cart}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Quán Nước'}" /></title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<header class="site-header">
    <a class="logo" href="${ctx}/trang-chu">QUÁN <span>NƯỚC</span></a>
    <nav class="main-nav">
        <a href="${ctx}/trang-chu">Thực đơn</a>
        <c:if test="${not empty user}">
            <a href="${ctx}/don-hang">Đơn hàng của tôi</a>
        </c:if>
        <c:if test="${not empty user and user.role}">
            <a href="${ctx}/admin/don-hang">Trang quản trị</a>
        </c:if>
        <a href="${ctx}/gio-hang">🛒 Giỏ hàng<c:if test="${not empty cart and cart.itemCount > 0}"> (${cart.itemCount})</c:if></a>
        <c:choose>
            <c:when test="${not empty user}">
                <a href="${ctx}/dang-xuat">Đăng xuất (${user.fullName})</a>
            </c:when>
            <c:otherwise>
                <a href="${ctx}/dang-nhap">Đăng nhập</a>
            </c:otherwise>
        </c:choose>
    </nav>
</header>
