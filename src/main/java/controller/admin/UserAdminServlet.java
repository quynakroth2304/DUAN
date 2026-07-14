package controller.admin;

import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/admin/nguoi-dung", "/admin/nguoi-dung/khoa", "/admin/nguoi-dung/phan-quyen"})
public class UserAdminServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        Integer id = req.getParameter("id") != null ? Integer.parseInt(req.getParameter("id")) : null;

        if (uri.contains("/khoa") && id != null) {
            userService.toggleActive(id);
            resp.sendRedirect(req.getContextPath() + "/admin/nguoi-dung");
        } else if (uri.contains("/phan-quyen") && id != null) {
            boolean makeAdmin = "1".equals(req.getParameter("admin"));
            userService.setRole(id, makeAdmin);
            resp.sendRedirect(req.getContextPath() + "/admin/nguoi-dung");
        } else {
            req.setAttribute("listUser", userService.getAll());
            req.getRequestDispatcher("/admin/nguoidung.jsp").forward(req, resp);
        }
    }
}
