package service;

import Entity.Drink;
import Entity.DrinkTopping;
import Repository.DrinkRepository;
import java.util.List;

public class DrinkService {
    private DrinkRepository drinkRepo = new DrinkRepository();

    public List<Drink> getAll() { return drinkRepo.getAll(); }
    public List<Drink> getAllActive() { return drinkRepo.getAllActive(); }
    public List<Drink> getByCategory(Integer categoryId) { return drinkRepo.getByCategory(categoryId); }
    public List<Drink> search(String keyword) { return drinkRepo.search(keyword); }
    public Drink findById(Integer id) { return drinkRepo.findById(id); }
    public List<DrinkTopping> getToppingsOfDrink(Integer drinkId) { return drinkRepo.getToppingsOfDrink(drinkId); }
    public boolean add(Drink drink) { return drinkRepo.add(drink); }
    public boolean update(Drink drink) { return drinkRepo.update(drink); }
    public boolean delete(Integer id) { return drinkRepo.delete(id); }
    public boolean setToppings(Integer drinkId, List<Integer> toppingIds) { return drinkRepo.setToppings(drinkId, toppingIds); }
}
