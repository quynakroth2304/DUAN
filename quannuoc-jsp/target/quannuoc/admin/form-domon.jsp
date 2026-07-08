<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="${empty drink ? 'Thêm' : 'Sửa'} đồ uống" scope="request" />
<c:set var="activeMenu" value="do-uong" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>${empty drink ? 'Thêm đồ uống' : 'Sửa đồ uống'}</h2>

<c:if test="${not empty error}">
    <div class="alert alert-error">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/admin/do-uong/${empty drink ? 'them' : 'sua'}" method="post" style="max-width:520px;">
    <c:if test="${not empty drink}">
        <input type="hidden" name="id" value="${drink.id}">
    </c:if>

    <div class="form-group">
        <label>Tên đồ uống</label>
        <input type="text" name="name" value="${drink.name}" required>
    </div>

    <div class="form-group">
        <label>Danh mục</label>
        <select name="categoryId" required>
            <c:forEach items="${listCategory}" var="c">
                <option value="${c.id}" ${drink.category.id == c.id ? 'selected' : ''}>${c.name}</option>
            </c:forEach>
        </select>
    </div>

    <div class="form-group">
        <label>Mô tả</label>
        <textarea name="description" rows="3">${drink.description}</textarea>
    </div>

    <div class="form-group">
        <label>Đường dẫn hình ảnh</label>
        <input type="text" name="image" value="${drink.image}" placeholder="https://...">
    </div>

    <div class="form-group">
        <label>Giá (VND)</label>
        <input type="number" name="price" value="${drink.price}" required>
    </div>

    <div class="form-group">
        <label>Topping đi kèm</label>
        <div class="checkbox-list">
            <c:forEach items="${listTopping}" var="t">
                <label>
                    <input type="checkbox" name="toppingId" value="${t.id}"
                        ${fn:contains(selectedToppingIds, t.id) ? 'checked' : ''}>
                        ${t.name}
                </label>
            </c:forEach>
        </div>
    </div>

    <button type="submit" class="btn">Lưu</button>
    <a href="${pageContext.request.contextPath}/admin/do-uong" class="btn btn-secondary">Hủy</a>
</form>

<jsp:include page="/common/admin-footer.jsp" />
