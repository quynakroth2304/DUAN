<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${sessionScope.currentUser}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'Quản trị - Quán Nước'}" /></title>
    <link rel="stylesheet" href="${ctx}/css/style.css">
</head>
<body>
<header class="site-header">
    <a class="logo" href="${ctx}/admin/don-hang">QUÁN <span>NƯỚC</span> · Quản trị</a>
    <nav class="main-nav">
        <a href="${ctx}/trang-chu">Xem trang bán hàng</a>
        <a href="${ctx}/dang-xuat">Đăng xuất (${user.fullName})</a>
    </nav>
</header>
<div class="admin-layout">
    <aside class="admin-sidebar">
        <a href="${ctx}/admin/don-hang" class="${activeMenu == 'don-hang' ? 'active' : ''}">Đơn hàng</a>
        <a href="${ctx}/admin/do-uong" class="${activeMenu == 'do-uong' ? 'active' : ''}">Đồ uống</a>
        <a href="${ctx}/admin/danh-muc" class="${activeMenu == 'danh-muc' ? 'active' : ''}">Danh mục</a>
        <a href="${ctx}/admin/size" class="${activeMenu == 'size' ? 'active' : ''}">Size</a>
        <a href="${ctx}/admin/topping" class="${activeMenu == 'topping' ? 'active' : ''}">Topping</a>
        <a href="${ctx}/admin/nguoi-dung" class="${activeMenu == 'nguoi-dung' ? 'active' : ''}">Người dùng</a>
    </aside>
    <main class="admin-content">
