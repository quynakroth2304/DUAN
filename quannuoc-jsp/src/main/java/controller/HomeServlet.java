package controller;

import service.CategoryService;
import service.DrinkService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet({"/", "/trang-chu"})
public class HomeServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryService();
    private DrinkService drinkService = new DrinkService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryIdStr = req.getParameter("categoryId");
        String keyword = req.getParameter("keyword");

        req.setAttribute("listCategory", categoryService.getAllActive());

        if (keyword != null && !keyword.isBlank()) {
            req.setAttribute("listDrink", drinkService.search(keyword));
            req.setAttribute("keyword", keyword);
        } else if (categoryIdStr != null && !categoryIdStr.isBlank()) {
            Integer categoryId = Integer.parseInt(categoryIdStr);
            req.setAttribute("listDrink", drinkService.getByCategory(categoryId));
            req.setAttribute("selectedCategoryId", categoryId);
        } else {
            req.setAttribute("listDrink", drinkService.getAllActive());
        }

        req.getRequestDispatcher("/trangchu.jsp").forward(req, resp);
    }
}
