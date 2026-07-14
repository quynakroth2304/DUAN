package controller;

import Entity.Bill;
import Entity.User;
import service.BillService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/** Lịch sử đơn hàng + chi tiết đơn hàng cho khách hàng. */
@WebServlet({"/don-hang", "/don-hang/chi-tiet"})
public class BillServlet extends HttpServlet {

    private BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("currentUser");

        // Kiểm tra đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/dang-nhap?redirect=" + req.getRequestURI());
            return; // Dừng hàm lại tại đây nếu chưa đăng nhập
        } // Đã đóng ngoặc if đúng vị trí

        // Khai báo biến uri ở ngoài để toàn bộ hàm doGet có thể sử dụng
        String uri = req.getRequestURI();

        // Đã xóa chữ String bị dư
        if (uri.contains("/chi-tiet")) {
            Integer id = Integer.parseInt(req.getParameter("id"));
            Bill bill = billService.findById(id);

            if (bill == null || (!bill.getUser().getId().equals(user.getId()) && !Boolean.TRUE.equals(user.getRole()))) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            req.setAttribute("bill", bill);
            req.setAttribute("listDetail", billService.getDetails(id));
            req.setAttribute("listHistory", billService.getHistory(id));
            req.getRequestDispatcher("/chitiethoadon.jsp").forward(req, resp);
        } else {
            req.setAttribute("listBill", billService.getByUser(user.getId()));
            req.getRequestDispatcher("/hoadon.jsp").forward(req, resp);
        }
    }
}