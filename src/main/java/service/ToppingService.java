package service;

import Entity.Topping;
import Repository.ToppingRepository;
import java.util.List;

public class ToppingService {
    private ToppingRepository toppingRepo = new ToppingRepository();

    public List<Topping> getAll() { return toppingRepo.getAll(); }
    public Topping findById(Integer id) { return toppingRepo.findById(id); }
    public boolean add(Topping topping) { return toppingRepo.add(topping); }
    public boolean update(Topping topping) { return toppingRepo.update(topping); }
    public boolean delete(Integer id) { return toppingRepo.delete(id); }
}
