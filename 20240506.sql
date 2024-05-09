use sys;

-- Create Table Statement
create table Circle (
	radius decimal(3,2)
);

-- Basic Select Statment
select * from Circle;

-- Insert data
-- Approach 1: insert into xxx (colum_name ...) values (....);
INSERT INTO CIRCLE (RADIUS) VALUES (2.34); -- Decimal(3,2) -> 1 integer, 2 decimal places
-- INSERT INTO CIRCLE (RADIUS) VALUES (10.34); -- NOT OK
INSERT INTO CIRCLE (RADIUS) VALUES (1.345); -- 1.345 -> 1.35 (MySQL Product specific behavior)

-- Approach 2: insert into xxx values (....);
insert into circle values (0.37);

-- Delete data
delete from circle where radius >= 1.35;

-- Update data (UPDATE table_name SET COLUMN_NAME = xxx WHERE ....)
update circle set radius = 1.99 where radius < 1;

-- Add column
alter table circle add color varchar(20);

select * from Circle;

-- insert 
insert into circle (color, radius) values ('RED', 3.14); -- follow column sequence
insert into circle values (3.15, 'YELLOW'); -- follow the default ordering 

-- Select where and/ or ...
select * from circle where color = 'RED' and radius < 3; 
select * from circle where color = 'RED' or radius < 3; 

-- delete 
delete from circle where color = 'YELLOW' and radius > 4;
delete from circle where color = 'YELLOW' or radius > 4;

-- update
update circle set color = 'BLACK' where color = 'RED' or color = 'YELLOW';

select * from circle where color is null;
select * from circle where color is not null;

-- Math Operator
-- = , >=, <=, >, <, <>
select * from circle where color <> 'BLACK'; -- Not equals to BLACK, not including null values
select * from circle where color = 'BLACK' or color is null;

-- dual
select 1, 'hello' from dual;
select * from circle; -- * means all columns in table
select radius, color from circle;
select radius, color, 'hello' from circle;
select radius as c_radius, color as c_color, 'hello' as abc from circle;

delete from circle;
truncate circle; -- Oracle: non-rollback-able
select * from circle;

insert into circle values (3.15, 'YELLOW'); 
insert into circle values (7.8, 'RED'); 
insert into circle values (9.99, 'RED');

-- DISTINCT
select distinct color from circle;
select distinct color from circle where radius > 7;

-- BETWEEN (numbers or date)
select * from circle where radius between 6 and 9.99; -- inclusive

alter table circle add create_date date;

insert into circle values (9.43, 'WHITE', STR_TO_DATE('20012013', '%d%m%Y'));
insert into circle values (9.19, 'RED', STR_TO_DATE('2014,01,31', '%Y,%m,%d'));
-- insert into circle values (2.19, 'RED', '01-JAN-2014'); -- NOT OK in MySQL

select * from circle order by create_date asc;
select * from circle where create_date is not null order by create_date asc;
select * from circle where create_date is not null order by create_date; -- by default "ascending" order
select * from circle where create_date is not null order by create_date desc; -- descending order
select * from circle order by create_date desc; -- null value is in the last ordering

-- Math operation, +, -, *, /, pi(), round(), mod()
select round(radius * radius * pi(),2) as area, radius, color from circle;

select 5 % 2 from dual;

-- LIMIT (use it with ordering)
select * from circle where create_date is not null order by create_date desc limit 1;

-- LIKE
select * from circle where color like 'R%'; -- all color starts with R character
select * from circle where color like 'Y%'; -- all color starts with Y character

select * from circle where color like '%W'; -- all color ends with W

select * from circle where color like '%E%'; -- all color contains E characters
select * from circle where color like '%ED%'; -- all color contains ED

select * from circle where color in ('YELLOW', 'RED'); -- or