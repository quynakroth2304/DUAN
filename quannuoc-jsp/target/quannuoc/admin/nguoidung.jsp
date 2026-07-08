<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Người dùng - Quản trị" scope="request" />
<c:set var="activeMenu" value="nguoi-dung" scope="request" />
<jsp:include page="/common/admin-header.jsp" />

<h2>Danh sách người dùng</h2>

<table class="data-table">
    <tr><th>ID</th><th>Họ tên</th><th>Email</th><th>SĐT</th><th>Vai trò</th><th>Trạng thái</th><th>Hành động</th></tr>
    <c:forEach items="${listUser}" var="u">
        <tr>
            <td>${u.id}</td>
            <td>${u.fullName}</td>
            <td>${u.email}</td>
            <td>${u.phone}</td>
            <td>${u.role ? 'Quản trị viên' : 'Khách hàng'}</td>
            <td>${u.active ? 'Đang hoạt động' : 'Đã khóa'}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/nguoi-dung/khoa?id=${u.id}"
                   onclick="return confirm('${u.active ? 'Khóa' : 'Mở khóa'} tài khoản này?');">
                        ${u.active ? 'Khóa' : 'Mở khóa'}
                </a> |
                <a href="${pageContext.request.contextPath}/admin/nguoi-dung/phan-quyen?id=${u.id}&admin=${u.role ? 0 : 1}"
                   onclick="return confirm('${u.role ? 'Gỡ quyền quản trị' : 'Cấp quyền quản trị'} cho người dùng này?');">
                        ${u.role ? 'Gỡ quyền admin' : 'Cấp quyền admin'}
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/common/admin-footer.jsp" />
