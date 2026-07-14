package Repository;

import Entity.*;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class BillRepository {

    public List<Bill> getAll() {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            return em.createQuery("SELECT b FROM Bill b JOIN FETCH b.user ORDER BY b.createdAt DESC", Bill.class).getResultList();
        }
    }

    public List<Bill> getByUser(Integer userId) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<Bill> query = em.createQuery(
                    "SELECT b FROM Bill b WHERE b.user.id = :uid ORDER BY b.createdAt DESC", Bill.class);
            query.setParameter("uid", userId);
            return query.getResultList();
        }
    }

    public List<Bill> getByStatus(String status) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<Bill> query = em.createQuery(
                    "SELECT b FROM Bill b JOIN FETCH b.user WHERE b.status = :status ORDER BY b.createdAt DESC", Bill.class);
            query.setParameter("status", status);
            return query.getResultList();
        }
    }

    public Bill findById(Integer id) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<Bill> query = em.createQuery(
                    "SELECT b FROM Bill b JOIN FETCH b.user WHERE b.id = :id", Bill.class);
            query.setParameter("id", id);
            List<Bill> results = query.getResultList();
            return results.isEmpty() ? null : results.get(0);
        }
    }

    /** Tạo hóa đơn cùng chi tiết hóa đơn và topping trong 1 transaction. */
    public Bill checkout(Bill bill, List<BillDetail> details) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(bill);

            for (BillDetail detail : details) {
                detail.setBill(bill);
                List<BillDetailTopping> toppings = detail.getToppings();
                detail.setToppings(null);
                em.persist(detail);

                if (toppings != null) {
                    for (BillDetailTopping bdt : toppings) {
                        bdt.setBillDetail(detail);
                        em.persist(bdt);
                    }
                }
            }

            StatusHistory history = new StatusHistory();
            history.setBill(bill);
            history.setStatus(bill.getStatus());
            history.setUpdatedBy(bill.getUser());
            em.persist(history);

            tx.commit();
            return bill;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return null;
        } finally {
            em.close();
        }
    }

    public boolean updateStatus(Integer billId, String status, Integer updatedByUserId) {
        EntityManager em = EntityManagerUtils.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Bill bill = em.find(Bill.class, billId);
            if (bill == null) {
                tx.rollback();
                return false;
            }
            bill.setStatus(status);
            em.merge(bill);

            StatusHistory history = new StatusHistory();
            history.setBill(bill);
            history.setStatus(status);
            if (updatedByUserId != null) {
                history.setUpdatedBy(em.find(User.class, updatedByUserId));
            }
            em.persist(history);

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
