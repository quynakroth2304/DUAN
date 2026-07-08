<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thanh toán - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <h2>Xác nhận đơn hàng</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <table class="data-table">
        <tr>
            <th>Đồ uống</th>
            <th>Size</th>
            <th>Số lượng</th>
            <th>Thành tiền</th>
        </tr>
        <c:forEach items="${cart.items}" var="item">
            <tr>
                <td>${item.drinkName}</td>
                <td>${item.sizeName}</td>
                <td>${item.quantity}</td>
                <td><fmt:formatNumber value="${item.lineTotal}" pattern="#,###" /> đ</td>
            </tr>
        </c:forEach>
    </table>

    <div style="text-align:right;margin:20px 0;">
        <p style="font-size:18px;">Tổng thanh toán: <b><fmt:formatNumber value="${cart.total}" pattern="#,###" /> đ</b></p>
    </div>

    <form action="${pageContext.request.contextPath}/thanh-toan" method="post" style="text-align:right;">
        <a href="${pageContext.request.contextPath}/gio-hang" class="btn btn-secondary">Quay lại giỏ hàng</a>
        <button type="submit" class="btn">Đặt hàng</button>
    </form>
</div>

<jsp:include page="/common/footer.jsp" />
