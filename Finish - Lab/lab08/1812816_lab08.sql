use 1812816_database_lab03;
/*1. Sinh viên sử dụng lại cơ sở dữ liệu đã tạo ở trong Lab số 2. Sử dụng Stored 
Procedure để thực thi các yêu cầu sau:*/

/*a. Lấy danh sách các khách hàng theo FirstName*/
DELIMITER $$
CREATE PROCEDURE GetAllCustomers()
BEGIN
select contactFirstName from customers;
END; $$
DELIMITER ;
call GetAllCustomers();
/*b. Đổi tên nhân viên có lastName “Vanauf” thành “Trump”*/
DELIMITER $$
CREATE PROCEDURE ConvertEmployee()
BEGIN
SELECT
(case  when lastName = 'Vanauf' then 'Trump'
else lastName
end) lastName
FROM employees;
END; $$
DELIMITER ;
call ConvertEmployee();

/*c. Kiểm tra trạng thái của các khách hàng đã đặt hàng trong năm 2004*/
DELIMITER $$
CREATE PROCEDURE StatusCustomerOrdered2004()
BEGIN
select B.status, A.* from customers A, orders B
where A.customerNumber=B.customerNumber and year(orderDate) = 2004;
END; $$
DELIMITER ;
call StatusCustomerOrdered2004();

/*d. Lấy ra danh sách các khách hàng dựa theo tên của nhân viên phụ trách*/
DELIMITER $$
CREATE PROCEDURE ListCustomerByNameEmployee(In firstNameVal varchar(50))
BEGIN
select B.firstName, A.* from customers A, employees B
where A.salesRepEmployeeNumber = B.employeeNumber and B.firstName=firstNameVal;
END; $$
DELIMITER ;
call ListCustomerByNameEmployee('Andy');

/*e. Lấy thông tin các khách hàng mà đơn hàng đã bị hủy*/
DELIMITER $$
CREATE PROCEDURE InformationCustomerOrderedCancelled()
BEGIN
select A.* from customers A, orders B
where A.customerNumber = B.customerNumber and B.status = 'Cancelled';
END; $$
DELIMITER ;
call InformationCustomerOrderedCancelled();

/*f. Lấy thông tin phòng ban nhân viên dựa vào mã employeeNumber*/
DELIMITER $$
CREATE PROCEDURE InformationByEmployeeNumber(In employeeNumberVal int)
BEGIN
select distinct A.* from offices A, employees B
where A.officeCode = B.officeCode and B.employeeNumber=employeeNumberVal;
END; $$
DELIMITER ;
call InformationByEmployeeNumber(1002);

/*g. Liệt kê các sản phẩm của một dòng sản phẩm*/
DELIMITER $$
CREATE PROCEDURE ListProductByProductLine(In productLineVal varchar(50))
BEGIN
select A.productName, A.productLine from products A, productLines B
where A.productLine = B.productLine and B.productLine=productLineVal;
END; $$
DELIMITER ;
call ListProductByProductLine('Classic Cars');

/*h. Lấy ra các nhân viên của employeeNumber của nhân viên quản lý*/
DELIMITER $$
CREATE PROCEDURE EmployeeByManager()
BEGIN
select * from employees
where jobTitle like '%Manager%';
END; $$
DELIMITER ;
call EmployeeByManager();

/*i. Đổi tên các dòng sản phẩm theo yêu cầu sau: (Yêu cầu sử dụng IF)
• Classic Cars => Xe cổ
• Motorcycles => Xe Mô tô
• Planes => Máy bay
• Ships => Tàu Thủy
• Trains => Tàu Hỏa
• Trucks and Buses => Xe Tải và Buýt
• Vintage Cars = > Xe cũ*/
DELIMITER $$
CREATE PROCEDURE ConvertProductLine()
BEGIN
select
if(productLine='Classic Cars','Xe cổ',
if(productLine='Motorcycles', 'Xe Mô tô',
if(productLine='Planes', 'Máy bay',
if(productLine='Ships', 'Tàu Thủy',
if(productLine='Trains', 'Tàu Hỏa',
if(productLine='Trucks and Buses', 'Xe Tải và Buýt','Xe cũ'
)))))) as productLine
from productlines;
END$$
DELIMITER ;
call ConvertProductLine();
/*j. Như yêu cầu trong câu h nhưng sử dụng CASE Lấy ra các nhân viên của employeeNumber của nhân viên quản lý*/
DELIMITER $$
CREATE PROCEDURE EmployeeByManagerUsedCase()
BEGIN
select
(case  when jobTitle like '%Manager%' then employeeNumber
end) lastName
from employees;
END; $$
DELIMITER ;
call EmployeeByManagerUsedCase();

/*k. Lấy ra dòng sản phẩm dựa theo tên của một sản phẩm*/
DELIMITER $$
CREATE PROCEDURE ProductLineAboveproductName(In productNameVal varchar(50))
BEGIN
select productLine from products
where productName=productNameVal;
END; $$
DELIMITER ;
call ProductLineAboveproductName('2002 Suzuki XREO');

/*l. Sử dụng vòng lặp liệt kê các sản phẩm thuộc dòng Xe cũ có giá mua thấp 
hơn 50*/
DELIMITER $$
CREATE PROCEDURE listProductVintageCars50()
BEGIN

END; $$
DELIMITER ;
call listProductVintageCars50();
DROP PROCEDURE IF EXISTS listProductVintageCars50;

/*2. Viết Trigger thực hiện các yêu cầu sau:*/
/*a. Nhắc nhở khi quên nhập email lúc thêm dữ liệu vào bảng Nhân viên*/
DELIMITER $$
CREATE TRIGGER before_employee_insert
BEFORE INSERT
ON employees FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = concat('Chua nhap dia chi email ', new.lastName,' ', new.firstName);

    IF NEW.email IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END$$
DELIMITER ;
insert into employees(employeeNumber, lastName, firstName) value(2000,'Hoang Thi Hong','Nhung');

/*b. Thông báo lỗi không cho phép sửa tên của các dòng sản phẩm*/
DELIMITER $$ 
CREATE TRIGGER before_products_update
BEFORE UPDATE
ON products FOR EACH ROW
BEGIN
    DECLARE errorMessage VARCHAR(255);
    SET errorMessage = 'Khong cho phep sua ten productLine';
                         
    IF new.productLine not like old.productLine THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = errorMessage;
    END IF;
END $$
DELIMITER ;

UPDATE products 
SET productLine = 'Cars'
where productCode='S10_1678';
/*c. Lưu lại thông tin các bảng khi thực hiện thao tác xóa.*/
CREATE TABLE `productsArchives` (
  `productCode` varchar(15) NOT NULL,
  `productName` varchar(70) NOT NULL,
  `productLine` varchar(50) NOT NULL,
  `productScale` varchar(10) NOT NULL,
  `productVendor` varchar(50) NOT NULL,
  `productDescription` text NOT NULL,
  `quantityInStock` smallint(6) NOT NULL,
  `buyPrice` decimal(10,2) NOT NULL,
  `MSRP` decimal(10,2) NOT NULL,
  PRIMARY KEY (`productCode`),
  KEY `productLine` (`productLine`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$
CREATE TRIGGER before_products_delete
BEFORE DELETE
on products FOR EACH ROW
BEGIN
    INSERT INTO productsArchives(productCode,productName,productLine,productScale,productVendor,productDescription, quantityInStock, buyPrice, MSRP)
    VALUES(OLD.productCode,OLD.productName,OLD.productLine,OLD.productScale,old.productVendor,old.productDescription,old.quantityInStock,old.buyPrice,old.MSRP);
END$$    
DELIMITER ;
delete from products;
select * from productsArchives;
