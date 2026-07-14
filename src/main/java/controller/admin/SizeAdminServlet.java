package controller.admin;

import Entity.Size;
import service.SizeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/admin/size", "/admin/size/them", "/admin/size/sua", "/admin/size/xoa"})
public class SizeAdminServlet extends HttpServlet {

    private SizeService sizeService = new SizeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/xoa")) {
            sizeService.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/size");
        } else if (uri.contains("/sua")) {
            req.setAttribute("size", sizeService.findById(Integer.parseInt(req.getParameter("id"))));
            req.getRequestDispatcher("/admin/form-size.jsp").forward(req, resp);
        } else if (uri.contains("/them")) {
            req.getRequestDispatcher("/admin/form-size.jsp").forward(req, resp);
        } else {
            req.setAttribute("listSize", sizeService.getAll());
            req.getRequestDispatcher("/admin/size.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");

        if (name == null || name.isBlank() || priceStr == null || priceStr.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ Tên size và Giá cộng thêm!");
            req.getRequestDispatcher("/admin/form-size.jsp").forward(req, resp);
            return;
        }

        Size size = new Size();
        size.setName(name);
        size.setPrice(Integer.parseInt(priceStr));

        if (uri.contains("/them")) {
            sizeService.add(size);
        } else {
            size.setId(Integer.parseInt(idStr));
            sizeService.update(size);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/size");
    }
}
