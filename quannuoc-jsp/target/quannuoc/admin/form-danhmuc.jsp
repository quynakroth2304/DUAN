<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty category ? 'Thêm' : 'Sửa'} danh mục" scope="request" />
<c:set var="activeMenu" value="danh-muc" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>${empty category ? 'Thêm danh mục' : 'Sửa danh mục'}</h2>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/danh-muc/${empty category ? 'them' : 'sua'}" method="post" style="max-width:420px;">
    <c:if test="${not empty category}">
        <input type="hidden" name="id" value="${category.id}">
    </c:if>
    <div class="form-group">
        <label>Tên danh mục</label>
        <input type="text" name="name" value="${category.name}" required>
    </div>
    <button type="submit" class="btn">Lưu</button>
    <a href="${pageContext.request.contextPath}/admin/danh-muc" class="btn btn-secondary">Hủy</a>
</form>

<jsp:include page="/common/admin-footer.jsp" />
