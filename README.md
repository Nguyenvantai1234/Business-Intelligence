
# Đồ án: Xây dựng Giải pháp Business Intelligence cho Module Mua hàng (Purchasing) của Công ty AdventureWorks Cycles

## Tổng quan dự án

Dự án này trình bày việc thiết kế và triển khai một giải pháp Business Intelligence (BI) hoàn chỉnh, tập trung vào Module Mua hàng (Purchasing Module) dựa trên cơ sở dữ liệu AdventureWorks.

Sử dụng hệ sinh thái BI của Microsoft, nhóm đã phát triển một kho dữ liệu (data warehouse) để hợp lý hóa quy trình trích xuất, chuyển đổi và tải (ETL) dữ liệu mua hàng. Giải pháp bao gồm một khối đa chiều (multidimensional cube) cho phân tích nâng cao và các bảng điều khiển (dashboards) trực quan cung cấp thông tin chi tiết về hiệu suất của nhà cung cấp, xu hướng mua hàng và các chỉ số mua hàng chính.

Mục tiêu của hệ thống là hỗ trợ ra quyết định dựa trên dữ liệu và tăng cường khả năng hiển thị hoạt động trong quy trình mua hàng[cite: 2431].

## Mục tiêu chính

* Phân tích quy trình nghiệp vụ mua hàng và phát triển hệ thống KPI để đánh giá hiệu suất[cite: 1994].
* Đề xuất và thiết kế mô hình kho dữ liệu (data warehouse) phù hợp với các yêu cầu nghiệp vụ[cite: 1995].
* Thực hiện quy trình ETL (Extract, Transform, Load) để tích hợp dữ liệu nguồn vào kho dữ liệu[cite: 1997].
* Áp dụng công nghệ SSAS (SQL Server Analysis Services) để xây dựng khối (cube) và chuyển đổi dữ liệu thô thành thông tin chi tiết có ý nghĩa[cite: 1998].
* Sử dụng ngôn ngữ MDX (Multidimensional Expressions) để truy vấn dữ liệu từ khối OLAP[cite: 1999].
* Xây dựng hệ thống báo cáo và trực quan hóa dữ liệu bằng Power BI, cung cấp cái nhìn tổng quan về tình hình tồn kho và xu hướng mua hàng[cite: 2000].

## Công nghệ sử dụng

* **SQL Server Management Studio (SSMS):** Dùng để quản lý và truy vấn cơ sở dữ liệu.
* **SQL Server Integration Services (SSIS):** Dùng cho quy trình ETL, trích xuất và chuyển đổi dữ liệu.
* **SQL Server Analysis Services (SSAS):** Dùng để xây dựng khối dữ liệu đa chiều (OLAP Cube).
* **Power BI:** Dùng để trực quan hóa dữ liệu và xây dựng dashboards.
---
