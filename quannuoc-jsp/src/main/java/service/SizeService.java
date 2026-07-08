package service;

import Entity.Size;
import Repository.SizeRepository;
import java.util.List;

public class SizeService {
    private SizeRepository sizeRepo = new SizeRepository();

    public List<Size> getAll() { return sizeRepo.getAll(); }
    public Size findById(Integer id) { return sizeRepo.findById(id); }
    public boolean add(Size size) { return sizeRepo.add(size); }
    public boolean update(Size size) { return sizeRepo.update(size); }
    public boolean delete(Integer id) { return sizeRepo.delete(id); }
}
