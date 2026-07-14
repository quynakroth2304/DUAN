<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đơn hàng của tôi - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="qn-container">
    <h2 class="qn-title">Lịch sử đơn hàng</h2>

    <c:choose>
        <c:when test="${empty listBill}">
            <div class="qn-empty-state">Bạn chưa có đơn hàng nào trong lịch sử.</div>
        </c:when>
        <c:otherwise>
            <div class="qn-table-wrapper">
                <table class="qn-table">
                    <tr>
                        <th>Mã đơn</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th style="text-align:center;">Thao tác</th>
                    </tr>
                    <c:forEach items="${listBill}" var="b">
                        <tr>
                            <td style="font-family:monospace; font-weight:bold; font-size:15px;">#${b.code}</td>
                            <td><fmt:formatDate value="${b.createdAt}" pattern="dd/MM/yyyy HH:mm" /></td>
                            <td style="font-weight:bold; color:var(--qn-primary);"><fmt:formatNumber value="${b.total}" pattern="#,###" /> đ</td>
                            <td>
                                <span class="qn-badge qn-badge-pending">${b.status}</span>
                            </td>
                            <td style="text-align:center;">
                                <a href="${pageContext.request.contextPath}/don-hang/chi-tiet?id=${b.id}" class="qn-btn" style="padding:6px 12px; font-size:13px;">Xem chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />