use sys;

create table customer2 (
	id integer,
	first_name varchar(20),
    last_name varchar(20),
	phone varchar(50),
    email varchar(50)
);

insert into customer2 values (1, 'Vincent', 'Lau', '852 12345678', 'vincent@gmail.com'),
							 (2, 'Oscar', 'Lo', '852 87654321', 'oscar@gmail.com');

insert into customer2 values (3, 'Jenny', 'Lau', ' 852 43121234 ', 'vincent@gmail.com');
                             
select concat(first_name, ' ', last_name) as full_name from customer2;
select substring(last_name, 1, 1) as first_character from customer2;
select length(first_name), length(last_name) from customer2;

select c.*, length(trim(c.phone)), length(c.phone) from customer2 c;

select replace(concat(first_name,' ', last_name), 'Lau', 'Chan') new_name from customer2;

select left(first_name, 2), right(first_name, 2) from customer2;

select concat_ws(' ', first_name, last_name), concat(first_name, ' ', last_name) as full_name from customer2;

insert into customer2 values (4, 'Thomas', '陳', ' 852 43121234 ', 'thomas@gmail.com');
select c.* , length(last_name), char_length(last_name) from customer2 c;

-- indexOf
select c.*, instr(c.first_name, 'i') from customer2 c;
select c.*, instr(c.first_name, 'in') from customer2 c;
select c.*, instr(c.first_name, 'Jenny') from customer2 c;
select c.*, instr(c.first_name, 'n') from customer2 c;
select c.*, instr(c.first_name, 'x') from customer2 c;

-- MYSQL case insensitive (product specific feature)
select * from customer2 where last_name = 'Lau';
select * from customer2 where last_name = 'lau';
select * from customer2 where last_name = 'LAU';

-- correct way
select * from customer2 where upper(last_name) = 'LAU';
select * from customer2 where lower(last_name) = 'lau';

-- Like % (zero or more character), _ (single character)
select * from customer2 where first_name like '%ncent'; -- OK
select * from customer2 where first_name like '_ncent'; -- NOT FOUND
select * from customer2 where first_name like '_incent'; -- OK
select * from customer2 where first_name like '_incen%'; -- OK

select ceil(4.3) from dual; -- 5
select ceil(4.33333) from dual; -- 5
select floor(4.3) from dual; -- 4
select floor(4.33333) from dual; -- 4
select round(4.353, 1), round(4.353, 2) from dual;
select abs(-5), abs(5) from dual;
select power(2, 3), power(-2, 3) from dual;

-- DATE_ADD, DATE_SUB
select date_add('2023-07-15', interval 3 month) from dual;
select date_add('2023-07-15', interval 1 day) from dual;
select str_to_date('2023-07-15','%Y-%m-%d') + 1 from dual;
select date_sub('2024-01-02', interval 2 day) from dual;

select datediff('2023-12-31', '2023-01-01') from dual; -- 364
select datediff('2023-01-01', '2023-12-31') from dual; -- -364

select now() from dual; -- timestamp

select date_format('2023-12-31', '%Y-%m-%d')  from dual;

select extract(year from '2023-12-31') from dual;
select extract(month from '2023-12-31') from dual;
select extract(day from '2023-12-31') from dual;

select ifnull(null, 0) from dual;

select round(ifnull(radius,0) * ifnull(radius,0) * pi(),2) from circle;
select round(coalesce(radius,0) * coalesce(radius,0) * pi(),2) from circle; -- coalesce() suppported in MySQL/ PostgreSQL

insert into circle values (null, 'BLACK', null);

select
	c.*,
	case
		when c.color = 'RED' and c.radius > 3 then 'R' -- You can use and, or in case statement
        when c.color = 'YELLOW' then 'Y'
        else 'B'
	end as color_short_name
from circle c;

select * from customer2;
alter table customer2 add membership varchar(1);
update customer2 set membership = 'G' where upper(coalesce(last_name,'x')) = 'LAU';
update customer2 set membership = 'S' where upper(coalesce(last_name,'x')) <> 'LAU';

-- G 2
-- S 2

select distinct membership
from customer2
;

select membership, count(membership)
from customer2
group by membership -- first statement to execute
;

alter table customer2 add age int;
update customer2 set age = 13 where first_name = 'Vincent';
update customer2 set age = 18 where first_name = 'Jenny';
update customer2 set age = 30 where first_name not in ('Vincent', 'Jenny');

select membership, count(membership), avg(age), max(age), min(age), sum(age) -- aggregation function together with group by
from customer2
group by membership -- first statement to execute
;

-- Wrong SQL, you cannot select a field without "group presentation"
select phone
from customer2
group by last_name;

-- "where" can work with "group by"
select last_name, count(1) as count
from customer2
where upper(ifnull(last_name, 'x')) <> 'LAU' -- execute before "group by"
group by last_name;

-- Having
select last_name, count(1) as count
from customer2
where upper(ifnull(last_name, 'x')) <> 'Lo' -- first execution (record level filtering)
group by last_name -- second execution
having count(1) > 1 -- third execution (group level filtering)
;

select c.*, 'hello' as greeting
from customer2 c;

select count(1)
from customer2 c;

select * from customer2;

-- customer vs order
create table order2 (
	id int,
    customer_id int,
    delivery_address varchar(100),
    total_amount decimal(10,2)
);

insert into order2 values (1, 2, 'ABC XYZ', 100.44);
insert into order2 values (2, 2, 'xxxABC XYZ', 22.88);
insert into order2 values (3, 1, 'aaABC XYZ', 12.12);
insert into order2 values (4, 3, 'aaAfffffBC XYZ', 90.12);

-- inner join (multiply 2 set of records)
select * 
from customer2 inner join order2;


-- inner join -> find all orders with its customer data
-- Approach 1
select c.first_name, c.last_name, c.phone, c.email, o.total_amount, o.delivery_address 
from customer2 c inner join order2 o on c.id = o.customer_id
where o.total_amount > 30 -- execute after table join
;
-- Approach 2
select c.first_name, c.last_name, c.phone, c.email, o.total_amount, o.delivery_address 
from customer2 c, order2 o
where c.id = o.customer_id
and o.total_amount > 30 -- execute after table join
;

-- "primary key" -> unqiue, not null, index
-- "auto_increment -> exisitng max value + 1
create table scientists (
	id integer primary key auto_increment, -- constraint 條件
	first varchar(50),
    last varchar(50),
    date_of_birth date,
    nationality varchar(2)
);

create table winners (
	id integer primary key auto_increment,
	recipient integer not null,
    year varchar(4) not null
);

create table countries (
	-- id integer primary key auto_increment, -- 1,2,3,4
	country_code varchar(2) primary key, -- HK
    country_name varchar(50)
);

create table awards (
	id varchar(4) primary key,
    main_contribution varchar(100)
);

insert into scientists values (21, 'Shafrira', 'Lau', date_format('1953-12-31','%Y-%m-%d'), 'US');
insert into scientists values (22, 'xxxx', 'Lau', date_format('1952-12-31','%Y-%m-%d'), 'UK');
insert into scientists values (23, 'yyyy', 'Lau', date_format('1951-09-30','%Y-%m-%d'), 'IL');
insert into scientists values (24, 'ssss', 'Lau', date_format('1955-10-30','%Y-%m-%d'), 'US');
insert into scientists values (25, 'vvvv', 'Lau', date_format('1954-04-03','%Y-%m-%d'), 'US');
insert into scientists values (26, 'aaa', 'Lau', date_format('1965-02-04','%Y-%m-%d'), 'US');
insert into scientists values (27, 'qqqq', 'Lau', date_format('1963-11-15','%Y-%m-%d'), 'US');
insert into scientists values (28, 'kkkk', 'Lau', date_format('1963-10-27','%Y-%m-%d'), 'IT');
insert into scientists values (29, 'aaaa', 'Lau', date_format('1963-10-27','%Y-%m-%d'), 'IT');

insert into scientists values (null, 'bbbb', 'Lau', date_format('1963-10-27','%Y-%m-%d'), 'UK');

select * from scientists;

insert into winners values (1, 23, '2011');
insert into winners values (2, 21, '2012');
insert into winners values (3, 28, '2012');
insert into winners values (4, 24, '2013');
insert into winners values (5, 25, '2014');
insert into winners values (6, 26, '2015');
insert into winners values (7, 27, '2015');

insert into countries values ('IL', 'Israel');
insert into countries values ('IT', 'Italy');
insert into countries values ('UK', 'United Kingdom');
insert into countries values ('US', 'United States');

insert into awards values ('2011', 'xxxx yyyy');
insert into awards values ('2012', 'abc abc');
insert into awards values ('2013', 'ijkijk');
insert into awards values ('2014', 'pulu pulu');
insert into awards values ('2015', 'ijk abc');

select * from awards;
select * from countries;
select * from winners;

-- Find the scientists getting the awrads in 2015.
-- Display scientists first and last name and awards contribution and country name
select s.first as first_name, s.last as last_name, a.main_contribution, c.country_name
from winners w 
	inner join scientists s on s.id = w.recipient
    inner join awards a on a.id = w.year
	inner join countries c on c.id = s.nationality
where w.year = '2015';

select * from order2;

-- without foreign key
-- insert into order2 values (5, 99, 'asdf' , 12.33); -- customer2 tabel may not have id 0=99

alter table order2
add foreign key (customer_id) references customer2(id);

create table customer3 (
	id integer primary key auto_increment,
	first_name varchar(20),
    last_name varchar(20),
	phone varchar(50),
    email varchar(50)
);

create table order3 (
	id integer primary key auto_increment,
    customer_id integer,
    delivery_address varchar(100),
    total_amount decimal(10,2),
    primary key (id), -- another way to create primary key
    constraint FK_CustomerOrder foreign key (customer_id) references customer3(id)
);
insert into customer3 values (1, 'Vincent', 'Lau', '852 12345678', 'vincent@gmail.com'),
							 (2, 'Oscar', 'Lo', '852 87654321', 'oscar@gmail.com');
insert into customer3 values (3, 'Jenny', 'Lau', ' 852 43121234 ', 'vincent@gmail.com');
insert into customer3 values (4, 'Sally', 'Wong', ' 852 12344444 ', 'sally@gmail.com');
insert into order3 values (1, 2, 'ABC XYZ', 100.44);
insert into order3 values (2, 2, 'xxxABC XYZ', 22.88);
insert into order3 values (3, 1, 'aaABC XYZ', 12.12);
insert into order3 values (4, 3, 'aaAfffffBC XYZ', 90.12);

-- inner join
select c.first_name, c.last_name, o.delivery_address , o.total_amount
from customer3 c inner join order3 o on c.id = o.customer_id;

-- left join (all customers, no matter with orders or not)
-- all data in customer3 retains in the result set.
select c.first_name, c.last_name, o.delivery_address , o.total_amount
from customer3 c left join order3 o on c.id = o.customer_id;

-- left join (Customers without orders)
-- similar to "not exists"
select c.first_name, c.last_name, o.delivery_address , o.total_amount
from customer3 c left join order3 o on c.id = o.customer_id
where o.customer_id is null;

-- -> with foreign key: you cant add a child row with foreign key value not exists in parent primary key column
-- insert into order3 values (5, [4], 'XYZ', 90.12); --> [] no customer 4

-- Union / unionall
select 'hello' as abc from dual
union 
select 'goodbye' as abc from dual; 

-- unionall: append all the result set, ni matter it has duplicated record
select 'hello' as abc from dual
union all
select 'goodbye' as abc from dual; 

-- union: append the result set, remove duplicated record
select 'hello' as abc from dual
union 
select 'hello' as abc from dual; 

create table student2(
  id integer primary key auto_increment,
  name varchar(20)
  )