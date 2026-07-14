<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chi tiết đơn hàng - Quản trị" scope="request" />
<c:set var="activeMenu" value="don-hang" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>Đơn hàng ${bill.code}</h2>
<p>Khách hàng: ${bill.user.fullName} (${bill.user.email})</p>
<p>Ngày đặt: <fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm" /></p>
<p>Trạng thái hiện tại: <span class="status-badge status-${bill.status}">${bill.status}</span></p>

<table class="data-table">
    <tr><th>Đồ uống</th><th>Size</th><th>Topping</th><th>Số lượng</th><th>Thành tiền</th></tr>
    <c:forEach items="${listDetail}" var="d">
        <tr>
            <td>${d.drink.name}</td>
            <td>${d.size.name}</td>
            <td><c:forEach items="${d.toppings}" var="t">${t.topping.name}<br></c:forEach></td>
            <td>${d.quantity}</td>
            <td><fmt:formatNumber value="${d.price * d.quantity}" pattern="#,###" /> đ</td>
        </tr>
    </c:forEach>
</table>

<div style="text-align:right;margin:16px 0;">
    <p style="font-size:18px;">Tổng cộng: <b><fmt:formatNumber value="${bill.total}" pattern="#,###" /> đ</b></p>
</div>

<h3>Cập nhật trạng thái</h3>
<form action="${pageContext.request.contextPath}/admin/don-hang/cap-nhat-trang-thai" method="post" style="max-width:360px;">
    <input type="hidden" name="id" value="${bill.id}">
    <div class="form-group">
        <select name="status">
            <option value="waiting" ${bill.status == 'waiting' ? 'selected' : ''}>Chờ xác nhận</option>
            <option value="confirmed" ${bill.status == 'confirmed' ? 'selected' : ''}>Đã xác nhận</option>
            <option value="preparing" ${bill.status == 'preparing' ? 'selected' : ''}>Đang pha chế</option>
            <option value="delivering" ${bill.status == 'delivering' ? 'selected' : ''}>Đang giao</option>
            <option value="completed" ${bill.status == 'completed' ? 'selected' : ''}>Hoàn thành</option>
            <option value="cancelled" ${bill.status == 'cancelled' ? 'selected' : ''}>Đã hủy</option>
        </select>
    </div>
    <button type="submit" class="btn">Cập nhật trạng thái</button>
</form>

<h3 style="margin-top:30px;">Lịch sử trạng thái</h3>
<table class="data-table">
    <tr><th>Trạng thái</th><th>Cập nhật lúc</th><th>Bởi</th></tr>
    <c:forEach items="${listHistory}" var="h">
        <tr>
            <td><span class="status-badge status-${h.status}">${h.status}</span></td>
            <td><fmt:formatDate value="${h.updatedAt}" pattern="dd/MM/yyyy HH:mm" /></td>
            <td>${not empty h.updatedBy ? h.updatedBy.fullName : 'Hệ thống'}</td>
        </tr>
    </c:forEach>
</table>

<a href="${pageContext.request.contextPath}/admin/don-hang" class="btn btn-secondary" style="margin-top:16px;">Quay lại danh sách</a>

<jsp:include page="/common/admin-footer.jsp" />
