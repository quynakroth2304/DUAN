<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Thực đơn - Quán Nước" scope="request" />

<jsp:include page="/common/header.jsp" />

<div style="max-width: 1200px; margin: 0 auto; padding: 30px 15px; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">

    <div style="display: flex; justify-content: center; margin-bottom: 35px;">
        <form action="${pageContext.request.contextPath}/trang-chu" method="get" style="display: flex; width: 100%; max-width: 550px; border-radius: 50px; overflow: hidden; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); border: 2px solid #f0f0f0; background: #fff;">
            <input type="text" name="keyword" value="${keyword}" placeholder="Bạn muốn uống gì hôm nay?" style="flex: 1; padding: 14px 22px; border: none; outline: none; font-size: 16px; background: transparent;">
            <button type="submit" style="background-color: #ff6b6b; color: white; border: none; padding: 0 30px; font-size: 16px; font-weight: bold; cursor: pointer;">Tìm</button>
        </form>
    </div>

    <div style="display: flex; gap: 12px; flex-wrap: wrap; justify-content: center; margin-bottom: 40px;">
        <a href="${pageContext.request.contextPath}/trang-chu"
           style="text-decoration: none; padding: 10px 22px; border-radius: 30px; font-size: 15px; font-weight: 600;
                  ${empty selectedCategoryId ? 'background: #ff4757; color: #ffffff; box-shadow: 0 4px 10px rgba(255, 71, 87, 0.3);' : 'color: #555; background: #f4f4f4; border: 1px solid transparent;'}">
            Tất cả
        </a>

        <c:forEach items="${listCategory}" var="cate">
            <a href="${pageContext.request.contextPath}/trang-chu?categoryId=${cate.id}"
               style="text-decoration: none; padding: 10px 22px; border-radius: 30px; font-size: 15px; font-weight: 600;
                      ${selectedCategoryId == cate.id ? 'background: #ff4757; color: #ffffff; box-shadow: 0 4px 10px rgba(255, 71, 87, 0.3);' : 'color: #555; background: #f4f4f4; border: 1px solid transparent;'}">
                ${cate.name}
            </a>
        </c:forEach>
    </div>

    <h1 style="color: red; font-size: 50px; text-align: center; margin-bottom: 30px;">
        NẾU THẤY DÒNG NÀY LÀ CODE ĐÃ NHẬN!
    </h1>

    <c:choose>
        <c:when test="${empty listDrink}">
            <div style="text-align: center; padding: 60px 20px; color: #747d8c; font-size: 18px; background: #f8f9fa; border-radius: 16px; border: 2px dashed #ced4da;">
                <p>Opps! Không tìm thấy đồ uống nào phù hợp.</p>
            </div>
        </c:when>

        <c:otherwise>
            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 25px;">
                <c:forEach items="${listDrink}" var="d">
                    <a href="${pageContext.request.contextPath}/do-uong/chi-tiet?id=${d.id}" style="background: #ffffff; display: flex; flex-direction: column; overflow: hidden; border-radius: 16px; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05); text-decoration: none; color: inherit; border: 1px solid #f4f4f4;">

                        <div style="overflow: hidden; width: 100%; height: 220px;">
                            <img src="${not empty d.image ? d.image : 'https://placehold.co/400x300?text=Do+uong'}" alt="${d.name}" style="width: 100%; height: 220px; object-fit: cover; display: block;">
                        </div>

                        <div style="padding: 20px 16px; display: flex; flex-grow: 1; flex-direction: column; justify-content: space-between;">
                            <h3 style="margin: 0 0 12px 0; font-size: 18px; color: #2d3436; font-weight: 700; line-height: 1.4;">${d.name}</h3>
                            <div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto;">
                                <div style="font-size: 18px; font-weight: 800; color: #ff4757;">
                                    <fmt:formatNumber value="${d.price}" pattern="#,###" /> đ
                                </div>
                                <div style="background: #f1f2f6; color: #2f3542; width: 36px; height: 36px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 20px;">+</div>
                            </div>
                        </div>

                    </a>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

</div>

<jsp:include page="/common/footer.jsp" />