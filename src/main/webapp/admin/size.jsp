<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Size - Quản trị" scope="request" />
<c:set var="activeMenu" value="size" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<div class="toolbar">
    <h2>Danh sách Size</h2>
    <a href="${pageContext.request.contextPath}/admin/size/them" class="btn">+ Thêm size</a>
</div>

<table class="data-table">
    <tr><th>ID</th><th>Tên size</th><th>Giá cộng thêm</th><th>Hành động</th></tr>
    <c:forEach items="${listSize}" var="s">
        <tr>
            <td>${s.id}</td>
            <td>${s.name}</td>
            <td><fmt:formatNumber value="${s.price}" pattern="#,###" /> đ</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/size/sua?id=${s.id}">Sửa</a> |
                <a href="${pageContext.request.contextPath}/admin/size/xoa?id=${s.id}" onclick="return confirm('Xóa size này?');">Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/common/admin-footer.jsp" />
