<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<jsp:include page="/common/header.jsp" />
<div class="container">
    <div class="empty-state">
        <h2>403 - Không có quyền truy cập</h2>
        <p>Bạn không có quyền xem trang này.</p>
        <a href="${pageContext.request.contextPath}/trang-chu" class="btn">Về trang chủ</a>
    </div>
</div>
<jsp:include page="/common/footer.jsp" />
