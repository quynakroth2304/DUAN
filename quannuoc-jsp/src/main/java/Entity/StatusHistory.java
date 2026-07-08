package Entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "STATUS_HISTORY")
public class StatusHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "billId")
    private Bill bill;

    private String status;

    @ManyToOne
    @JoinColumn(name = "updatedBy")
    private User updatedBy;

    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt = new Date();

    public StatusHistory() {}

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Bill getBill() { return bill; }
    public void setBill(Bill bill) { this.bill = bill; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public User getUpdatedBy() { return updatedBy; }
    public void setUpdatedBy(User updatedBy) { this.updatedBy = updatedBy; }

    public Date getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Date updatedAt) { this.updatedAt = updatedAt; }
}
