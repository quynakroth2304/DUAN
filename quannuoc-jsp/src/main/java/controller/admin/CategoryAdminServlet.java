package controller.admin;

import Entity.Category;
import service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/admin/danh-muc", "/admin/danh-muc/them", "/admin/danh-muc/sua", "/admin/danh-muc/xoa"})
public class CategoryAdminServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/xoa")) {
            categoryService.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/danh-muc");
        } else if (uri.contains("/sua")) {
            Integer id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("category", categoryService.findById(id));
            req.getRequestDispatcher("/admin/form-danhmuc.jsp").forward(req, resp);
        } else if (uri.contains("/them")) {
            req.getRequestDispatcher("/admin/form-danhmuc.jsp").forward(req, resp);
        } else {
            req.setAttribute("listCategory", categoryService.getAll());
            req.getRequestDispatcher("/admin/danhmuc.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");

        if (name == null || name.isBlank()) {
            req.setAttribute("error", "Tên danh mục không được để trống!");
            if (idStr != null && !idStr.isBlank()) {
                req.setAttribute("category", categoryService.findById(Integer.parseInt(idStr)));
            }
            req.getRequestDispatcher("/admin/form-danhmuc.jsp").forward(req, resp);
            return;
        }

        Category category = new Category();
        category.setName(name);
        category.setActive(true);

        if (uri.contains("/them")) {
            categoryService.add(category);
        } else {
            category.setId(Integer.parseInt(idStr));
            categoryService.update(category);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/danh-muc");
    }
}
