create database 1812816_MySQL;
use 1812816_MySQL;

create table orders(
orderNumber int(11) auto_increment primary key not null,
orderDate datetime not null,
requiredDate datetime not null,
shippedDate datetime,
status varchar(15) not null,
comments text,
customerNumber int(11) not null);

create table productlines(
productLine varchar(50) not null primary key,
textDescription varchar(4000),
htmlDescription mediumtext,
image mediumblob);

create table products(
productCode varchar(15) not null primary key,
productName varchar(70) not null,
productLine varchar(50) not null,
productScale varchar(10) not null,
productVendor varchar(50) not null,
productDescription text not null,
quantityInStock smallint(6) not null,
buyPrice double not null,
foreign key (productLine) references productlines(productLine) on update cascade);

create table orderdetails(
orderNumber int(11) auto_increment not null,
productCode varchar(15) not null,
quantityOrdered int(11) not null,
priceEach double not null,
orderLineNumber smallint(6) not null,
primary key(orderNumber, productCode),
foreign key(orderNumber) references orders(orderNumber) on update cascade,
foreign key(productCode) references products(productCode) on update cascade);

select * from orders;
select * from products;
select * from productlines;
select * from orderdetails;

alter table orderdetails modify column orderLineNumber int(10);
alter table products rename column productLine to Branch;

insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-07-25','2021-07-28','2021-07-28','Chờ xác nhận','Đóng gói cẩn thận',162659);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-05-07','2021-07-10','2021-07-09','Đã xác nhận','Chốt đơn',833616);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-08-30','2021-09-05','2021-09-05','Đã xác nhận','Chốt đơn',487602);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-08-02','2021-08-30','2021-08-26','Đã xác nhận','Chốt đơn',324561);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-07-15','2021-07-25','2021-07-24','Chờ xác nhận','Đóng gói cẩn thận',590601);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-09-02','2021-09-05','2021-09-02','Chờ xác nhận','Đóng gói cẩn thận',697272);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-08-06','2021-08-17','2021-08-16','Đã xác nhận','Chốt đơn',782662);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-07-12','2021-07-13','2021-07-10','Đã xác nhận','Chốt đơn',734265);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-07-22','2021-07-28','2021-07-28','Đã xác nhận','Chốt đơn',866047);
insert into orders(orderDate, requiredDate, shippedDate, status, comments, customerNumber) value ('2021-08-26','2021-08-28','2021-08-25','Chờ xác nhận','Đóng gói cẩn thận',407570);

insert into productlines value('OMO','thương hiệu nổi tiếng nhất trong ngành hóa mỹ phẩm.','42','https://icolor.vn/wp-content/uploads/2021/03/B%E1%BB%99-nh%E1%BA%ADn-di%E1%BB%87n-th%C6%B0%C6%A1ng-hi%E1%BB%87u-v%C3%A0-logo-OMO-4.jpg');
insert into productlines value('P/S','Sản phẩm được làm từ những thành phần có nguồn gốc từ thiên nhiên, an toàn cho sức khỏe','83','https://icolor.vn/wp-content/uploads/2021/03/B%E1%BB%99-nh%E1%BA%ADn-di%E1%BB%87n-th%C6%B0%C6%A1ng-hi%E1%BB%87u-v%C3%A0-logo-OMO-4.jpg');
insert into productlines value('LIFEBOUY','Xà phòng khử trùng hoàng gia','91','https://icolor.vn/wp-content/uploads/2021/03/B%E1%BB%99-nh%E1%BA%ADn-di%E1%BB%87n-th%C6%B0%C6%A1ng-hi%E1%BB%87u-v%C3%A0-logo-OMO-4.jpg');
insert into productlines value('SUNSILK','là sản phẩm chiến lược của tập đoàn này trong lĩnh vực chăm sóc tóc','66','https://www.sunsilk.com.vn/content/dam/unilever/sunsilk/vietnam/logo/brand/hair_care/not_applicable/vietnam_sunsilk-772658.png.ulenscale.70x70.png');
insert into productlines value('CLEAR','giải pháp công nghệ cao trị gàu và các vấn đề của da đầu khác như ngứa, khô và bết dầu.','24','https://www.unilever.com.vn/Images/Clear_tcm1309-498353.jpg');
insert into productlines value('SUNLIGHT','người bạn đồng hành không thể thiếu trong mọi căn bếp của gia đình Việt','26','https://icolor.vn/wp-content/uploads/2021/03/B%E1%BB%99-nh%E1%BA%ADn-di%E1%BB%87n-th%C6%B0%C6%A1ng-hi%E1%BB%87u-v%C3%A0-logo-OMO-4.jpg');
insert into productlines value('DOVE','sản phẩm Chăm sóc tóc hư tổn số 1 được người tiêu dùng lựa chọn','12','https://www.unilever.com.vn/Images/dove_tcm1309-408752.png');
insert into productlines value('KNORR','sản phẩm có tác động tích cực tới sức khỏe và chế độ dinh dưỡng của người tiêu dùng','54','https://www.unilever.com.vn/Images/knorr_tcm1309-408767.png');
insert into productlines value('VIM',' cung cấp giải pháp diệt khuẩn tối ưu trong bồn cầu và phòng tắm','52','https://www.unilever.com.vn/Images/vim_tcm1309-408801.gif');
insert into productlines value('COMFORT','nước xả vải sau khi giặt quần áo có tác dụng làm mềm vải và lưu lại hương thơm cho quần áo','11','https://www.unilever.com.vn/Images/comfort_tcm1309-408749.png');

insert into products value('888593667741901','Dầu gội Clear thảo cược 900mlUnisex','CLEAR','Vừa','Unilerver Việt Nam','Dầu gội sạch gầu số 1 Việt Nam',3175,165.000);
insert into products value('936176933197190','Kem đánh răng Closeup Lửa Băng','P/S','Lớn','Unilerver Việt Nam','Dạng gel 2 màu độc đáo',5354,35.000);
insert into products value('525714781073438','Nước rửa chén Sunlight Chanh Túi 750g','SUNLIGHT','Lờn','Unilerver Việt Nam','Trọng lượng 750g, đóng gói túi',2146,22.000);
insert into products value('934819032256049','Hạt nêm Knorr thịt thăn và xương ống tuỷ ( 400g)','KNORR','Vừa','Unilerver Việt Nam','Hạt nêm Knorr Mỹ vị không có hóa chất',5790,17.000);
insert into products value('116422648411651','Dầu gội Clear mát lạnh bạc hà 170g','CLEAR','Vừa','Unilerver Việt Nam','Dầu gội sạch gầu số 1 Việt Nam',6851,55.000);
insert into products value('654680173476744','Nước lau sàn Sunlight hương hoa hạ dạng chai 1kg','SUNLIGHT','Nhỏ','Unilerver Việt Nam','Sản phẩm không chứa chất tạo bọt, phẩm màu',5079,15.000);
insert into products value('366094635422236','Nước xả Comfort cho da nhạy cảm 800ml','COMFORT','Vừa','Unilerver Việt Nam','Làm mềm vải. Giúp vải không bị khô cứng và dễ ủi. Hương thơm lưu lại lâu',1136,20.000);
insert into products value('222095427429455','Túi nước giặt Omo Matic cửa trên 3.1kg','OMO','Nhỏ','Unilerver Việt Nam','Giặt sạch mọi vết bẩn cứng đầu',8943,150.000);
insert into products value('568092064906058','Nước vệ sinh nhà cửa VIM đa năng 980ml','VIM','Lớn','Unilerver Việt Nam','Diệt 99.9% vi khuẩn',1015,33.000);
insert into products value('741261337544588','Xà bông cục Lifebouy 90g ','LIFEBOUY','Nhỏ','Unilerver Việt Nam','Bảo vệ da mềm mại khỏe mạnh và mịn màng',1673,11.000);

insert into orderdetails value(1,'888593667741901',5664,165.000,164);
insert into orderdetails value(7,'222095427429455',6611,150.000,241);
insert into orderdetails value(3,'525714781073438',7689,22.000,954);
insert into orderdetails value(4,'888593667741901',7163,165.000,381);
insert into orderdetails value(5,'116422648411651',6575,55.000,318);
insert into orderdetails value(9,'654680173476744',7128,15.000,278);
insert into orderdetails value(7,'366094635422236',6898,20.000,970);
insert into orderdetails value(8,'222095427429455',1593,150.000,522);
insert into orderdetails value(9,'568092064906058',4955,33.000,725);
insert into orderdetails value('10','888593667741901','7665','165.000','132');

drop table products;
/*Lỗi vì: thuộc tính on update cascade trong bảng products sẽ cập nhập cột productCode trong bảng orderdetails khi cột productCode trong bảng products được cập nhập -> xóa bảng products thì dữ liệu trong cột productCode của bảng orderdetails sẽ null mà cột productCode của bảng orderdetails có giá trị not null -> không thể xóa được bảng products

