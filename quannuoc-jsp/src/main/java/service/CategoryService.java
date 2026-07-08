package service;

import Entity.Category;
import Repository.CategoryRepository;
import java.util.List;

public class CategoryService {
    private CategoryRepository categoryRepo = new CategoryRepository();

    public List<Category> getAll() { return categoryRepo.getAll(); }
    public List<Category> getAllActive() { return categoryRepo.getAllActive(); }
    public Category findById(Integer id) { return categoryRepo.findById(id); }
    public boolean add(Category category) { return categoryRepo.add(category); }
    public boolean update(Category category) { return categoryRepo.update(category); }
    public boolean delete(Integer id) { return categoryRepo.delete(id); }
}
