<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thực đơn - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <form class="search-form" action="${pageContext.request.contextPath}/trang-chu" method="get" style="margin-bottom:20px;">
        <input type="text" name="keyword" value="${keyword}" placeholder="Tìm đồ uống...">
        <button type="submit" class="btn">Tìm kiếm</button>
    </form>

    <div class="category-bar">
        <a href="${pageContext.request.contextPath}/trang-chu" class="${empty selectedCategoryId ? 'active' : ''}">Tất cả</a>
        <c:forEach items="${listCategory}" var="cate">
            <a href="${pageContext.request.contextPath}/trang-chu?categoryId=${cate.id}"
               class="${selectedCategoryId == cate.id ? 'active' : ''}">${cate.name}</a>
        </c:forEach>
    </div>

    <c:choose>
        <c:when test="${empty listDrink}">
            <div class="empty-state">Không tìm thấy đồ uống nào.</div>
        </c:when>
        <c:otherwise>
            <div class="drink-grid">
                <c:forEach items="${listDrink}" var="d">
                    <a class="drink-card" href="${pageContext.request.contextPath}/do-uong/chi-tiet?id=${d.id}">
                        <img src="${not empty d.image ? d.image : 'https://placehold.co/400x300?text=Do+uong'}" alt="${d.name}">
                        <div class="info">
                            <h3>${d.name}</h3>
                            <div class="price"><fmt:formatNumber value="${d.price}" pattern="#,###" /> đ</div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
