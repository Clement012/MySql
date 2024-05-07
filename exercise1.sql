use sys;

Create table Product(
  id int,
  name varchar(255),
  price decimal (10,2),
  description text,
  create_at timestamp default current_timestamp
  );
  
  select * from Product;
  
  insert into Product values ( 1 , 'Laptop', 999.99, 'High-performance laptop with SSD storage.',Current_timestamp);
  insert into Product values( 2 , 'Smartphone', 599.50, '4G smartphone with advanced camera features.',Current_timestamp);
  insert into Product values ( 3 , 'Headphones', 79.99, 'Wireless headphones with noise-canceling technology.',Current_timestamp);
  
  -- Query 
  select * from Product order by name asc;  -- asc
  select max(price) from Product; -- max()
  select count(id) from Product; -- count()
  select lower('laptop') from Product where name like 'laptop';  
  select avg(price) from Product;  -- avg()
  select * from Product order by create_at asc limit 1; -- limit 
  select sum(price) as 'Total Price' from Product; -- sum()
  select min(price) as 'Max Price for Phones' from Product where name like '%Smartphone%' ;  -- min() / case senitive
  select lower(description) as 'Product Description' from Product where description like '%wireless%'; -- lower() and like() ?
  

Create table Sales(
id integer,
product_id integer,
product_name varchar(255),
unit_price decimal(10,2),
quantity_sold integer,
discount_amount decimal(10,2),
tax_rate decimal(5,2), 
shipping_cost decimal(10,2),
handling_fee decimal(10,2)
);

insert into Sales values( 1 , 1 , 'Laptop' , 999.99 , 2 , 0.00, 0.05 , 10.5, 5.25),
				             		( 2 , 2 , 'Smartphone' , 599.5 , 5 , 25.75, 0.075 , 5.75, 3.25),
                        ( 3 , 3 , 'Headphones' , 79.99 , 10 , 5.00, 0.05 , 2.99, 1.50);
                        
select * from Sales;
