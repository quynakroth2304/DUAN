package controller.admin;

import Entity.Category;
import Entity.Drink;
import service.CategoryService;
import service.DrinkService;
import service.ToppingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/admin/do-uong", "/admin/do-uong/them", "/admin/do-uong/sua", "/admin/do-uong/xoa"})
public class DrinkAdminServlet extends HttpServlet {

    private DrinkService drinkService = new DrinkService();
    private CategoryService categoryService = new CategoryService();
    private ToppingService toppingService = new ToppingService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();

        if (uri.contains("/xoa")) {
            drinkService.delete(Integer.parseInt(req.getParameter("id")));
            resp.sendRedirect(req.getContextPath() + "/admin/do-uong");
        } else if (uri.contains("/sua")) {
            Integer id = Integer.parseInt(req.getParameter("id"));
            Drink drink = drinkService.findById(id);
            req.setAttribute("drink", drink);
            req.setAttribute("listCategory", categoryService.getAll());
            req.setAttribute("listTopping", toppingService.getAll());
            List<Integer> selectedToppingIds = new ArrayList<>();
            drinkService.getToppingsOfDrink(id).forEach(dt -> selectedToppingIds.add(dt.getTopping().getId()));
            req.setAttribute("selectedToppingIds", selectedToppingIds);
            req.getRequestDispatcher("/admin/form-domon.jsp").forward(req, resp);
        } else if (uri.contains("/them")) {
            req.setAttribute("listCategory", categoryService.getAll());
            req.setAttribute("listTopping", toppingService.getAll());
            req.getRequestDispatcher("/admin/form-domon.jsp").forward(req, resp);
        } else {
            req.setAttribute("listDrink", drinkService.getAll());
            req.getRequestDispatcher("/admin/domon.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String image = req.getParameter("image");
        String priceStr = req.getParameter("price");
        String categoryIdStr = req.getParameter("categoryId");
        String[] toppingIdParams = req.getParameterValues("toppingId");

        if (name == null || name.isBlank() || priceStr == null || priceStr.isBlank() || categoryIdStr == null || categoryIdStr.isBlank()) {
            req.setAttribute("error", "Vui lòng nhập đầy đủ Tên, Giá và chọn Danh mục!");
            req.setAttribute("listCategory", categoryService.getAll());
            req.setAttribute("listTopping", toppingService.getAll());
            req.getRequestDispatcher("/admin/form-domon.jsp").forward(req, resp);
            return;
        }

        Drink drink = new Drink();
        drink.setName(name);
        drink.setDescription(description);
        drink.setImage(image);
        drink.setPrice(Integer.parseInt(priceStr));
        Category category = new Category();
        category.setId(Integer.parseInt(categoryIdStr));
        drink.setCategory(category);
        drink.setActive(true);

        List<Integer> toppingIds = new ArrayList<>();
        if (toppingIdParams != null) {
            for (String t : toppingIdParams) {
                toppingIds.add(Integer.parseInt(t));
            }
        }

        if (uri.contains("/them")) {
            drinkService.add(drink);
            drinkService.setToppings(drink.getId(), toppingIds);
        } else {
            Integer id = Integer.parseInt(idStr);
            drink.setId(id);
            drinkService.update(drink);
            drinkService.setToppings(id, toppingIds);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/do-uong");
    }
}
