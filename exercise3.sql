create database bootcamp_exercise3;

use bootcamp_exercise3;

create table customer(
 id integer primary key,
 customer_name varchar(255),
 city_id integer , -- FK?
 customer_address varchar(255),
 contact_person varchar(255) null,
 email varchar(128),
 phone varchar(128)
 );

 create table product(
 id integer primary key,
 sku varchar(32),
 product_name varchar(128),
 product_description text,
 current_price decimal(8,2),
 quantity_in_stock integer
 );
 
 create table invoice(
 id integer primary key,
 invoice_number varchar(255),
 customer_id integer,
 constraint FKCustomer_id foreign key (customer_id) references customer(id) ,  
 user_account_id integer,
 total_price decimal(8,2),
 time_issued varchar(0),
 time_due varchar(0),
 time_paid varchar(0),
 time_canceled varchar(0),
 time_refunded varchar(0) 
 );
 
 create table invoice_item(
 id integer primary key,
 invoice_id integer,
 constraint FKinvoice_id foreign key (invoice_id) references invoice(id),
 product_id integer,
 constraint FKproduct_id foreign key (product_id) references product(id), 
 quantity integer,
 price decimal(8,2),
 line_total_price decimal(8,2)
 );
 
 
INSERT INTO CUSTOMER VALUES
(1, 'Drogerie Wien', 1, 'Deckergasse 15A', 'Emil Steinbach', 'abc@gmail.com', 123455678);
INSERT INTO CUSTOMER VALUES
(2, 'John', 4, 'Deckergasse 1A', '9upper', 'abck@gmail.com', 12345567);
INSERT INTO CUSTOMER VALUES
(3, 'Mary', 8, 'Deckergasse 18A', '9upper', 'abcd@gmail.com', 1234556789);

INSERT INTO PRODUCT VALUES
(1, '330120', '9UP PRODUCT', 'COMPLETELY 9UP', 60, 122);
INSERT INTO PRODUCT VALUES
(2, '330121', '9UPPER PRODUCT', 'COMPLETELY 9UPPER', 50, 50);
INSERT INTO PRODUCT VALUES
(3, '330122', '9UPPER PRODUCTS', 'SUPER 9UPPER', 40, 600);
INSERT INTO PRODUCT VALUES
(4, '330123', '9UPPER PRODUCTSS', 'SUPER COMPLETELY 9UPPER', 30, 500);

INSERT INTO INVOICE VALUES
(1, 123456780, 2, 41, 1423, NULL, NULL, NULL, NULL, NULL);
INSERT INTO INVOICE VALUES
(2, 123456780, 3, 42, 1400, NULL, NULL, NULL, NULL, NULL);
INSERT INTO INVOICE VALUES
(3, 123456780, 2, 43, 17000, NULL, NULL, NULL, NULL, NULL);

INSERT INTO INVOICE_ITEM VALUES
(1, 1, 1, 40, 23, 920);
INSERT INTO INVOICE_ITEM VALUES
(2, 1, 2, 4, 20, 80);
INSERT INTO INVOICE_ITEM VALUES
(3, 1, 3, 4, 10, 40);
INSERT INTO INVOICE_ITEM VALUES
(4, 1, 2, 4, 30, 120);

select * from customer;
select * from product;
select * from invoice;
select * from invoice_item;

-- using union operator,in one list return  all customers without an invoice and all products that were not sold
-- for each customers without an invoice,return:  
-- the string customer
-- the customer id 
-- the customer_name

-- for each product without an invoice ,return:
-- the string product
-- the product id
-- the product_name

SELECT 'Customer' AS Type, c.id, c.customer_name as name
FROM customer c
LEFT JOIN invoice i ON c.id = i.customer_id
WHERE i.id IS NULL
UNION
SELECT 'Product' AS Type, p.id, p.product_name as name
FROM product p
LEFT JOIN invoice_item ii ON p.id = ii.product_id
WHERE ii.id IS NULL;

--

create table employee(
id integer not null auto_increment primary key,
empolyee_name varchar (30) not null,
salary numeric(8,2),
phone numeric(15),
email varchar(50),
dept_id integer not null
);

create table department(
id integer not null auto_increment primary key,
dept_code varchar(3) not null,
dept_name varchar(200) not null
);

insert into employee values(1,'JOHN',20000,90234567,'John@gmail.com',1);
insert into employee values(2,'MARY',10000,90234561,'Mary@gmail.com',1);
insert into employee values(3,'STEVE',30000,90234562,'Steve@gmail.com',3);
insert into employee values(4,'SUNNY',40000,90234563,'Sunny@gmail.com',4);

insert into department values(1, 'HR' , 'Human Resources');
insert into department values(2, '9UP' , '9UP Department');
insert into department values(3, 'SA' , 'Sales Department');
insert into department values(4, 'IT' , 'Information Technology Department');

select * from employee;  
select * from department;
select d.dept_code as Department_Code, count(e.dept_id) as Number_of_Employees
from department d left join employee e on d.id = e.dept_id 
group by d.dept_code
order by case 
when d.dept_code = '9UP' 
then 1 else 0 
end ,
d.dept_code asc;  

insert into department values(5, 'IT' , 'Information Technology Department');
