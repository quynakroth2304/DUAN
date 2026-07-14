package Repository;

import Entity.User;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class UserRepository {

    public List<User> getAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT u FROM User u ORDER BY u.id DESC", User.class).getResultList();
        }
    }

    public User findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.find(User.class, id);
        }
    }

    public User findByEmail(String email) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email);
            try {
                return query.getSingleResult();
            } catch (NoResultException e) {
                return null;
            }
        }
    }

    public boolean add(User user) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean update(User user) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(user);
            tx.commit();
            return true;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
