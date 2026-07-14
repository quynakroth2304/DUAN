<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="${empty topping ? 'Thêm' : 'Sửa'} topping" scope="request" />
<c:set var="activeMenu" value="topping" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>${empty topping ? 'Thêm topping' : 'Sửa topping'}</h2>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/topping/${empty topping ? 'them' : 'sua'}" method="post" style="max-width:420px;">
    <c:if test="${not empty topping}">
        <input type="hidden" name="id" value="${topping.id}">
    </c:if>
    <div class="form-group">
        <label>Tên topping</label>
        <input type="text" name="name" value="${topping.name}" required>
    </div>
    <div class="form-group">
        <label>Giá (VND)</label>
        <input type="number" name="price" value="${topping.price}" required>
    </div>
    <button type="submit" class="btn">Lưu</button>
    <a href="${pageContext.request.contextPath}/admin/topping" class="btn btn-secondary">Hủy</a>
</form>

<jsp:include page="/common/admin-footer.jsp" />
