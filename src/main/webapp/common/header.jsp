<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="user" value="${sessionScope.currentUser}" />
<c:set var="cart" value="${sessionScope.cart}" />
<!DOCTYPE html>
<html lang="vi">
<head>
    <style>
        /* =========================================
           BỘ CSS GIAO DIỆN CHUẨN QUÁN NƯỚC (qn-)
           ========================================= */
        :root {
            --qn-primary: #ff4757;
            --qn-primary-hover: #ff6b81;
            --qn-dark: #2f3542;
            --qn-gray: #747d8c;
            --qn-bg: #f4f6f8;
            --qn-white: #ffffff;
            --qn-border: #e1e8ed;
            --qn-shadow: 0 8px 24px rgba(0,0,0,0.06);
            --qn-radius: 12px;
        }

        body { background-color: var(--qn-bg); font-family: 'Segoe UI', system-ui, sans-serif; color: var(--qn-dark); }

        /* Container chung */
        .qn-container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }

        /* Card (Khối trắng bo góc) */
        .qn-card { background: var(--qn-white); border-radius: var(--qn-radius); padding: 30px; box-shadow: var(--qn-shadow); }

        /* Nút bấm (Button) */
        .qn-btn { display: inline-flex; align-items: center; justify-content: center; padding: 12px 24px; background: var(--qn-primary); color: white !important; border: none; border-radius: 8px; font-weight: 600; font-size: 15px; cursor: pointer; text-decoration: none; transition: all 0.3s ease; }
        .qn-btn:hover { background: var(--qn-primary-hover); transform: translateY(-2px); box-shadow: 0 4px 12px rgba(255, 71, 87, 0.3); }
        .qn-btn-secondary { background: #ced6e0; color: var(--qn-dark) !important; }
        .qn-btn-secondary:hover { background: #dfe4ea; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .qn-btn-danger { background: transparent; color: var(--qn-primary) !important; padding: 6px 12px; border: 1px solid var(--qn-primary); }
        .qn-btn-danger:hover { background: var(--qn-primary); color: white !important; }

        /* Form nhập liệu (Input / Select) */
        .qn-form-group { margin-bottom: 20px; }
        .qn-form-group label { display: block; font-weight: 600; margin-bottom: 8px; font-size: 14px; color: var(--qn-dark); }
        .qn-input, .qn-select { width: 100%; padding: 12px 16px; border: 1px solid var(--qn-border); border-radius: 8px; font-size: 15px; background: #fdfdfd; transition: all 0.3s; box-sizing: border-box; }
        .qn-input:focus, .qn-select:focus { border-color: var(--qn-primary); outline: none; box-shadow: 0 0 0 3px rgba(255, 71, 87, 0.1); background: white; }

        /* Bảng dữ liệu (Table) */
        .qn-table-wrapper { background: white; border-radius: var(--qn-radius); box-shadow: var(--qn-shadow); overflow: hidden; margin-top: 20px; }
        .qn-table { width: 100%; border-collapse: collapse; text-align: left; }
        .qn-table th { background: #f8f9fa; color: var(--qn-gray); font-size: 13px; text-transform: uppercase; padding: 16px; border-bottom: 2px solid var(--qn-border); }
        .qn-table td { padding: 16px; border-bottom: 1px solid var(--qn-border); vertical-align: middle; }
        .qn-table tr:hover td { background: #fcfcfc; }
        .qn-table tr:last-child td { border-bottom: none; }

        /* Trạng thái (Badge & Alerts) */
        .qn-badge { padding: 6px 12px; border-radius: 50px; font-size: 13px; font-weight: bold; }
        .qn-badge-pending { background: #fff3cd; color: #856404; }
        .qn-badge-success { background: #d4edda; color: #155724; }
        .qn-badge-danger { background: #f8d7da; color: #721c24; }

        .qn-alert { padding: 16px; border-radius: 8px; margin-bottom: 20px; font-weight: 500; }
        .qn-alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .qn-alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }

        /* Tiêu đề & Empty State */
        .qn-title { font-size: 24px; font-weight: bold; margin-bottom: 20px; color: var(--qn-dark); }
        .qn-empty-state { text-align: center; padding: 60px 20px; color: var(--qn-gray); background: white; border-radius: var(--qn-radius); border: 2px dashed var(--qn-border); font-size: 16px; margin-top: 20px; }
    </style>
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
        <a href="${ctx}/gio-hang">Giỏ hàng<c:if test="${not empty cart and cart.itemCount > 0}"> (${cart.itemCount})</c:if></a>
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
