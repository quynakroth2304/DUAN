<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Giỏ hàng - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <h2>🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${empty cart.items}">
            <div class="empty-state">
                <h2 style="margin-bottom:8px;">Giỏ hàng đang trống</h2>
                Hãy chọn vài món yêu thích để bắt đầu.<br>
                <a href="${pageContext.request.contextPath}/trang-chu" class="btn" style="margin-top:18px;">Xem thực đơn</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="data-table">
                <tr>
                    <th>Đồ uống</th>
                    <th>Size</th>
                    <th>Topping</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th></th>
                </tr>
                <c:forEach items="${cart.items}" var="item">
                    <tr>
                        <td>${item.drinkName}</td>
                        <td>${item.sizeName}</td>
                        <td>
                            <c:forEach items="${item.toppingNames}" var="t">${t.value}<br></c:forEach>
                        </td>
                        <td><fmt:formatNumber value="${item.unitPrice}" pattern="#,###" /> đ</td>
                        <td>
                            <form action="${pageContext.request.contextPath}/gio-hang/cap-nhat" method="post" style="display:flex;gap:6px;">
                                <input type="hidden" name="key" value="${item.key}">
                                <input type="number" name="quantity" value="${item.quantity}" min="0" style="width:60px;">
                                <button type="submit" class="btn btn-secondary">Cập nhật</button>
                            </form>
                        </td>
                        <td><fmt:formatNumber value="${item.lineTotal}" pattern="#,###" /> đ</td>
                        <td><a href="${pageContext.request.contextPath}/gio-hang/xoa?key=${item.key}">Xóa</a></td>
                    </tr>
                </c:forEach>
            </table>

            <div style="text-align:right;margin-top:20px;">
                <p style="font-size:18px;">Tổng cộng: <b><fmt:formatNumber value="${cart.total}" pattern="#,###" /> đ</b></p>
                <a href="${pageContext.request.contextPath}/thanh-toan" class="btn">Tiến hành thanh toán</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
