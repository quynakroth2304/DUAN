<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="${drink.name} - Quán Nước" scope="request" />
<jsp:include page="/common/header.jsp" />

<div class="container">
    <div style="display:flex;gap:30px;flex-wrap:wrap;">
        <img src="${not empty drink.image ? drink.image : 'https://placehold.co/400x300?text=Do+uong'}"
             alt="${drink.name}" style="width:340px;height:260px;object-fit:cover;border-radius:10px;">

        <div style="flex:1;min-width:280px;">
            <h1 style="margin-top:0;">${drink.name}</h1>
            <p>${drink.description}</p>
            <p class="price" style="font-size:20px;"><fmt:formatNumber value="${drink.price}" pattern="#,###" /> đ</p>

            <form action="${pageContext.request.contextPath}/gio-hang/them" method="post">
                <input type="hidden" name="drinkId" value="${drink.id}">

                <div class="form-group">
                    <label>Chọn size</label>
                    <select name="sizeId" required>
                        <c:forEach items="${requestScope.listSize}" var="s">
                            <option value="${s.id}">${s.name} (+<fmt:formatNumber value="${s.price}" pattern="#,###" /> đ)</option>
                        </c:forEach>
                    </select>
                </div>

                <c:if test="${not empty listToppingOfDrink}">
                    <div class="form-group">
                        <label>Topping thêm</label>
                        <div class="checkbox-list">
                            <c:forEach items="${listToppingOfDrink}" var="dt">
                                <label>
                                    <input type="checkbox" name="toppingId" value="${dt.topping.id}">
                                    ${dt.topping.name} (+<fmt:formatNumber value="${dt.topping.price}" pattern="#,###" />đ)
                                </label>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="form-group" style="max-width:120px;">
                    <label>Số lượng</label>
                    <input type="number" name="quantity" value="1" min="1">
                </div>

                <button type="submit" class="btn">Thêm vào giỏ hàng</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />
