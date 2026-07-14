package Repository;

import Entity.BillDetail;
import Entity.BillDetailTopping;
import utils.EntityManagerUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class BillDetailRepository {

    public List<BillDetail> getByBillId(Integer billId) {
        try (EntityManager em = EntityManagerUtils.getEntityManager()) {
            TypedQuery<BillDetail> query = em.createQuery(
                    "SELECT bd FROM BillDetail bd JOIN FETCH bd.drink JOIN FETCH bd.size WHERE bd.bill.id = :bid",
                    BillDetail.class);
            query.setParameter("bid", billId);
            List<BillDetail> details = query.getResultList();
            for (BillDetail detail : details) {
                detail.setToppings(getToppingsOfDetail(em, detail.getId()));
            }
            return details;
        }
    }

    private List<BillDetailTopping> getToppingsOfDetail(EntityManager em, Integer billDetailId) {
        TypedQuery<BillDetailTopping> query = em.createQuery(
                "SELECT bdt FROM BillDetailTopping bdt JOIN FETCH bdt.topping WHERE bdt.billDetail.id = :did",
                BillDetailTopping.class);
        query.setParameter("did", billDetailId);
        return query.getResultList();
    }
}
