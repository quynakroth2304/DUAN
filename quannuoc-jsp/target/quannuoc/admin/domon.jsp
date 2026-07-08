<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Đồ uống - Quản trị" scope="request" />
<c:set var="activeMenu" value="do-uong" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<div class="toolbar">
    <h2>🥤 Danh sách Đồ uống</h2>
    <a href="${pageContext.request.contextPath}/admin/do-uong/them" class="btn">+ Thêm đồ uống</a>
</div>

<table class="data-table">
    <tr><th>ID</th><th>Tên</th><th>Danh mục</th><th>Giá</th><th>Trạng thái</th><th>Hành động</th></tr>
    <c:forEach items="${listDrink}" var="d">
        <tr>
            <td>${d.id}</td>
            <td>${d.name}</td>
            <td>${d.category.name}</td>
            <td><fmt:formatNumber value="${d.price}" pattern="#,###" /> đ</td>
            <td>${d.active ? 'Đang bán' : 'Đã ẩn'}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/do-uong/sua?id=${d.id}">Sửa</a> |
                <a href="${pageContext.request.contextPath}/admin/do-uong/xoa?id=${d.id}" onclick="return confirm('Ẩn đồ uống này?');">Ẩn</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/common/admin-footer.jsp" />
