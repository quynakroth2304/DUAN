<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thực đơn - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<section class="hero">
    <div class="hero-content">
        <span class="hero-eyebrow">Quán Nước &middot; Tươi mới mỗi ngày</span>
        <h1>Thức uống ngon, pha chế từ tâm</h1>
        <p>Chọn món yêu thích, tuỳ chỉnh size &amp; topping, giao tận nơi trong vài phút.</p>
    </div>
</section>

<div class="container">
    <form class="search-form" action="${pageContext.request.contextPath}/trang-chu" method="get" style="margin-bottom:24px;max-width:420px;">
        <input type="text" name="keyword" value="${keyword}" placeholder="🔍 Tìm đồ uống...">
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
                <c:forEach items="${listDrink}" var="d" varStatus="st">
                    <a class="drink-card" style="animation-delay:${st.index * 0.04}s" href="${pageContext.request.contextPath}/do-uong/chi-tiet?id=${d.id}">
                        <div class="thumb">
                            <img src="${not empty d.image ? d.image : 'https://placehold.co/400x300?text=Do+uong'}" alt="${d.name}">
                        </div>
                        <div class="info">
                            <h3>${d.name}</h3>
                            <div class="price"><span><fmt:formatNumber value="${d.price}" pattern="#,###" /> đ</span></div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/common/footer.jsp" />
