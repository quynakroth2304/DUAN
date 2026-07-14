<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Giỏ hàng - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="qn-container">
    <h2 class="qn-title">Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="qn-empty-state">
                <img src="https://cdn-icons-png.flaticon.com/512/11329/11329060.png" alt="Empty Cart" style="width:100px; opacity:0.5; margin-bottom:15px;">
                <h3 style="margin:0 0 10px 0; color:var(--qn-dark);">Giỏ hàng đang trống</h3>
                <p>Bạn chưa chọn đồ uống nào. Hãy khám phá thực đơn nhé!</p>
                <a href="${pageContext.request.contextPath}/trang-chu" class="qn-btn" style="margin-top:15px;">🍵 Xem thực đơn</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="qn-table-wrapper">
                <table class="qn-table">
                    <tr>
                        <th>Đồ uống</th>
                        <th>Size</th>
                        <th>Topping</th>
                        <th>Đơn giá</th>
                        <th style="text-align:center;">Số lượng</th>
                        <th>Thành tiền</th>
                        <th style="text-align:center;">Thao tác</th>
                    </tr>
                    <c:forEach items="${cart.items}" var="item">
                        <tr>
                            <td style="font-weight:600; color:var(--qn-dark);">${item.drinkName}</td>
                            <td><span class="qn-badge qn-badge-pending">${item.sizeName}</span></td>
                            <td style="font-size:14px; color:var(--qn-gray);">
                                <c:forEach items="${item.toppingNames}" var="t">- ${t.value}<br></c:forEach>
                            </td>
                            <td style="font-weight:600;"><fmt:formatNumber value="${item.unitPrice}" pattern="#,###" /> đ</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/gio-hang/cap-nhat" method="post" style="display:flex; gap:8px; justify-content:center;">
                                    <input type="hidden" name="key" value="${item.key}">
                                    <input type="number" class="qn-input" name="quantity" value="${item.quantity}" min="1" style="width:70px; padding:8px; text-align:center;">
                                    <button type="submit" class="qn-btn qn-btn-secondary" style="padding:8px 12px;"><i class="fas fa-sync-alt"></i> Lưu</button>
                                </form>
                            </td>
                            <td style="color:var(--qn-primary); font-weight:bold; font-size:16px;"><fmt:formatNumber value="${item.lineTotal}" pattern="#,###" /> đ</td>
                            <td style="text-align:center;">
                                <a href="${pageContext.request.contextPath}/gio-hang/xoa?key=${item.key}" class="qn-btn qn-btn-danger">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="qn-card" style="margin-top:30px; display:flex; justify-content:space-between; align-items:center;">
                <div style="font-size:20px;">Tổng thanh toán: <b style="color:var(--qn-primary); font-size:28px; margin-left:10px;"><fmt:formatNumber value="${cart.total}" pattern="#,###" /> đ</b></div>
                <a href="${pageContext.request.contextPath}/thanh-toan" class="qn-btn" style="font-size:18px; padding:15px 30px;">🚀 Tiến hành đặt hàng</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />