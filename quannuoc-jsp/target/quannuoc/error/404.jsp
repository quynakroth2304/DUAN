<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<c:set var="pageTitle" value="Không tìm thấy trang" scope="request" xmlns:c="http://java.sun.com/jsp/jstl/core"/>
<jsp:include page="/common/header.jsp" />
<div class="container">
    <div class="empty-state">
        <h2>404 - Không tìm thấy trang</h2>
        <p>Trang bạn tìm không tồn tại.</p>
        <a href="${pageContext.request.contextPath}/trang-chu" class="btn">Về trang chủ</a>
    </div>
</div>
<jsp:include page="/common/footer.jsp" />
