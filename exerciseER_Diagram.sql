create database bootcamp_exercise2;

use bootcamp_exercise2;

create table regions(
  region_id integer primary key,  
  region_name varchar(25) 
  );
create table countries(
  country_id char(2) primary key, 
  country_name varchar(40),
  region_id integer,
  constraint FK_RegionsCountries foreign key (region_id) references regions(region_id)
  ); 
create table locations(
  location_id integer primary key,
  street_address varchar(25),
  postal_code varchar(12),
  city varchar(30),
  state_province varchar(12),
  country_id char(2),
  constraint FK_Countries_Locations foreign key (country_id) references countries(country_id)
  );
create table departments(
  department_id integer primary key,
  department_name varchar(30),
  manager_id integer,
  location_id integer,
  constraint FK_Locations_Departments foreign key (location_id) references locations(location_id)
  );
create table job_history(
  employee_id integer,  -- join two into primary key
  start_date date, --
  end_date date,
  job_id varchar(10),
  department_id integer,
  constraint PK_job_history primary key (employee_id , start_date),
  constraint FK_Departments_job_history foreign key (department_id) references departments(department_id)
  );
  create table jobs(
  job_id varchar(10) primary key,
  job_title varchar(35),
  min_salary integer,
  max_salary integer
  );
create table employees(
  employee_id integer primary key,
  first_name varchar(20),
  last_name varchar(25),
  email varchar(25),
  phone_number varchar(20),
  hire_date date,
  job_id varchar(10),
  salary integer,
  commission_pct integer,
  manager_id integer,
  department_id integer,
  constraint FK_employees_jobs foreign key (job_id) references jobs(job_id),
  constraint FK_employees_job_historydepart foreign key (department_id) references job_history(department_id),
  constraint FK_employees_job_history foreign key (employee_id) references job_history(employee_id)
  );

 create table job_grades(     -- 12) redesign table from jobs adding job_grades
 grade_level varchar(2) primary key,
 job_id varchar(10),
 job_title varchar(35),
 lowest_sal_in_grade integer,
 highest_sal_in_grade integer,
 constraint FK_jobs_job_grades foreign key (job_id) references jobs(job_id)
 );

-- REGIONS
INSERT INTO REGIONS (REGION_ID, REGION_NAME) VALUES
(1, 'North America'),
(2, 'Europe'),
(3, 'Asia');

-- COUNTRIES
INSERT INTO COUNTRIES (COUNTRY_ID, COUNTRY_NAME, REGION_ID) VALUES
(1, 'United States', 1),
(2, 'United Kingdom', 2),
(3, 'Japan', 3);

-- LOCATIONS
INSERT INTO LOCATIONS (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES
(1001, '123 Main St', '12345', 'New York', 'NY', 1),
(1002, '456 Elm St', '67890', 'London', NULL, 2),
(1003, '789 Oak St', '98765', 'Tokyo', NULL, 3);

-- DEPARTMENTS
INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Sales', 101, 1001),
(20, 'HR', 102, 1002),
(30, 'IT', 103, 1003);

-- JOBS
INSERT INTO JOBS (JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) VALUES
('SALESMAN', 'Salesman', 30000, 60000),
('HR_REP', 'HR Representative', 35000, 70000),
('IT_PROG', 'IT Programmer', 40000, 80000);

-- JOB_HISTORY
INSERT INTO JOB_HISTORY (START_DATE, END_DATE, JOB_ID, DEPARTMENT_ID, EMPLOYEE_ID) VALUES
('2023-01-15', '2023-05-15', 'SALESMAN', 10, 101),
('2023-02-20', '2023-06-20', 'HR_REP', 20, 102),
('2023-03-25', NULL, 'IT_PROG', 30, 103);


-- EMPLOYEES  -- 
INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(101, 'John', 'Doe', 'john@example.com', '123-456-7890', '2023-01-15', 'SALESMAN', 50000, 0.05, 103, 10),
(102, 'Jane', 'Smith', 'jane@example.com', '987-654-3210', '2023-02-20', 'HR_REP', 55000, 0.07, 103, 20),
(103, 'Michael', 'Johnson', 'michael@example.com', '555-123-4567', '2023-03-25', 'IT_PROG', 60000, 0.06, 103,30);

select location_id, street_address, city, state_province,country_name -- 3) of locations
from locations l inner join countries c on l.country_id = c.country_id;
  
select first_name, last_name, department_ID -- 4) 
from employees;

select e.first_name, e.last_name, e.job_id, e.department_ID, c.country_name  -- 5) who works in Japan // department id 30
from employees e
inner join departments d on e.department_ID = d.department_ID
inner join locations l on d.location_id = l.location_id
inner join countries c on l.country_id = c.country_id
where c.country_name = 'Japan';   -- too long?

select e1.employee_id, e1.last_name, e2.manager_id, e2.last_name -- 6) employee id? along with/manager id?  
from employees e1
inner join employees e2 on e2.employee_id = e1.manager_id; 

select first_name, last_name, hire_date -- 7) hired after employee 'Jane Smith' -> = Micheal Johnson
from employees
WHERE hire_date > (
    SELECT hire_date  -- key word "select"
    FROM employees
    WHERE last_name = 'Smith' AND first_name = 'Jane'  
);


select d.department_name , count(e.department_id ) as number_of_employees -- 8) number of employees of each department //group by  
from departments d
inner join employees e on e.department_id = d.department_id
group by e.department_id ;

select e.employee_id, j.job_title, datediff(jh.END_DATE,jh.START_DATE) as dayscount, e.department_id -- 9) 
from employees e  -- days  between ending date and starting date and jobs in department ID=30
inner join jobs j on e.job_id = j.job_id
inner join job_history jh on e.job_id = jh.job_id
where e.department_id = 30;

select d.department_name, concat(e.first_name,' ',e.last_name) as manager_name, l.city , c.country_name -- 10) combine employee manager_name
from departments d
inner join locations l on l.location_id = d.location_id
inner join countries c on c.country_id = l.country_id
inner join employees e on d.department_id = e.department_id;

select round(AVG(e.salary),2) as average_salary, d.department_name    -- 11) "average" salary of each department -> group by 
from employees e
inner join departments d on d.department_id = e.department_id
group by d.department_name;

