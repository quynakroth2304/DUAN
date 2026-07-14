package service;

import Entity.User;
import Repository.UserRepository;
import utils.PasswordUtils;
import java.util.List;

public class UserService {
    private UserRepository userRepo = new UserRepository();

    public List<User> getAll() { return userRepo.getAll(); }
    public User findById(Integer id) { return userRepo.findById(id); }
    public User findByEmail(String email) { return userRepo.findByEmail(email); }

    /** Trả về null nếu email đã tồn tại. */
    public User register(String email, String rawPassword, String fullName, String phone) {
        if (userRepo.findByEmail(email) != null) {
            return null;
        }
        User user = new User();
        user.setEmail(email);
        user.setPassword(PasswordUtils.hash(rawPassword));
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setRole(false);
        user.setActive(true);
        boolean ok = userRepo.add(user);
        return ok ? user : null;
    }

    /** Trả về User nếu đăng nhập thành công, null nếu sai email/mật khẩu hoặc tài khoản bị khóa. */
    public User login(String email, String rawPassword) {
        User user = userRepo.findByEmail(email);
        if (user == null || !user.getActive()) {
            return null;
        }
        if (!PasswordUtils.matches(rawPassword, user.getPassword())) {
            return null;
        }
        return user;
    }

    public boolean update(User user) { return userRepo.update(user); }

    public boolean toggleActive(Integer id) {
        User user = userRepo.findById(id);
        if (user == null) return false;
        user.setActive(!user.getActive());
        return userRepo.update(user);
    }

    public boolean setRole(Integer id, boolean isAdmin) {
        User user = userRepo.findById(id);
        if (user == null) return false;
        user.setRole(isAdmin);
        return userRepo.update(user);
    }
}
