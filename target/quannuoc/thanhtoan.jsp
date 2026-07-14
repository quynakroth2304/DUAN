<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thanh toán - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="qn-container">
    <h2 class="qn-title">Xác nhận đơn hàng</h2>

    <c:if test="${not empty error}"><div class="qn-alert qn-alert-error">${error}</div></c:if>

    <div class="qn-table-wrapper">
        <table class="qn-table">
            <tr>
                <th>Đồ uống</th>
                <th>Size</th>
                <th style="text-align:center;">Số lượng</th>
                <th style="text-align:right;">Thành tiền</th>
            </tr>
            <c:forEach items="${cart.items}" var="item">
                <tr>
                    <td style="font-weight:600;">${item.drinkName}</td>
                    <td>${item.sizeName}</td>
                    <td style="text-align:center; font-weight:bold;">x${item.quantity}</td>
                    <td style="text-align:right; color:var(--qn-primary); font-weight:bold;"><fmt:formatNumber value="${item.lineTotal}" pattern="#,###" /> đ</td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <div class="qn-card" style="margin-top:20px; text-align:right;">
        <p style="font-size:20px; margin-bottom:20px;">Tổng thanh toán: <b style="color:var(--qn-primary); font-size:26px;"><fmt:formatNumber value="${cart.total}" pattern="#,###" /> đ</b></p>

        <form action="${pageContext.request.contextPath}/thanh-toan" method="post" style="display:flex; gap:15px; justify-content:flex-end;">
            <a href="${pageContext.request.contextPath}/gio-hang" class="qn-btn qn-btn-secondary">Quay lại giỏ hàng</a>
            <button type="submit" class="qn-btn">Xác nhận Đặt hàng</button>
        </form>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />