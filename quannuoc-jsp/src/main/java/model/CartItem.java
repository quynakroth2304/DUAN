package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CartItem implements Serializable {

    private String key;
    private Integer drinkId;
    private String drinkName;
    private String drinkImage;
    private Integer sizeId;
    private String sizeName;
    private Integer basePrice;
    private Integer sizePrice;
    private List<Integer> toppingIds = new ArrayList<>();
    private Map<Integer, String> toppingNames = new HashMap<>();
    private Map<Integer, Integer> toppingPrices = new HashMap<>();
    private Integer quantity = 1;

    public CartItem() {}

    public String getKey() { return key; }
    public void setKey(String key) { this.key = key; }

    public Integer getDrinkId() { return drinkId; }
    public void setDrinkId(Integer drinkId) { this.drinkId = drinkId; }

    public String getDrinkName() { return drinkName; }
    public void setDrinkName(String drinkName) { this.drinkName = drinkName; }

    public String getDrinkImage() { return drinkImage; }
    public void setDrinkImage(String drinkImage) { this.drinkImage = drinkImage; }

    public Integer getSizeId() { return sizeId; }
    public void setSizeId(Integer sizeId) { this.sizeId = sizeId; }

    public String getSizeName() { return sizeName; }
    public void setSizeName(String sizeName) { this.sizeName = sizeName; }

    public Integer getBasePrice() { return basePrice; }
    public void setBasePrice(Integer basePrice) { this.basePrice = basePrice; }

    public Integer getSizePrice() { return sizePrice; }
    public void setSizePrice(Integer sizePrice) { this.sizePrice = sizePrice; }

    public List<Integer> getToppingIds() { return toppingIds; }
    public void setToppingIds(List<Integer> toppingIds) { this.toppingIds = toppingIds; }

    public Map<Integer, String> getToppingNames() { return toppingNames; }
    public void setToppingNames(Map<Integer, String> toppingNames) { this.toppingNames = toppingNames; }

    public Map<Integer, Integer> getToppingPrices() { return toppingPrices; }
    public void setToppingPrices(Map<Integer, Integer> toppingPrices) { this.toppingPrices = toppingPrices; }

    public Integer getToppingPrice(Integer toppingId) {
        Integer p = toppingPrices.get(toppingId);
        return p == null ? 0 : p;
    }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Integer getToppingsTotal() {
        int sum = 0;
        for (Integer price : toppingPrices.values()) {
            sum += price;
        }
        return sum;
    }

    /** Đơn giá 1 phần = giá đồ uống + giá size + tổng giá topping. */
    public Integer getUnitPrice() {
        return basePrice + sizePrice + getToppingsTotal();
    }

    public Integer getLineTotal() {
        return getUnitPrice() * quantity;
    }
}
