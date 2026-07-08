<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng - Quản trị" scope="request" />
<c:set var="activeMenu" value="don-hang" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>Quản lý đơn hàng</h2>

<div class="category-bar">
    <a href="${pageContext.request.contextPath}/admin/don-hang" class="${empty selectedStatus ? 'active' : ''}">Tất cả</a>
    <a href="${pageContext.request.contextPath}/admin/don-hang?status=waiting" class="${selectedStatus == 'waiting' ? 'active' : ''}">Chờ xác nhận</a>
    <a href="${pageContext.request.contextPath}/admin/don-hang?status=confirmed" class="${selectedStatus == 'confirmed' ? 'active' : ''}">Đã xác nhận</a>
    <a href="${pageContext.request.contextPath}/admin/don-hang?status=preparing" class="${selectedStatus == 'preparing' ? 'active' : ''}">Đang pha chế</a>
    <a href="${pageContext.request.contextPath}/admin/don-hang?status=delivering" class="${selectedStatus == 'delivering' ? 'active' : ''}">Đang giao</a>
    <a href="${pageContext.request.contextPath}/admin/don-hang?status=completed" class="${selectedStatus == 'completed' ? 'active' : ''}">Hoàn thành</a>
    <a href="${pageContext.request.contextPath}/admin/don-hang?status=cancelled" class="${selectedStatus == 'cancelled' ? 'active' : ''}">Đã hủy</a>
</div>

<table class="data-table">
    <tr><th>Mã đơn</th><th>Khách hàng</th><th>Ngày đặt</th><th>Tổng tiền</th><th>Trạng thái</th><th></th></tr>
    <c:forEach items="${listBill}" var="b">
        <tr>
            <td>${b.code}</td>
            <td>${b.user.fullName}</td>
            <td><fmt:formatDate value="${b.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
            <td><fmt:formatNumber value="${b.total}" pattern="#,###" /> đ</td>
            <td><span class="status-badge status-${b.status}">${b.status}</span></td>
            <td><a href="${pageContext.request.contextPath}/admin/don-hang/chi-tiet?id=${b.id}">Xem / Cập nhật</a></td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/common/admin-footer.jsp" />
