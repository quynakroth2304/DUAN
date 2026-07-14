package service;

import Entity.*;
import Repository.BillDetailRepository;
import Repository.BillRepository;
import Repository.StatusHistoryRepository;
import model.Cart;
import model.CartItem;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class BillService {
    private BillRepository billRepo = new BillRepository();
    private BillDetailRepository billDetailRepo = new BillDetailRepository();
    private StatusHistoryRepository historyRepo = new StatusHistoryRepository();

    public List<Bill> getAll() { return billRepo.getAll(); }
    public List<Bill> getByUser(Integer userId) { return billRepo.getByUser(userId); }
    public List<Bill> getByStatus(String status) { return billRepo.getByStatus(status); }
    public Bill findById(Integer id) { return billRepo.findById(id); }
    public List<BillDetail> getDetails(Integer billId) { return billDetailRepo.getByBillId(billId); }
    public List<StatusHistory> getHistory(Integer billId) { return historyRepo.getByBillId(billId); }

    /** Tạo hóa đơn từ giỏ hàng trong session. */
    public Bill checkout(User user, Cart cart) {
        if (cart == null || cart.getItems().isEmpty()) {
            return null;
        }

        Bill bill = new Bill();
        bill.setUser(user);
        bill.setCode("HD" + System.currentTimeMillis());
        bill.setStatus("waiting");
        bill.setTotal(cart.getTotal());

        List<BillDetail> details = new ArrayList<>();
        for (CartItem item : cart.getItems()) {
            BillDetail detail = new BillDetail();
            Drink drink = new Drink();
            drink.setId(item.getDrinkId());
            detail.setDrink(drink);

            Size size = new Size();
            size.setId(item.getSizeId());
            detail.setSize(size);

            detail.setQuantity(item.getQuantity());
            detail.setPrice(item.getUnitPrice());

            List<BillDetailTopping> toppings = new ArrayList<>();
            if (item.getToppingIds() != null) {
                for (Integer toppingId : item.getToppingIds()) {
                    BillDetailTopping bdt = new BillDetailTopping();
                    Topping topping = new Topping();
                    topping.setId(toppingId);
                    bdt.setTopping(topping);
                    bdt.setPrice(item.getToppingPrice(toppingId));
                    toppings.add(bdt);
                }
            }
            detail.setToppings(toppings);
            details.add(detail);
        }

        return billRepo.checkout(bill, details);
    }

    public boolean updateStatus(Integer billId, String status, Integer updatedByUserId) {
        return billRepo.updateStatus(billId, status, updatedByUserId);
    }
}
