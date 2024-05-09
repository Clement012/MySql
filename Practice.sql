use sys;

create table Customer(
   customerID int
);

select * from Customer;

alter table Customer add name varchar(30);
alter table Customer add customer_Order varchar(1000);
alter table Customer drop customer_order;
alter table Customer add order_Price decimal(5,2);
alter table Customer drop order_Price;
alter table Customer add quantities int;

insert into Customer (CustomerID ,quantities , order_price) values ( 001 , 16 , 19.8); 
insert into Customer (CustomerID ,quantities , order_price , name) values ( 002, 30 , 302.7 , 'Elsa');
insert into Customer (CustomerID ,quantities , order_price , name) values ( 003, 60 , 100.1, 'Amoy');
insert into Customer (CustomerID ,quantities , order_price , name) values ( 004, 30 , 12.7 , 'Tommy');
insert into Customer (CustomerID ,quantities , order_price , name) values ( 005, 60 , 102.4 , 'Right');
insert into Customer (CustomerID ,quantities , order_price , name) values ( 006, 40 , 89.0 , 'Left');
insert into Customer (CustomerID ,quantities , order_price , name) values ( 007, 50 , 43.5 , 'Key');
insert into Customer (CustomerID ,quantities , order_price , name) values ( 008, 70 , 125.9 , 'Hello');

select distinct CustomerID from Customer;
update Customer set order_price = 140 where order_price >= 140;

alter table Customer add create_date date;

select round(quantities * order_price,2) as total_price , name from Customer;
-- select * from Customer order by total_price asc; //select don't create new column
