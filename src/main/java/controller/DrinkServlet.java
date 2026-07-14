package controller;

import Entity.Drink;
import Entity.DrinkTopping;
import service.DrinkService;
import service.SizeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

/** Trang chi tiết đồ uống dành cho khách hàng, dùng để chọn size + topping trước khi thêm vào giỏ. */
@WebServlet("/do-uong/chi-tiet")
public class DrinkServlet extends HttpServlet {

    private DrinkService drinkService = new DrinkService();
    private SizeService sizeService = new SizeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Integer id = Integer.parseInt(req.getParameter("id"));
        Drink drink = drinkService.findById(id);
        if (drink == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        java.util.List<DrinkTopping> toppings = drinkService.getToppingsOfDrink(id);

        req.setAttribute("drink", drink);
        req.setAttribute("listToppingOfDrink", toppings);
        req.setAttribute("listSize", sizeService.getAll());
        req.getRequestDispatcher("/chitietdomon.jsp").forward(req, resp);
    }
}
