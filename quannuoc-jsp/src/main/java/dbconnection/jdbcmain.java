package dbconnection;

import utils.EntityManagerUtils;
import java.sql.Connection;
import java.sql.SQLException;

public class jdbcmain {

    public static void main(String[] args) {

        System.out.println("--- 1. TESTING JDBC CONNECTION ---");
        // Lưu ý: Đổi "sa" thành "root" nếu bạn dùng MySQL
        DatabaseConnection dcm = new DatabaseConnection("employee_db", "sa", "123");

        try (Connection connection = dcm.getConnection()) {
            System.out.println("✅ JDBC Connected successfully!");
        } catch (SQLException e) {
            System.out.println("❌ Failed to connect via JDBC");
            e.printStackTrace();
        }

        System.out.println("\n--- 2. TESTING JPA / HIBERNATE ---");
        try (var em = EntityManagerUtils.getEntityManager()) {
            System.out.println("✅ JPA EntityManager created successfully!");
            System.out.println("✅ Tables should be created/updated in the database.");

            // Bạn có thể thêm 1 lệnh lưu thử 1 nhân viên ở đây để test insert

        } catch (Exception e) {
            System.out.println("❌ Failed to initialize JPA");
            e.printStackTrace();
        } finally {
            // Rất quan trọng: Đóng Factory để giải phóng bộ nhớ và kết thúc chương trình
            EntityManagerUtils.close();
            System.out.println("✅ Closed EntityManagerFactory. End of test.");
        }
    }
}