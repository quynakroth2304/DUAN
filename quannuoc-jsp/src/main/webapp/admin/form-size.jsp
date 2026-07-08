<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty size ? 'Thêm' : 'Sửa'} size" scope="request" />
<c:set var="activeMenu" value="size" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>${empty size ? 'Thêm size' : 'Sửa size'}</h2>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/size/${empty size ? 'them' : 'sua'}" method="post" style="max-width:420px;">
    <c:if test="${not empty size}">
        <input type="hidden" name="id" value="${size.id}">
    </c:if>
    <div class="form-group">
        <label>Tên size</label>
        <input type="text" name="name" value="${size.name}" required>
    </div>
    <div class="form-group">
        <label>Giá cộng thêm (VND)</label>
        <input type="number" name="price" value="${size.price}" required>
    </div>
    <button type="submit" class="btn">Lưu</button>
    <a href="${pageContext.request.contextPath}/admin/size" class="btn btn-secondary">Hủy</a>
</form>

<jsp:include page="/common/admin-footer.jsp" />
