package controller;

import Entity.User;
import service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/dang-nhap", "/dang-ky", "/dang-xuat"})
public class AuthServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/dang-nhap")) {
            req.getRequestDispatcher("/dangnhap.jsp").forward(req, resp);
        } else if (uri.contains("/dang-ky")) {
            req.getRequestDispatcher("/dangky.jsp").forward(req, resp);
        } else if (uri.contains("/dang-xuat")) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/trang-chu");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/dang-nhap")) {
            handleLogin(req, resp);
        } else if (uri.contains("/dang-ky")) {
            handleRegister(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String redirect = req.getParameter("redirect");

        User user = userService.login(email, password);
        if (user == null) {
            req.setAttribute("error", "Email hoặc mật khẩu không đúng, hoặc tài khoản đã bị khóa!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/dangnhap.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("currentUser", user);

        if (redirect != null && !redirect.isBlank()) {
            resp.sendRedirect(req.getContextPath() + redirect);
        } else if (Boolean.TRUE.equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin/don-hang");
        } else {
            resp.sendRedirect(req.getContextPath() + "/trang-chu");
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String fullName = req.getParameter("fullName");
        String phone = req.getParameter("phone");

        if (email == null || email.isBlank() || password == null || password.isBlank() || fullName == null || fullName.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ Email, Mật khẩu và Họ tên!");
            forwardBackToRegister(req, resp, email, fullName, phone);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            forwardBackToRegister(req, resp, email, fullName, phone);
            return;
        }

        User user = userService.register(email, password, fullName, phone);
        if (user == null) {
            req.setAttribute("error", "Email này đã được đăng ký!");
            forwardBackToRegister(req, resp, email, fullName, phone);
            return;
        }

        req.setAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
        req.getRequestDispatcher("/dangnhap.jsp").forward(req, resp);
    }

    private void forwardBackToRegister(HttpServletRequest req, HttpServletResponse resp, String email, String fullName, String phone)
            throws ServletException, IOException {
        req.setAttribute("email", email);
        req.setAttribute("fullName", fullName);
        req.setAttribute("phone", phone);
        req.getRequestDispatcher("/dangky.jsp").forward(req, resp);
    }
}
