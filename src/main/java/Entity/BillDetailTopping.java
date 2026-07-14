package Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "BILL_DETAIL_TOPPING")
public class BillDetailTopping {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "billDetailId")
    private BillDetail billDetail;

    @ManyToOne
    @JoinColumn(name = "toppingId")
    private Topping topping;

    @Column(nullable = false)
    private Integer price;

    public BillDetailTopping() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public BillDetail getBillDetail() { return billDetail; }
    public void setBillDetail(BillDetail billDetail) { this.billDetail = billDetail; }

    public Topping getTopping() { return topping; }
    public void setTopping(Topping topping) { this.topping = topping; }

    public Integer getPrice() { return price; }
    public void setPrice(Integer price) { this.price = price; }
}
