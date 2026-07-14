package controller;

import Entity.Bill;
import Entity.User;
import model.Cart;
import service.BillService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/thanh-toan"})
public class CheckoutServlet extends HttpServlet {

    private BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("currentUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap?redirect=/gio-hang");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/gio-hang");
            return;
        }

        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/thanhtoan.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("currentUser");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap?redirect=/gio-hang");
            return;
        }

        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/gio-hang");
            return;
        }

        Bill bill = billService.checkout(user, cart);
        if (bill == null) {
            req.setAttribute("cart", cart);
            req.setAttribute("error", "Đặt hàng thất bại, vui lòng thử lại!");
            req.getRequestDispatcher("/thanhtoan.jsp").forward(req, resp);
            return;
        }

        cart.clear();
        resp.sendRedirect(req.getContextPath() + "/don-hang/chi-tiet?id=" + bill.getId() + "&success=1");
    }
}
