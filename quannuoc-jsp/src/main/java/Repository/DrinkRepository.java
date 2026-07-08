package Repository;

import Entity.Drink;
import Entity.DrinkTopping;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class DrinkRepository {

    public List<Drink> getAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT d FROM Drink d JOIN FETCH d.category ORDER BY d.id DESC", Drink.class).getResultList();
        }
    }

    public List<Drink> getAllActive() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT d FROM Drink d JOIN FETCH d.category WHERE d.active = true ORDER BY d.id DESC", Drink.class).getResultList();
        }
    }

    public List<Drink> getByCategory(Integer categoryId) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<Drink> query = em.createQuery(
                    "SELECT d FROM Drink d JOIN FETCH d.category WHERE d.active = true AND d.category.id = :cid ORDER BY d.id DESC",
                    Drink.class);
            query.setParameter("cid", categoryId);
            return query.getResultList();
        }
    }

    public List<Drink> search(String keyword) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<Drink> query = em.createQuery(
                    "SELECT d FROM Drink d JOIN FETCH d.category WHERE d.active = true AND d.name LIKE :kw ORDER BY d.id DESC",
                    Drink.class);
            query.setParameter("kw", "%" + keyword + "%");
            return query.getResultList();
        }
    }

    public Drink findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<Drink> query = em.createQuery(
                    "SELECT d FROM Drink d JOIN FETCH d.category WHERE d.id = :id", Drink.class);
            query.setParameter("id", id);
            List<Drink> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        }
    }

    public List<DrinkTopping> getToppingsOfDrink(Integer drinkId) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<DrinkTopping> query = em.createQuery(
                    "SELECT dt FROM DrinkTopping dt JOIN FETCH dt.topping WHERE dt.drink.id = :did", DrinkTopping.class);
            query.setParameter("did", drinkId);
            return query.getResultList();
        }
    }

    public boolean add(Drink drink) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(drink);
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

    public boolean update(Drink drink) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(drink);
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
            Drink drink = em.find(Drink.class, id);
            if (drink != null) {
                drink.setActive(false);
                em.merge(drink);
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

    public boolean setToppings(Integer drinkId, List<Integer> toppingIds) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.createQuery("DELETE FROM DrinkTopping dt WHERE dt.drink.id = :did")
                    .setParameter("did", drinkId)
                    .executeUpdate();

            Drink drink = em.find(Drink.class, drinkId);
            if (toppingIds != null) {
                for (Integer toppingId : toppingIds) {
                    Entity.Topping topping = em.find(Entity.Topping.class, toppingId);
                    if (topping != null) {
                        DrinkTopping dt = new DrinkTopping();
                        dt.setDrink(drink);
                        dt.setTopping(topping);
                        em.persist(dt);
                    }
                }
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
