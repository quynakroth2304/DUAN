package controller.admin;

import Entity.Topping;
import service.ToppingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/admin/topping", "/admin/topping/them", "/admin/topping/sua", "/admin/topping/xoa"})
public class ToppingAdminServlet extends HttpServlet {

    private ToppingService toppingService = new ToppingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/xoa")) {
            toppingService.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/topping");
        } else if (uri.contains("/sua")) {
            req.setAttribute("topping", toppingService.findById(Integer.parseInt(req.getParameter("id"))));
            req.getRequestDispatcher("/admin/form-topping.jsp").forward(req, resp);
        } else if (uri.contains("/them")) {
            req.getRequestDispatcher("/admin/form-topping.jsp").forward(req, resp);
        } else {
            req.setAttribute("listTopping", toppingService.getAll());
            req.getRequestDispatcher("/admin/topping.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String priceStr = req.getParameter("price");

        if (name == null || name.isBlank() || priceStr == null || priceStr.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ Tên topping và Giá!");
            req.getRequestDispatcher("/admin/form-topping.jsp").forward(req, resp);
            return;
        }

        Topping topping = new Topping();
        topping.setName(name);
        topping.setPrice(Integer.parseInt(priceStr));

        if (uri.contains("/them")) {
            toppingService.add(topping);
        } else {
            topping.setId(Integer.parseInt(idStr));
            toppingService.update(topping);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/topping");
    }
}
