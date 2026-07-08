<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng của tôi - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <h2>🧾 Đơn hàng của tôi</h2>

    <c:choose>
        <c:when test="${empty listBill}">
            <div class="empty-state">
                <h2 style="margin-bottom:8px;">Chưa có đơn hàng nào</h2>
                Đặt món đầu tiên của bạn ngay hôm nay.<br>
                <a href="${pageContext.request.contextPath}/trang-chu" class="btn" style="margin-top:18px;">Xem thực đơn</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="data-table">
                <tr>
                    <th>Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th></th>
                </tr>
                <c:forEach items="${listBill}" var="b">
                    <tr>
                        <td>${b.code}</td>
                        <td><fmt:formatDate value="${b.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
                        <td><fmt:formatNumber value="${b.total}" pattern="#,###" /> đ</td>
                        <td><span class="status-badge status-${b.status}">${b.status}</span></td>
                        <td><a href="${pageContext.request.contextPath}/don-hang/chi-tiet?id=${b.id}">Xem chi tiết</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
