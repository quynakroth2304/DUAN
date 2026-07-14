package Repository;

import Entity.StatusHistory;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class StatusHistoryRepository {

    public List<StatusHistory> getByBillId(Integer billId) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<StatusHistory> query = em.createQuery(
                    "SELECT sh FROM StatusHistory sh LEFT JOIN FETCH sh.updatedBy WHERE sh.bill.id = :bid ORDER BY sh.updatedAt",
                    StatusHistory.class);
            query.setParameter("bid", billId);
            return query.getResultList();
        }
    }
}
