CREATE DATABASE BAITAP;

USE BAITAP;

CREATE TABLE KHOA (
    maKhoa VARCHAR(10) PRIMARY KEY,
    tenKhoa VARCHAR(100) NOT NULL
);

-- Chèn dữ liệu mẫu cho bảng KHOA
INSERT INTO KHOA (maKhoa, tenKhoa) VALUES
('K01', 'Anh văn'),
('K02', 'Vật lý'),
('K03', 'Tin học'),
('K04', 'Toán học'),
('K05', 'Khoa học');

CREATE TABLE SINHVIEN (
    maSV VARCHAR(10) PRIMARY KEY,
    hoSV VARCHAR(50) NOT NULL,
    tenSV VARCHAR(50) NOT NULL,
    phai VARCHAR(10) NOT NULL,         -- 'Nam' hoặc 'Nữ'
    ngaySinh DATE NOT NULL,
    noiSinh VARCHAR(100),
    hocBong INT,                       -- Giá trị học bổng
    maKhoa VARCHAR(10),
    FOREIGN KEY (maKhoa) REFERENCES KHOA(maKhoa)
);

-- Chèn dữ liệu mẫu cho bảng SINHVIEN
INSERT INTO SINHVIEN (maSV, hoSV, tenSV, phai, ngaySinh, noiSinh, hocBong, maKhoa) VALUES
('SV001', 'Nguyễn', 'An', 'Nam', '1990-03-15', 'Hà Nội', 600000, 'K01'),
('SV002', 'Trần', 'Bình', 'Nam', '1991-07-20', 'Hồ Chí Minh', 120000, 'K02'),
('SV003', 'Lê', 'Chi', 'Nữ', '1992-02-10', 'Hà Nội', 80000, 'K03'),
('SV004', 'Phạm', 'Dung', 'Nữ', '1990-05-25', 'Đà Nẵng', 50000, 'K04'),
('SV005', 'Hoàng', 'Emi', 'Nữ', '1993-11-30', 'Hà Nội', 200000, 'K05'),
('SV006', 'Bùi', 'Fai', 'Nam', '1990-01-05', 'Hà Nội', 150000, 'K03'),
('SV007', 'Đinh', 'Giang', 'Nam', '1991-12-12', 'Hải Phòng', 300000, 'K01'),
('SV008', 'Ngô', 'Hà', 'Nữ', '1992-02-28', 'Hà Nội', 550000, 'K02'),
('SV009', 'Vũ', 'Ivy', 'Nữ', '1990-03-05', 'Hà Nội', 650000, 'K03'),
('SV010', 'Phan', 'Jack', 'Nam', '1991-06-15', 'Hà Nội', 750000, 'K04');

CREATE TABLE MONHOC (
    maMon VARCHAR(10) PRIMARY KEY,
    tenMon VARCHAR(100) NOT NULL,
    soTiet INT NOT NULL
);

-- Chèn dữ liệu mẫu cho bảng MONHOC
INSERT INTO MONHOC (maMon, tenMon, soTiet) VALUES
('M001', 'Toán cao cấp', 40),
('M002', 'Tin học cơ bản', 35),
('M003', 'Tiếng Anh giao tiếp', 45),
('M004', 'Lý thuyết điện', 30),
('M005', 'Thống kê', 32),
('M006', 'Tâm lý học', 28),
('M007', 'Tài chính doanh nghiệp', 38);

CREATE TABLE KQ (
    maSV VARCHAR(10),
    maMon VARCHAR(10),
    diem FLOAT,
    PRIMARY KEY (maSV, maMon),
    FOREIGN KEY (maSV) REFERENCES SINHVIEN(maSV),
    FOREIGN KEY (maMon) REFERENCES MONHOC(maMon)
);

-- Chèn dữ liệu mẫu cho bảng KQ
INSERT INTO KQ (maSV, maMon, diem) VALUES
('SV001', 'M001', 8.5),
('SV001', 'M003', 7.0),
('SV002', 'M002', 6.5),
('SV002', 'M004', 7.5),
('SV003', 'M002', 8.0),
('SV003', 'M005', 8.5),
('SV004', 'M001', 7.0),
('SV005', 'M003', 9.0),
('SV006', 'M005', 6.0),
('SV007', 'M007', 7.5),
('SV008', 'M003', 8.0),
('SV009', 'M001', 9.0),
('SV009', 'M002', 8.0),
('SV010', 'M004', 7.5),
('SV010', 'M007', 8.5);

-- Bài 1:
SELECT maSV, hoSV, tenSV, hocBong
FROM SINHVIEN
ORDER BY maSV ASC;

-- Bài 2:
SELECT maSV, CONCAT(hoSV, ' ', tenSV) AS HoTen, phai, ngaySinh
FROM SINHVIEN
ORDER BY CASE WHEN phai = 'Nam' THEN 0 ELSE 1 END;
---
-- Bài 3:
SELECT CONCAT(hoSV, ' ', tenSV) AS HoTen, ngaySinh, hocBong
FROM SINHVIEN
ORDER BY ngaySinh ASC, hocBong DESC;

-- Bài 4:
SELECT maMon, tenMon, soTiet
FROM MONHOC
WHERE tenMon LIKE 'T%';

-- Bài 5:
SELECT CONCAT(hoSV, ' ', tenSV) AS HoTen, ngaySinh, phai
FROM SINHVIEN
WHERE tenSV REGEXP '[iI]$';

-- Bài 6:
SELECT maKhoa, tenKhoa
FROM KHOA
WHERE SUBSTRING(tenKhoa, 2, 1) IN ('N', 'n');

-- Bài 7:
SELECT *
FROM SINHVIEN
WHERE hoSV LIKE '%Thị%';

-- Bài 8:
SELECT maSV, CONCAT(hoSV, ' ', tenSV) AS HoTen, maKhoa, hocBong
FROM SINHVIEN
WHERE hocBong > 100000
ORDER BY maKhoa DESC;

-- Bài 9:
SELECT CONCAT(hoSV, ' ', tenSV) AS HoTen, maKhoa, noiSinh, hocBong
FROM SINHVIEN
WHERE hocBong >= 150000
  AND noiSinh = 'Hà Nội';

-- Bài 10:
SELECT s.maSV, s.maKhoa, s.phai
FROM SINHVIEN s
JOIN KHOA k ON s.maKhoa = k.maKhoa
WHERE k.tenKhoa IN ('Anh văn', 'Vật lý');

-- Bài 11:
SELECT maSV, ngaySinh, noiSinh, hocBong
FROM SINHVIEN
WHERE ngaySinh BETWEEN '1991-01-01' AND '1992-06-05';

-- Bài 12:
SELECT maSV, ngaySinh, phai, maKhoa
FROM SINHVIEN
WHERE hocBong BETWEEN 80000 AND 150000;

-- Bài 13:
SELECT maMon, tenMon, soTiet
FROM MONHOC
WHERE soTiet > 30 AND soTiet < 45;

-- Bài 14:
SELECT s.maSV, CONCAT(s.hoSV, ' ', s.tenSV) AS HoTen, k.tenKhoa, s.phai
FROM SINHVIEN s
JOIN KHOA k ON s.maKhoa = k.maKhoa
WHERE s.phai = 'Nam'
  AND k.tenKhoa IN ('Anh văn', 'Tin học');

-- Bài 15:
SELECT *
FROM SINHVIEN
WHERE phai = 'Nữ'
  AND tenSV LIKE '%N%';

-- Bài 16:
SELECT hoSV, tenSV, noiSinh, ngaySinh
FROM SINHVIEN
WHERE noiSinh = 'Hà Nội'
  AND MONTH(ngaySinh) = 2;

-- Bài 17:
SELECT CONCAT(hoSV, ' ', tenSV) AS HoTen,
       TIMESTAMPDIFF(YEAR, ngaySinh, CURDATE()) AS Tuoi,
       hocBong
FROM SINHVIEN
WHERE TIMESTAMPDIFF(YEAR, ngaySinh, CURDATE()) > 20;

-- Bài 18:
SELECT CONCAT(s.hoSV, ' ', s.tenSV) AS HoTen,
       TIMESTAMPDIFF(YEAR, s.ngaySinh, CURDATE()) AS Tuoi,
       k.tenKhoa
FROM SINHVIEN s
JOIN KHOA k ON s.maKhoa = k.maKhoa
WHERE TIMESTAMPDIFF(YEAR, s.ngaySinh, CURDATE()) BETWEEN 20 AND 25;

-- Bài 19:
SELECT CONCAT(hoSV, ' ', tenSV) AS HoTen, phai, ngaySinh
FROM SINHVIEN
WHERE YEAR(ngaySinh) = 1990
  AND MONTH(ngaySinh) IN (3,4,5);

-- Bài 20:
SELECT maSV, phai, maKhoa,
       CASE 
         WHEN hocBong > 500000 THEN 'Học bổng cao'
         ELSE 'Mức trung bình'
       END AS MucHocBong
FROM SINHVIEN;

-- Bài 21:
SELECT COUNT(*) AS TongSoSinhVien
FROM SINHVIEN;

-- Bài 22:
SELECT COUNT(*) AS TongSinhVien,
       SUM(CASE WHEN phai = 'Nữ' THEN 1 ELSE 0 END) AS TongSinhVienNu
FROM SINHVIEN;

-- Bài 23:
SELECT maKhoa, COUNT(*) AS SoLuongSinhVien
FROM SINHVIEN
GROUP BY maKhoa;

-- Bài 24:
SELECT maMon, COUNT(DISTINCT maSV) AS SoLuongSinhVien
FROM KQ
GROUP BY maMon;

-- Bài 25:
SELECT COUNT(DISTINCT maMon) AS TongMonHoc
FROM KQ;

-- Bài 26:
SELECT maKhoa, SUM(hocBong) AS TongHocBong
FROM SINHVIEN
GROUP BY maKhoa;

-- Bài 27:
SELECT maKhoa, MAX(hocBong) AS HocBongCaoNhat
FROM SINHVIEN
GROUP BY maKhoa;

-- Bài 28:
SELECT maKhoa,
       SUM(CASE WHEN phai = 'Nam' THEN 1 ELSE 0 END) AS SoSinhVienNam,
       SUM(CASE WHEN phai = 'Nữ' THEN 1 ELSE 0 END) AS SoSinhVienNu
FROM SINHVIEN
GROUP BY maKhoa;

-- Bài 29:
SELECT TIMESTAMPDIFF(YEAR, ngaySinh, CURDATE()) AS Tuoi,
       COUNT(*) AS SoLuongSinhVien
FROM SINHVIEN
GROUP BY Tuoi;

-- Bài 30:
SELECT YEAR(ngaySinh) AS NamSinh,
       COUNT(*) AS SoLuong
FROM SINHVIEN
GROUP BY NamSinh
HAVING COUNT(*) = 2;
