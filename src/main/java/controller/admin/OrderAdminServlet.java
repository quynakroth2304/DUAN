package controller.admin;

import Entity.Bill;
import Entity.User;
import service.BillService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/admin/don-hang", "/admin/don-hang/chi-tiet", "/admin/don-hang/cap-nhat-trang-thai"})
public class OrderAdminServlet extends HttpServlet {

    private BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/chi-tiet")) {
            Integer id = Integer.parseInt(req.getParameter("id"));
            Bill bill = billService.findById(id);
            req.setAttribute("bill", bill);
            req.setAttribute("listDetail", billService.getDetails(id));
            req.setAttribute("listHistory", billService.getHistory(id));
            req.getRequestDispatcher("/admin/chitietdonhang.jsp").forward(req, resp);
        } else {
            String status = req.getParameter("status");
            if (status != null && !status.isBlank()) {
                req.setAttribute("listBill", billService.getByStatus(status));
                req.setAttribute("selectedStatus", status);
            } else {
                req.setAttribute("listBill", billService.getAll());
            }
            req.getRequestDispatcher("/admin/donhang.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer billId = Integer.parseInt(req.getParameter("id"));
        String status = req.getParameter("status");

        HttpSession session = req.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("currentUser");
        Integer updatedByUserId = currentUser == null ? null : currentUser.getId();

        billService.updateStatus(billId, status, updatedByUserId);
        resp.sendRedirect(req.getContextPath() + "/admin/don-hang/chi-tiet?id=" + billId);
    }
}
