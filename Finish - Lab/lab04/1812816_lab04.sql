use 1812816_database_lab03;
select left(productDescription,20) from products;
select concat(lastName, ' ', firstName) as FullName, jobTitle from employees;
select customerName, contactLastName, concat_ws('',addressLine1,' - ',city,' *** ',state,' --- ',country)address from customers;
select replace(lower(productlines.productLine),'cars','Xe hoi')from productlines;
select if(A.reportsTo is not null, (select concat(B.lastName,' ', B.firstName)from employees as B where A.reportsTo=B.employeeNumber),'No') as ManagerName,A.* from employees as A;
select if(A.salesRepEmployeeNumber is null,'Chua co',(select concat(B.lastName,' ',B.firstName) from employees as B where B.employeeNumber=A.salesRepEmployeeNumber)) as EmployeeFullName,A.customerName,A.salesRepEmployeeNumber from customers as A;
select sum(if(A.country='France',1,0))as LiveatFrance from customers as A;
select sum(if(A.addressLine2 is null,1,0))as NotAddressLine2 from customers as A;
select count(shippedDate) from orders where shippedDate <= subdate('2005-05-17', interval 2 month);
select *,(date(requiredDate)-date(shippedDate))as SoonShipped from orders where (date(requiredDate)-date(shippedDate))>0 order by SoonShipped desc limit 5;
select * from orders where orderDate > subdate('2005-3-2', interval 1 month);
select * from orders where orderDate < subdate('2005-4-1', interval 2 week);
select * from orders where month(orderDate)=4 and year(orderDate)=2005 and shippedDate is null;
select distinct concat(B.contactLastName, ' ',B.contactFirstName) as Full_name
from orders A, customers B
where A.customerNumber=B.customerNumber and A.status = 'Cancelled' and shippedDate > subdate('2004-5-8', interval 8 month);
