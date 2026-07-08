# Quán Nước - Hệ thống bán đồ uống online

Ứng dụng web Java (Servlet + JSP + JPA/Hibernate) cho quán nước, gồm 2 phần:

- **Trang khách hàng**: xem thực đơn theo danh mục, tìm kiếm, xem chi tiết đồ uống (chọn size + topping), giỏ hàng, thanh toán, xem lịch sử đơn hàng.
- **Trang quản trị** (`/admin/*`, yêu cầu tài khoản có quyền admin): quản lý danh mục, đồ uống (kèm gán topping), size, topping, người dùng, và quản lý/đổi trạng thái đơn hàng.

## Công nghệ sử dụng

- Java 17+, Jakarta Servlet 6 / JSP (biên dịch theo chuẩn Jakarta EE)
- Hibernate ORM (JPA) + `mssql-jdbc` — kết nối SQL Server
- JSTL cho các trang JSP
- Maven (đóng gói WAR) — deploy trên Tomcat 10+ (hoặc bất kỳ container hỗ trợ Jakarta EE 9+)
- Mật khẩu được băm bằng SHA-256 (xem `utils/PasswordUtils`)

## Cấu trúc thư mục

```
src/main/java/
  Entity/          Các lớp JPA Entity ánh xạ đúng theo schema CSDL (USER, CATEGORY, DRINK, SIZE, TOPPING, DRINK_TOPPING, BILL, BILL_DETAIL, BILL_DETAIL_TOPPING, STATUS_HISTORY)
  Repository/      Lớp truy vấn dữ liệu (dùng EntityManager)
  service/         Lớp xử lý nghiệp vụ
  controller/      Servlet cho khách hàng
  controller/admin/Servlet cho trang quản trị
  filter/          AuthFilter bảo vệ /admin/*
  model/           Cart, CartItem (giỏ hàng lưu trong session)
  utils/           EntityManagerUtils, PasswordUtils

src/main/resources/META-INF/persistence.xml   Cấu hình JPA/Hibernate (SQLServerDialect)
src/main/webapp/     Các trang JSP + CSS
src/main/webapp/WEB-INF/web.xml
```

## Cấu hình kết nối cơ sở dữ liệu

Cơ sở dữ liệu SQL Server (`QUANNUOC`) phải được tạo trước theo đúng file schema đã cung cấp (không dùng `hbm2ddl.auto=create`, ứng dụng chỉ map vào bảng có sẵn).

Mở file `src/main/resources/META-INF/persistence.xml` và chỉnh lại các thông số:

```xml
<property name="jakarta.persistence.jdbc.url"
    value="jdbc:sqlserver://localhost:1433;databaseName=QUANNUOC;encrypt=true;trustServerCertificate=true"/>
<property name="jakarta.persistence.jdbc.user" value="sa"/>
<property name="jakarta.persistence.jdbc.password" value="YOUR_PASSWORD"/>
```

## Build và chạy

1. Cài đặt JDK 17+, Maven, SQL Server, Tomcat 10+ (bắt buộc Tomcat 10+ vì dùng Jakarta EE namespace `jakarta.*`).
2. Tạo database `QUANNUOC` theo file schema SQL đã cung cấp.
3. Build project:

   ```bash
   mvn clean package
   ```

4. Lấy file `target/quannuoc-jsp.war` và deploy vào thư mục `webapps` của Tomcat (hoặc dùng Tomcat Maven plugin / deploy trong IDE).
5. Truy cập: `http://localhost:8080/quannuoc-jsp/`

## Tài khoản mặc định

Chưa có tài khoản admin mẫu trong DB. Sau khi đăng ký tài khoản đầu tiên qua trang `/dang-ky` (mặc định là khách hàng - `role = 0`), hãy cập nhật thủ công cột `role` của tài khoản đó thành `1` (bit) trực tiếp trong SQL Server để có quyền truy cập trang quản trị `/admin`:

```sql
UPDATE [USER] SET role = 1 WHERE email = 'admin@example.com';
```

## Luồng nghiệp vụ chính

- **Đặt hàng**: Khách chọn đồ uống → chọn size/topping → Thêm vào giỏ (lưu trong session) → Thanh toán → Hệ thống tạo `BILL` + `BILL_DETAIL` + `BILL_DETAIL_TOPPING` + 1 dòng `STATUS_HISTORY` (trạng thái `waiting`) trong 1 transaction.
- **Trạng thái đơn hàng**: `waiting → confirmed → preparing → delivering → completed`, hoặc `cancelled`. Mỗi lần đổi trạng thái ở trang quản trị sẽ thêm 1 dòng mới vào `STATUS_HISTORY`.
- **Phân quyền**: cột `role` (bit) trong bảng `USER`: `0` = khách hàng, `1` = quản trị viên. `AuthFilter` chặn toàn bộ `/admin/*` nếu chưa đăng nhập hoặc không phải admin.
