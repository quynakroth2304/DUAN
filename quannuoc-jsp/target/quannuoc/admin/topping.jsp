<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Topping - Quản trị" scope="request" />
<c:set var="activeMenu" value="topping" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<div class="toolbar">
    <h2>Danh sách Topping</h2>
    <a href="${pageContext.request.contextPath}/admin/topping/them" class="btn">+ Thêm topping</a>
</div>

<table class="data-table">
    <tr><th>ID</th><th>Tên topping</th><th>Giá</th><th>Hành động</th></tr>
    <c:forEach items="${listTopping}" var="t">
        <tr>
            <td>${t.id}</td>
            <td>${t.name}</td>
            <td><fmt:formatNumber value="${t.price}" pattern="#,###" /> đ</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/topping/sua?id=${t.id}">Sửa</a> |
                <a href="${pageContext.request.contextPath}/admin/topping/xoa?id=${t.id}" onclick="return confirm('Xóa topping này?');">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/common/admin-footer.jsp" />
