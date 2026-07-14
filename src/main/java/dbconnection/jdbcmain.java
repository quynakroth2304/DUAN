package dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class jdbcmain {
    private String url;
    private String username;
    private String password;

    // Constructor nhận vào tên DB, user và password từ jdbcmain
    public jdbcmain(String dbName, String username, String password) {
        /* * MẶC ĐỊNH CHO SQL SERVER (Vì bạn đang dùng user "sa")
         * Lưu ý: port mặc định là 1433. Nếu máy bạn dùng port khác, hãy sửa lại.
         */
        this.url = "jdbc:sqlserver://localhost:1433;databaseName=" + dbName + ";encrypt=true;trustServerCertificate=true;";

        /* * NẾU BẠN DÙNG MYSQL (user thường là "root"):
         * Bôi đen comment (//) dòng url của SQL Server ở trên, và xóa dấu // ở dòng dưới đây:
         * this.url = "jdbc:mysql://localhost:3306/" + dbName;
         */

        this.username = username;
        this.password = password;
    }

    // Phương thức tạo và trả về Connection cho jdbcmain
    public Connection getConnection() throws SQLException {
        // Cố gắng thiết lập kết nối tới cơ sở dữ liệu
        return DriverManager.getConnection(url, username, password);
    }
}