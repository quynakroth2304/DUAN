<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Danh mục - Quản trị" scope="request" />
<c:set var="activeMenu" value="danh-muc" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<div class="toolbar">
    <h2>Danh mục</h2>
    <a href="${pageContext.request.contextPath}/admin/danh-muc/them" class="btn">+ Thêm danh mục</a>
</div>

<table class="data-table">
    <tr><th>ID</th><th>Tên danh mục</th><th>Trạng thái</th><th>Hành động</th></tr>
    <c:forEach items="${listCategory}" var="c">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>${c.active ? 'Đang bán' : 'Đã ẩn'}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/danh-muc/sua?id=${c.id}">Sửa</a> |
                <a href="${pageContext.request.contextPath}/admin/danh-muc/xoa?id=${c.id}" onclick="return confirm('Ẩn danh mục này?');">Ẩn</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/common/admin-footer.jsp" />
