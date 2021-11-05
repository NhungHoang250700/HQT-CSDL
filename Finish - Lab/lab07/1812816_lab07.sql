use 1812816_database_lab03;
/*a. Tìm những nhân viên có tên là “Tom”.*/
alter table employees
add fulltext(firstName);
select * from employees where match(firstName) against('Tom');
/*b. Tìm các sản phẩm có chứa từ “Suzuki”*/
alter table products
add fulltext(productName);
select * from products where match(productName) against('Suzuki');

/*c. Tìm các sản phẩm có chứa cả hai từ “1985” và “Supra”*/
select * from products where match(productName) against('+1985 +Supra' in boolean mode);

/*d. Tìm các có chứa từ “Ford” nhưng không có từ “truck”*/
select * from products where match(productName) against('+Ford -truck' in boolean mode);

/*e. Tìm khách hàng có tên bắt đầu bằng từ “Au”*/
alter table customers
add fulltext(customerName);
select * from customers where match(customerName) against('Au*'in boolean mode);

/*f. Tìm các sản phẩm có chứa “1999” đồng thời với các sản phẩm có từ“Yamaha” thì kết quả trả về trước tiên.*/
select * from products where match(productName) against('+1999 Yamaha' in boolean mode);

/*g. Tìm các khách hàng mà địa chỉ có từ “Street” nhưng không có từ “North”, hơn nữa với địa chỉ có từ “Allen” thì xếp hàng thấp hơn*/
alter table customers
add fulltext(addressLine1);
select * from customers where match(addressLine1) against('+Street -North ~Allen'in boolean mode);

/*h. Tìm các sản phẩm có các từ “Ford truck” và “Ford Phaeton”, ưu tiên trảvề kết quả với “Ford truck” lên trước tiên.*/
select * from products where match(productName) against('+Ford +(>truck <Phaeton)' in boolean mode);

/*i. Tìm các nhân viên không có tên là “Bow”. Kết quả trả về thì ưu tiên trả vềcác nhân viên thuộc bộ phận Sale lên trước tiên.*/
alter table employees
add fulltext(firstName,jobTitle);
select * from employees where match(firstName,jobTitle) against('+Bow Sale'with query expansion);

/*j. Tìm các sản phẩm có ít nhất hai từ “1969” hoặc “Dodge”, nhưng không có từ “Chevrolet”*/
select * from products where match(productName) against('+(+1969 0Dodge) -Chevrolet' in boolean mode);

/*k. Tìm các khách hàng có chứ từ “Mini” và đặt thứ hạng thấp hơn cho các hàng có từ “Marseille” hay từ “Caravy”*/
select * from customers where match(customerName) against('+Mini 0(~Marseille ~Caravy)'in boolean mode);
