package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Cart implements Serializable {

    private List<CartItem> items = new ArrayList<>();

    public List<CartItem> getItems() { return items; }

    public void addItem(CartItem newItem) {
        for (CartItem item : items) {
            if (item.getKey().equals(newItem.getKey())) {
                item.setQuantity(item.getQuantity() + newItem.getQuantity());
                return;
            }
        }
        items.add(newItem);
    }

    public void updateQuantity(String key, int quantity) {
        for (CartItem item : items) {
            if (item.getKey().equals(key)) {
                item.setQuantity(quantity);
            }
        }
    }

    public void removeItem(String key) {
        items.removeIf(item -> item.getKey().equals(key));
    }

    public void clear() {
        items.clear();
    }

    public int getTotal() {
        int total = 0;
        for (CartItem item : items) {
            total += item.getLineTotal();
        }
        return total;
    }

    public int getItemCount() {
        int count = 0;
        for (CartItem item : items) {
            count += item.getQuantity();
        }
        return count;
    }
}
