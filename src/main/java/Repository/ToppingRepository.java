package Repository;

import Entity.Topping;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class ToppingRepository {

    public List<Topping> getAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT t FROM Topping t ORDER BY t.id", Topping.class).getResultList();
        }
    }

    public Topping findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.find(Topping.class, id);
        }
    }

    public boolean add(Topping topping) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(topping);
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

    public boolean update(Topping topping) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(topping);
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

    public boolean delete(Integer id) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Topping topping = em.find(Topping.class, id);
            if (topping != null) {
                em.remove(topping);
            }
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
