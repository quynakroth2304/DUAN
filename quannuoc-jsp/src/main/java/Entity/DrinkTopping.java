package Entity;

import jakarta.persistence.*;

@Entity
@Table(name = "DRINK_TOPPING")
public class DrinkTopping {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "drinkId")
    private Drink drink;

    @ManyToOne
    @JoinColumn(name = "toppingId")
    private Topping topping;

    public DrinkTopping() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Drink getDrink() { return drink; }
    public void setDrink(Drink drink) { this.drink = drink; }

    public Topping getTopping() { return topping; }
    public void setTopping(Topping topping) { this.topping = topping; }
}
