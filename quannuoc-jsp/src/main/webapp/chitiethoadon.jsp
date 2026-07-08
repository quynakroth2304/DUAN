<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chi tiết đơn hàng - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <c:if test="${param.success == '1'}">
        <div class="alert alert-success">Đặt hàng thành công! Cảm ơn bạn đã ủng hộ quán.</div>
    </c:if>

    <h2>Đơn hàng ${bill.code}</h2>
    <p>Ngày đặt: <fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy HH:mm" /></p>
    <p>Trạng thái: <span class="status-badge status-${bill.status}">${bill.status}</span></p>

    <table class="data-table">
        <tr>
            <th>Đồ uống</th>
            <th>Size</th>
            <th>Topping</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
        <c:forEach items="${listDetail}" var="d">
            <tr>
                <td>${d.drink.name}</td>
                <td>${d.size.name}</td>
                <td>
                    <c:forEach items="${d.toppings}" var="t">${t.topping.name}<br></c:forEach>
                </td>
                <td>${d.quantity}</td>
                <td><fmt:formatNumber value="${d.price * d.quantity}" pattern="#,###" /> đ</td>
            </tr>
        </c:forEach>
    </table>

    <div style="text-align:right;margin:20px 0;">
        <p style="font-size:18px;">Tổng cộng: <b><fmt:formatNumber value="${bill.total}" pattern="#,###" /> đ</b></p>
    </div>

    <h3>Lịch sử trạng thái</h3>
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
</div>

<jsp:include page="/common/footer.jsp" />
