use 1812816_database_lab03;

/*Đưa ra tên các thành phố và số lượng khách hàng tại từng thành phố.*/
select city, count(customerNumber)from customers group by city ;

/*Lấy ra thông tin thành phố có số lượng khách hàng lớn nhất*/
select city, count(customerNumber)
from customers
group by city
HAVING count(customerNumber) >= ALL 
(select count(customerNumber)from customers group by city);

/*Tìm thành phố của khách hàng có nhiều đơn hàng nhất trong năm 2005.*/
select A.city, count(A.customerNumber)
from customers as A, orders as B
where A.customerNumber=B.customerNumber and year(B.orderDate)='2005'
group by city
having count(A.customerNumber) >= ALL
(select count(A.customerNumber)
from customers as A, orders as B
where A.customerNumber=B.customerNumber and year(B.orderDate)='2005'
group by city);

/*Đưa ra số lượng các đơn đặt hàng trong tháng 5/2003.*/
select count(orderDate)
from orders
where month(orderDate)=5 and year(orderDate)=2003;

/*Liệt kê họ tên khách hàng cùng số lượng các đơn bị hủy của họ trong năm 2003.*/
select B.contactLastName, B.contactFirstName, count(A.status)
from orders A, customers B
where A.customerNumber=B.customerNumber and status='Cancelled' and year(A.requiredDate)=2003
group by B.contactLastName;

/*Liệt kê họ tên khách hàng cùng số lượng các đơn bị hủy của họ trong năm 2003.*/
select month(A.orderDate) as Month, count(A.orderDate),
case when count(A.orderDate) <= All 
(select count(A.orderDate) from orders A
where year(A.orderDate)=2004
group by month(A.orderDate)
) then concat(B.contactLastName,' ', B.contactFirstName)
end 
from orders A, customers B
where year(A.orderDate)=2004 and A.customerNumber=B.customerNumber
group by month(A.orderDate);

/*Liệt kê họ tên khách hàng cùng số lượng các đơn bị hủy của họ trong năm 2003.
*/
select distinct  B.orderNumber, A.buyPrice, sum(B.quantityOrdered) as sumOrdered, (sum(B.quantityOrdered) * A.buyPrice) as Value
from products A, orderdetails B
where A.productLine='Classic Cars' and A.productCode = B.productCode
group by B.orderNumber
having (sum(B.quantityOrdered) * A.buyPrice) >= ALL
(select distinct (sum(B.quantityOrdered) * A.buyPrice)
from products A, orderdetails B
where A.productLine='Classic Cars' and A.productCode = B.productCode
group by B.orderNumber
);

/*Đưa ra mã nhóm hàng, tên nhóm hàng và tổng số lượng hàng hoá còn trong kho của nhóm hàng đó*/
select productCode, productLine, quantityInStock from products;

/*Đưa ra thông tin về các nhân viên và tên văn phòng nơi họ làm việc.*/
select A.*, B.city from employees A, offices B where A.officeCode=B.officeCode;

/*Đưa ra thông tin về tên khách hàng và tên các sản phẩm họ đã mua có chứa chữ “Ford” nhưng không chứa chữ “A”*/
select A.contactFirstName, D.productName
from customers A, orders B, orderdetails C, products D
where A.customerNumber=B.customerNumber and B.orderNumber=C.orderNumber and C.productCode=D.productCode
and B.status='Shipped' and D.productName like'%Ford%' and D.productName not like '%A%';

/*Đưa ra thông tin về các mặt hàng chưa có ai đặt mua trong năm 2005 nhưng có đặt trong năm 2004*/
select C.*
from orders A, orderdetails B, products C
where A.orderNumber=B.orderNumber and B.productCode=C.productCode and not year(A.orderDate)=2005 and year(A.orderDate)=2004;

/*Đưa ra các đơn hàng trong tháng 5/2005 (gồm orderDate, requiredDate, Status) và tổng giá trị của mỗi đơn hàng lớn hơn 10 000 nhưng không vượt quá 50 000*/
select A.orderDate, A.requiredDate, A.status
from orders A, orderdetails B
where A.orderNumber=B.orderNumber and month(A.orderDate)=5 and year(A.orderDate)=2005
and  (B.quantityOrdered*B.priceEach)>10000 and (B.quantityOrdered*B.priceEach)<50000;

/*Đưa ra thông tin về các dòng sản phẩm và số lượng sản phẩm của dòng sản phẩm đó. Sắp xếp theo thứ tự số lượng giảm dần.*/
select A.*, B.quantityInStock
from productlines A, products B
where A.productLine=B.productLine 
order by B.quantityInStock desc;

/*Đưa ra thông tin về các sản phẩm của dòng sản phẩm Motorcycles mà sốký tự trong tên sản phẩm không vượt quá 25*/
select * from products
where productLine='Motorcycles' and char_length(productName)<=25
