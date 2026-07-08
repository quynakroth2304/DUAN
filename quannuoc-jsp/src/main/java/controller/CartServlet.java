package controller;

import Entity.Drink;
import Entity.Size;
import Entity.Topping;
import model.Cart;
import model.CartItem;
import service.DrinkService;
import service.SizeService;
import service.ToppingService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/gio-hang", "/gio-hang/them", "/gio-hang/cap-nhat", "/gio-hang/xoa"})
public class CartServlet extends HttpServlet {

    private DrinkService drinkService = new DrinkService();
    private SizeService sizeService = new SizeService();
    private ToppingService toppingService = new ToppingService();

    private Cart getCart(HttpServletRequest req) {
        HttpSession session = req.getSession(true);
        Cart cart = (Cart) session.getAttribute("cart");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        Cart cart = getCart(req);

        if (uri.contains("/xoa")) {
            cart.removeItem(req.getParameter("key"));
            resp.sendRedirect(req.getContextPath() + "/gio-hang");
            return;
        }

        req.setAttribute("cart", cart);
        req.getRequestDispatcher("/giohang.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        Cart cart = getCart(req);

        if (uri.contains("/them")) {
            addToCart(req, resp, cart);
        } else if (uri.contains("/cap-nhat")) {
            String key = req.getParameter("key");
            int quantity = Integer.parseInt(req.getParameter("quantity"));
            if (quantity <= 0) {
                cart.removeItem(key);
            } else {
                cart.updateQuantity(key, quantity);
            }
            resp.sendRedirect(req.getContextPath() + "/gio-hang");
        }
    }

    private void addToCart(HttpServletRequest req, HttpServletResponse resp, Cart cart) throws IOException {
        Integer drinkId = Integer.parseInt(req.getParameter("drinkId"));
        Integer sizeId = Integer.parseInt(req.getParameter("sizeId"));
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        String[] toppingIdParams = req.getParameterValues("toppingId");

        Drink drink = drinkService.findById(drinkId);
        Size size = sizeService.findById(sizeId);

        CartItem item = new CartItem();
        item.setDrinkId(drinkId);
        item.setDrinkName(drink.getName());
        item.setDrinkImage(drink.getImage());
        item.setBasePrice(drink.getPrice());
        item.setSizeId(sizeId);
        item.setSizeName(size.getName());
        item.setSizePrice(size.getPrice());
        item.setQuantity(quantity <= 0 ? 1 : quantity);

        StringBuilder keyBuilder = new StringBuilder(drinkId + "-" + sizeId);
        List<Integer> toppingIds = new ArrayList<>();
        if (toppingIdParams != null) {
            for (String toppingIdStr : toppingIdParams) {
                Integer toppingId = Integer.parseInt(toppingIdStr);
                Topping topping = toppingService.findById(toppingId);
                toppingIds.add(toppingId);
                item.getToppingNames().put(toppingId, topping.getName());
                item.getToppingPrices().put(toppingId, topping.getPrice());
                keyBuilder.append("-t").append(toppingId);
            }
        }
        item.setToppingIds(toppingIds);
        item.setKey(keyBuilder.toString());

        cart.addItem(item);
        resp.sendRedirect(req.getContextPath() + "/gio-hang");
    }
}
