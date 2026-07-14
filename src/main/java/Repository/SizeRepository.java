package Repository;

import Entity.Size;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import java.util.List;

public class SizeRepository {

    public List<Size> getAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT s FROM Size s ORDER BY s.id", Size.class).getResultList();
        }
    }

    public Size findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.find(Size.class, id);
        }
    }

    public boolean add(Size size) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(size);
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

    public boolean update(Size size) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(size);
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
            Size size = em.find(Size.class, id);
            if (size != null) {
                em.remove(size);
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
