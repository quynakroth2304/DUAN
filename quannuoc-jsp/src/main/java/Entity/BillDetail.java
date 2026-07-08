package Entity;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "BILL_DETAIL")
public class BillDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "billId")
    private Bill bill;

    @ManyToOne
    @JoinColumn(name = "drinkId")
    private Drink drink;

    @ManyToOne
    @JoinColumn(name = "sizeId")
    private Size size;

    @Column(nullable = false)
    private Integer quantity;

    /** Đơn giá đã tính (giá đồ uống + giá size) tại thời điểm đặt hàng */
    @Column(nullable = false)
    private Integer price;

    @Transient
    private List<BillDetailTopping> toppings;

    public BillDetail() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Bill getBill() { return bill; }
    public void setBill(Bill bill) { this.bill = bill; }

    public Drink getDrink() { return drink; }
    public void setDrink(Drink drink) { this.drink = drink; }

    public Size getSize() { return size; }
    public void setSize(Size size) { this.size = size; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public Integer getPrice() { return price; }
    public void setPrice(Integer price) { this.price = price; }

    public List<BillDetailTopping> getToppings() { return toppings; }
    public void setToppings(List<BillDetailTopping> toppings) { this.toppings = toppings; }
}
