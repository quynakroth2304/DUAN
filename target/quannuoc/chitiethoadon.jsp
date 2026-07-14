<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Chi tiết đơn hàng - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="qn-container">
    <c:if test="${param.success == '1'}">
        <div class="qn-alert qn-alert-success">
            <b>🎉 Đặt hàng thành công!</b> Đơn hàng của bạn đã được ghi nhận. Cảm ơn bạn đã ủng hộ quán.
        </div>
    </c:if>

    <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2 class="qn-title" style="margin:0;">Đơn hàng #${bill.code}</h2>
        <span class="qn-badge qn-badge-success" style="font-size:15px; padding:8px 16px;">Trạng thái: ${bill.status}</span>
    </div>

    <div class="qn-card" style="margin-bottom:30px; padding:20px;">
        <p style="margin:0; color:var(--qn-gray);">Ngày đặt: <b style="color:var(--qn-dark);"><fmt:formatDate value="${bill.createdAt}" pattern="dd/MM/yyyy - HH:mm" /></b></p>
    </div>

    <div class="qn-table-wrapper">
        <table class="qn-table">
            <tr>
                <th>Đồ uống</th>
                <th>Size</th>
                <th>Topping</th>
                <th style="text-align:center;">Số lượng</th>
                <th style="text-align:right;">Thành tiền</th>
            </tr>
            <c:forEach items="${listDetail}" var="d">
                <tr>
                    <td style="font-weight:bold;">${d.drink.name}</td>
                    <td>${d.size.name}</td>
                    <td style="font-size:13px; color:var(--qn-gray);">
                        <c:forEach items="${d.toppings}" var="t">- ${t.topping.name}<br></c:forEach>
                    </td>
                    <td style="text-align:center; font-weight:bold;">${d.quantity}</td>
                    <td style="text-align:right; font-weight:bold; color:var(--qn-primary);"><fmt:formatNumber value="${d.price * d.quantity}" pattern="#,###" /> đ</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="qn-card" style="margin-top:20px; text-align:right;">
        <p style="font-size:20px; margin:0;">Tổng cộng: <b style="color:var(--qn-primary); font-size:28px;"><fmt:formatNumber value="${bill.total}" pattern="#,###" /> đ</b></p>
    </div>

    <h3 style="margin-top:40px; color:var(--qn-dark);">Lịch sử cập nhật đơn</h3>
    <div class="qn-table-wrapper">
        <table class="qn-table">
            <tr><th>Trạng thái</th><th>Thời gian cập nhật</th><th>Cập nhật bởi</th></tr>
            <c:forEach items="${listHistory}" var="h">
                <tr>
                    <td><span class="qn-badge qn-badge-pending">${h.status}</span></td>
                    <td><fmt:formatDate value="${h.updatedAt}" pattern="dd/MM/yyyy HH:mm:ss" /></td>
                    <td style="font-weight:600;">${not empty h.updatedBy ? h.updatedBy.fullName : 'Hệ thống'}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />