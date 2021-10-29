use 1812816_database_lab03;
/*Lấy ra các sản phẩm có đơn đặt hàng trong tháng 5/2003.*/
select A.*
from products A, orderdetails B, orders C
where A.productCode=B.productCode and B.orderNumber=C.orderNumber and month(C.orderDate)=5 and year(C.orderDate)=2003;
/*Đưa ra các thông tin về các đơn hàng trong các tháng của năm 2005*/
select month(B.orderDate) Month, A.*
from orderdetails A, orders B
where A.orderNumber=B.orderNumber and year(B.orderDate)=2005;

/*Đưa ra thông tin về các đơn hàng và tổng giá trị đơn hàng*/
select A.*, B.*, (A.quantityOrdered * A.priceEach) SumValue
from orderdetails A, orders B
where A.orderNumber=B.orderNumber;

/*Đưa ra thông tin về đơn hàng có tổng giá trị đơn hàng nhỏ nhất*/
select A.*, B.*, (A.quantityOrdered * A.priceEach) SumValue
from orderdetails A, orders B
where A.orderNumber=B.orderNumber
order by Sumvalue asc limit 1;


/*Với mỗi khách hàng, đưa ra tổng số hàng, và tổng số tiền họ đã thanh toán*/
select A.customerNumber, sum(D.quantityOrdered), sum(C.amount)
from customers A, orders B, payments C, orderdetails D
where A.customerNumber=B.customerNumber and A.customerNumber=C.customerNumber and B.orderNumber=D.orderNumber
group by A.customerNumber;
/*Liệt kê họ tên khách hàng cùng số lượng các đơn bị hủy của họ trong năm 2003.*/
select A.contactLastName, A.contactFirstName, count(B.status)
from customers A, orders B
where A.customerNumber=B.customerNumber and B.status like 'Cancelled' and year(B.orderDate)=2003
group by A.contactLastName;
/*Đưa ra các mã đơn đặt hàng có giá trị lớn nhất không thuộc dòng sản phẩm “Classic Cars”.*/
select a.orderNumber, (A.quantityOrdered * A.priceEach) SumValue
from orderdetails A, products B
where A.productCode=B.productCode and B.productLine not like 'Classic Cars'
order by SumValue desc limit 1;
/*Đưa ra mã nhóm hàng, tên nhóm hàng và tổng số lượng hàng hoá còn trong kho của nhóm hàng đó.*/
select A.productLine,B.productCode, sum(B.quantityInStock)
from productlines A, products B
where A.productLine=B.productLine
group by A.productLine;

/*Đưa ra thông tin về các nhân viên và tên văn phòng nơi họ làm việc.*/
select A.*, B.*
from employees A, offices B
where A.officeCode=B.officeCode;

/*Đưa ra thông tin về tên khách hàng và tên các sản phẩm họ đã mua không có chứa chữ “Ford” nhưng có chứa chữ “A”.*/
select A.contactFirstName, D.productName
from customers A, orders B, orderdetails C, products D
where A.customerNumber=B.customerNumber and B.orderNumber=C.orderNumber and C.productCode=D.productCode and B.status='Shipped' and D.productName not like '%Ford%' and D.productName like'%A%';

/*Đưa ra thông tin về các mặt hàng có ít nhất một người đặt mua trong năm 2005 nhưng không mua trong năm 2004.*/
select distinct C.*
from orders A, orderdetails B, products C
where A.orderNumber=B.orderNumber and B.productCode=C.productCode and year(A.orderDate)=2005 and not year(A.orderDate)=2004;

/*Đưa ra thông tin về các đơn hàng trong tháng 3/2005 và tổng giá trị của mỗi đơn hàng lớn hơn 10 000 nhưng không vượt quá 40 000.*/
select A.orderDate, A.requiredDate, A.status
from orders A, orderdetails B
where A.orderNumber=B.orderNumber and month(A.orderDate)=3 and year(A.orderDate)=2005 and (B.quantityOrdered * B.priceEach) >10000 and (B.quantityOrdered * B.priceEach) <40000;

/*Đưa ra thông tin về các dòng sản phẩm và các sản phẩm của từng dòng sản phẩm đó. Sắp xếp giảm dần theo thứ tự abc.*/
select A.*, B.*
from productlines A, products B
where A.productLine=B.productLine
order by A.productLine asc;
/*Đưa ra thông tin về các sản phẩm không thuộc dòng sản phẩm Motorcyclesb mà số ký tự trong tên sản phẩm không vượt quá 25*/
select *
from products
where productLine not like 'Motorcycles' and char_length(productName)<=25;

