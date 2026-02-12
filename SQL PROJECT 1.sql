USE HR_DATABASE;

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(25)
);

CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2) NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(8,2),
    max_salary DECIMAL(8,2)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id INT NOT NULL,
    salary DECIMAL(8,2) NOT NULL,
    manager_id INT,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE TABLE dependents (
    dependent_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    relationship VARCHAR(25) NOT NULL,
    employee_id INT NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO regions(region_id,region_name)  
VALUES (1,'Europe'); 
INSERT INTO regions(region_id,region_name)  
VALUES (2,'Americas'); 
INSERT INTO regions(region_id,region_name)  
VALUES (3,'Asia'); 
INSERT INTO regions(region_id,region_name)  
VALUES (4,'Middle East and Africa');

SELECT * FROM regions

INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('AR','Argentina',2); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('AU','Australia',3); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('BE','Belgium',1); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('BR','Brazil',2); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('CA','Canada',2); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('CH','Switzerland',1); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('CN','China',3); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('DE','Germany',1); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('DK','Denmark',1); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('EG','Egypt',4); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('FR','France',1); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('HK','HongKong',3); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('IL','Israel',4); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('IN','India',3); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('IT','Italy',1); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('JP','Japan',3); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('KW','Kuwait',4); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('MX','Mexico',2); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('NG','Nigeria',4); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('NL','Netherlands',1); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('SG','Singapore',3); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('UK','United Kingdom',1); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('US','United States of America',2); 
INSERT INTO countries(country_id,country_name,region_id) 
VALUES ('ZM','Zambia',4); 
INSERT INTO countries(country_id,country_name,region_id)  
VALUES ('ZW','Zimbabwe',4);

SELECT * FROM countries

INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id) 
VALUES (1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'); 
INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id) 
VALUES (1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'); 
INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id) 
VALUES (1700,'2004 Charade Rd','98199','Seattle','Washington','US'); 
INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id)  
VALUES (1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'); 
INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id)  
VALUES (2400,'8204 Arthur St',NULL,'London',NULL,'UK'); 
INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id)  
VALUES (2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK'); 
INSERT INTO locations(location_id,street_address,postal_code,city,state_province,country_id) 
VALUES (2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');

SELECT * FROM locations

INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (1,'Public Accountant',4200.00,9000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (2,'Accounting Manager',8200.00,16000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (3,'Administration Assistant',3000.00,6000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (4,'President',20000.00,40000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (5,'Administration Vice President',15000.00,30000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (6,'Accountant',4200.00,9000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (7,'Finance Manager',8200.00,16000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (8,'Human Resources Representative',4000.00,9000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (9,'Programmer',4000.00,10000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (10,'Marketing Manager',9000.00,15000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (11,'Marketing Representative',4000.00,9000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (12,'Public Relations Representative',4500.00,10500.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (13,'Purchasing Clerk',2500.00,5500.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (14,'Purchasing Manager',8000.00,15000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (15,'Sales Manager',10000.00,20000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (16,'Sales Representative',6000.00,12000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (17,'Shipping Clerk',2500.00,5500.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary) 
VALUES (18,'Stock Clerk',2000.00,5000.00); 
INSERT INTO jobs(job_id,job_title,min_salary,max_salary)  
VALUES (19,'Stock Manager',5500.00,8500.00);

SELECT * FROM jobs

INSERT INTO departments(department_id,department_name,location_id) 
VALUES (1,'Administration',1700); 
INSERT INTO departments(department_id,department_name,location_id) 
VALUES (2,'Marketing',1800); 
INSERT INTO departments(department_id,department_name,location_id) 
VALUES (3,'Purchasing',1700); 
INSERT INTO departments(department_id,department_name,location_id) 
VALUES (4,'Human Resources',2400); 
INSERT INTO departments(department_id,department_name,location_id)  
VALUES (5,'Shipping',1500); 
INSERT INTO departments(department_id,department_name,location_id) 
VALUES (6,'IT',1400); 
INSERT INTO departments(department_id,department_name,location_id)  
VALUES (7,'Public Relations',2700); 
INSERT INTO departments(department_id,department_name,location_id)  
VALUES (8,'Sales',2500); 
INSERT INTO departments(department_id,department_name,location_id) 
VALUES (9,'Executive',1700); 
INSERT INTO departments(department_id,department_name,location_id)  
VALUES (10,'Finance',1700); 
INSERT INTO departments(department_id,department_name,location_id)  
VALUES (11,'Accounting',1700);

SELECT * FROM departments

INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id)  
VALUES (100,'Steven','King','steven.king@sqltutorial.org','515.123.4567','1987-06-17',4,24000.00,NULL,9); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (101,'Neena','Kochhar','neena.kochhar@sqltutorial.org','515.123.4568','1989-09-21',5,17000.00,100,9); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (102,'Lex','De Haan','lex.de haan@sqltutorial.org','515.123.4569','1993-01-13',5,17000.00,100,9); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (103,'Alexander','Hunold','alexander.hunold@sqltutorial.org','590.423.4567','1990-01-03',9,9000.00,102,6); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (104,'Bruce','Ernst','bruce.ernst@sqltutorial.org','590.423.4568','1991-05-21',9,6000.00,103,6); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (105,'David','Austin','david.austin@sqltutorial.org','590.423.4569','1997-06-25',9,4800.00,103,6); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (106,'Valli','Pataballa','valli.pataballa@sqltutorial.org','590.423.4560','1998-02-05',9,4800.00,103,6); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (107,'Diana','Lorentz','diana.lorentz@sqltutorial.org','590.423.5567','1999-02-07',9,4200.00,103,6); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (108,'Nancy','Greenberg','nancy.greenberg@sqltutorial.org','515.124.4569','1994-08-17',7,12000.00,101,10); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (109,'Daniel','Faviet','daniel.faviet@sqltutorial.org','515.124.4169','1994-08-16',6,9000.00,108,10); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (110,'John','Chen','john.chen@sqltutorial.org','515.124.4269','1997-09-28',6,8200.00,108,10); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (111,'Ismael','Sciarra','ismael.sciarra@sqltutorial.org','515.124.4369','1997-09-30',6,7700.00,108,10); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (112,'Jose Manuel','Urman','jose manuel.urman@sqltutorial.org','515.124.4469','1998-03-07',6,7800.00,108,10); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (113,'Luis','Popp','luis.popp@sqltutorial.org','515.124.4567','1999-12-07',6,6900.00,108,10); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (114,'Den','Raphaely','den.raphaely@sqltutorial.org','515.127.4561','1994-12-07',14,11000.00,100,3); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (115,'Alexander','Khoo','alexander.khoo@sqltutorial.org','515.127.4562','1995-05-18',13,3100.00,114,3); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (116,'Shelli','Baida','shelli.baida@sqltutorial.org','515.127.4563','1997-12-24',13,2900.00,114,3); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (117,'Sigal','Tobias','sigal.tobias@sqltutorial.org','515.127.4564','1997-07-24',13,2800.00,114,3); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (118,'Guy','Himuro','guy.himuro@sqltutorial.org','515.127.4565','1998-11-15',13,2600.00,114,3); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (119,'Karen','Colmenares','karen.colmenares@sqltutorial.org','515.127.4566','1999-08-10',13,2500.00,114,3); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (120,'Matthew','Weiss','matthew.weiss@sqltutorial.org','650.123.1234','1996-07-18',19,8000.00,100,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (121,'Adam','Fripp','adam.fripp@sqltutorial.org','650.123.2234','1997-04-10',19,8200.00,100,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (122,'Payam','Kaufling','payam.kaufling@sqltutorial.org','650.123.3234','1995-05-01',19,7900.00,100,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (123,'Shanta','Vollman','shanta.vollman@sqltutorial.org','650.123.4234','1997-10-10',19,6500.00,100,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (126,'Irene','Mikkilineni','irene.mikkilineni@sqltutorial.org','650.124.1224','1998-09-28',18,2700.00,120,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (145,'John','Russell','john.russell@sqltutorial.org',NULL,'1996-10-01',15,14000.00,100,8); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (146,'Karen','Partners','karen.partners@sqltutorial.org',NULL,'1997-01-05',15,13500.00,100,8); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (176,'Jonathon','Taylor','jonathon.taylor@sqltutorial.org',NULL,'1998-03-24',16,8600.00,100,8); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (177,'Jack','Livingston','jack.livingston@sqltutorial.org',NULL,'1998-04-23',16,8400.00,100,8); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (178,'Kimberely','Grant','kimberely.grant@sqltutorial.org',NULL,'1999-05-24',16,7000.00,100,8); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (179,'Charles','Johnson','charles.johnson@sqltutorial.org',NULL,'2000-01-04',16,6200.00,100,8); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (192,'Sarah','Bell','sarah.bell@sqltutorial.org','650.501.1876','1996-02-04',17,4000.00,123,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (193,'Britney','Everett','britney.everett@sqltutorial.org','650.501.2876','1997-03-03',17,3900.00,123,5); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (200,'Jennifer','Whalen','jennifer.whalen@sqltutorial.org','515.123.4444','1987-09-17',3,4400.00,101,1); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (201,'Michael','Hartstein','michael.hartstein@sqltutorial.org','515.123.5555','1996-02-17',10,13000.00,100,2); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (202,'Pat','Fay','pat.fay@sqltutorial.org','603.123.6666','1997-08-17',11,6000.00,201,2); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (203,'Susan','Mavris','susan.mavris@sqltutorial.org','515.123.7777','1994-06-07',8,6500.00,101,4); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (204,'Hermann','Baer','hermann.baer@sqltutorial.org','515.123.8888','1994-06-07',12,10000.00,101,7); 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,salary,manager_id,department_id) 
VALUES (205,'Shelley','Higgins','shelley.higgins@sqltutorial.org','515.123.8080','1994-06-07',2,12000.00,101,11); 

SELECT * FROM employees

INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (1,'Penelope','Gietz','Child',206); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (2,'Nick','Higgins','Child',205); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (3,'Ed','Whalen','Child',200); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (4,'Jennifer','King','Child',100); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (5,'Johnny','Kochhar','Child',101); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (6,'Bette','De Haan','Child',102); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (7,'Grace','Faviet','Child',109); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (8,'Matthew','Chen','Child',110); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (9,'Joe','Sciarra','Child',111); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (10,'Christian','Urman','Child',112); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (11,'Zero','Popp','Child',113); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (12,'Karl','Greenberg','Child',108); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (13,'Uma','Mavris','Child',203); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (14,'Vivien','Hunold','Child',103); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (15,'Cuba','Ernst','Child',104); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id) 
VALUES (16,'Fred','Austin','Child',105); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (17,'Helen','Pataballa','Child',106); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id) 
VALUES (18,'Dan','Lorentz','Child',107); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (19,'Bob','Hartstein','Child',201); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (20,'Lucille','Fay','Child',202); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id) 
VALUES (21,'Kirsten','Baer','Child',204); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (22,'Elvis','Khoo','Child',115); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (23,'Sandra','Baida','Child',116); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id) 
VALUES (24,'Cameron','Tobias','Child',117); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (25,'Kevin','Himuro','Child',118); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (26,'Rip','Colmenares','Child',119); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (27,'Julia','Raphaely','Child',114); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (28,'Woody','Russell','Child',145); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (29,'Alec','Partners','Child',146); 
INSERT INTO dependents(dependent_id,first_name,last_name,relationship,employee_id)  
VALUES (30,'Sandra','Taylor','Child',176); 

SELECT * FROM dependents

TASK1---------------------------------------------------------------------------------------------------------
1)WRITE A QUERY FOR  SELECT STATEMENTS :- 
A. Get all data from employees
SELECT * FROM employees

B. Select employee_id, first_name, last_name, hire_date
SELECT employee_id, first_name, last_name, hire_date
FROM employees;

C. Get first name, last name, salary, new salary
SELECT first_name, last_name, salary,
       salary * 1.10 AS New_Salary
FROM employees;

D. Increase salary ×2 as New_Salary
SELECT first_name, last_name, salary,
       salary * 2 AS New_Salary
FROM employees;

2) ORDER BY Statements
A. Return employee_id, first_name, last_name, hire_date, salary
SELECT employee_id, first_name, last_name, hire_date, salary
FROM employees
ORDER BY employee_id;

B. Sort employees by first name alphabetically
SELECT *
FROM employees
ORDER BY first_name ASC;

C. Sort by first name ASC & last name DESC
SELECT *
FROM employees
ORDER BY first_name ASC, last_name DESC;

D. Sort salary from high to low
SELECT *
FROM employees
ORDER BY salary DESC;

E. Sort by hire_date ASC
SELECT *
FROM employees
ORDER BY hire_date ASC;

F. Sort by hire_date DESC
SELECT *
FROM employees
ORDER BY hire_date DESC;

3) DISTINCT Statements
A. Select salary sorted high ? low
SELECT salary
FROM employees
ORDER BY salary DESC

B. Unique salary values
SELECT DISTINCT salary
FROM employees;

C. Select job_id and salary
SELECT job_id, salary
FROM employees;

D. Remove duplicate job_id & salary
SELECT DISTINCT job_id, salary
FROM employees;

E. Distinct phone numbers
SELECT DISTINCT phone_number
FROM employees;

4) TOP N Statements
A. All rows sorted by first_name
SELECT *FROM employees
ORDER BY first_name;

B. First 5 rows
SELECT TOP 5 *
FROM employees;

C. 5 rows starting from 4th row
(SQL Server uses OFFSET + FETCH)
SELECT * FROM employees
ORDER BY employee_id
OFFSET 3 ROWS
FETCH NEXT 5 ROWS ONLY;

D. Top 5 employees with highest salary
SELECT TOP 5 *
FROM employees
ORDER BY salary DESC;

E. Employee(s) with 2nd highest salary
SELECT * FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
    WHERE salary < (SELECT MAX(salary) FROM employees)
);

5) WHERE Clause + Operators
A. Salary > 14000 sorted DESC
SELECT * FROM employees
WHERE salary > 14000
ORDER BY salary DESC;

B. Employees in department 5
SELECT * FROM employees
WHERE department_id = 5;

C. Employee with last name = 'Chen'
SELECT * FROM employees
WHERE last_name = 'Chen';

D. Joined after 1 Jan 1999
SELECT *FROM employees
WHERE hire_date > '1999-01-01';

E. Joined in the year 1999
SELECT * FROM employees
WHERE YEAR(hire_date) = 1999;

F. Last name = ‘Himuro’
SELECT * FROM employees
WHERE last_name = 'Himuro';

G. Search “Himuro” (LIKE)
SELECT * FROM employees
WHERE last_name LIKE '%Himuro%';

H. Employees with no phone number
SELECT * FROM employees
WHERE phone_number IS NULL;

I. Department ID is NOT 8
SELECT * FROM employees
WHERE department_id <> 8;

J. Department ID not 8 and not 10
SELECT * FROM employees
WHERE department_id NOT IN (8, 10);

K. Salary > 10,000
SELECT * FROM employees
WHERE salary > 10000;

L. Department 8 AND salary > 10,000
SELECT * FROM employees
WHERE department_id = 8 AND salary > 10000;

M. Salary < 10,000
SELECT * FROM employees
WHERE salary < 10000;

N. Salary ? 9,000
SELECT * FROM employees
WHERE salary >= 9000;

O. Salary ? 9,000
SELECT * FROM employees
WHERE salary <= 9000;

6)WRITE A QUERY FOR:- 
CREATE TABLE courses(
    course_id INT PRIMARY KEY,
    course_name VARCHAR(20)
);

INSERT INTO courses(course_id,course_name)
VALUES(1,'C');
INSERT INTO courses(course_id,course_name)
VALUES(2,'C++');
INSERT INTO courses(course_id,course_name)
VALUES(3,'JAVA');
INSERT INTO courses(course_id,course_name)
VALUES(4,'PYTHON');
INSERT INTO courses(course_id,course_name)
VALUES(5,'POWERBI');

SELECT * FROM courses

A. Add a new column credit_hours to the courses table
ALTER TABLE courses
ADD credit_hours INT;

B. Add fee and max_limit columns after course_name
ALTER TABLE courses
ADD fee DECIMAL(10,2),
    max_limit INT;

C. Change fee column to NOT NULL
ALTER TABLE courses
ALTER COLUMN fee DECIMAL(10,2) NOT NULL;

D. Remove (drop) the fee column
ALTER TABLE courses
DROP COLUMN fee;

E. Remove the max_limit and credit_hours columns
ALTER TABLE courses
DROP COLUMN max_limit,
            credit_hours;

TASK2------------------------------------------------------------------------------------------
1)WRITE A QUERY FOR  LOGICAL OPERATORS and OTHER ADVANCED OPERATORS:-
PART1:

A. Employees with salary > 5000 AND < 7000
SELECT * FROM employees
WHERE salary > 5000 AND salary < 7000;

B. Employees whose salary is 7000 OR 8000
SELECT * FROM employees
WHERE salary IN (7000, 8000);

C. Employees with NO phone number
SELECT * FROM employees
WHERE phone_number IS NULL;

D. Salary BETWEEN 9000 AND 12000
SELECT * FROM employees
WHERE salary BETWEEN 9000 AND 12000;

E. Employees in department 8 OR 9
SELECT * FROM employees
WHERE department_id IN (8, 9);

F. First name starts with 'jo'
SELECT * FROM employees
WHERE first_name LIKE 'Jo%';

G. First name where 2nd character is 'h'
SELECT * FROM employees
WHERE first_name LIKE '_h%';

H. Salary > ALL salaries of department 8
SELECT * FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE department_id = 8
);

PART2:

A. Salary > average salary of every department
SELECT * FROM employees
WHERE salary > ALL (
    SELECT AVG(salary)
    FROM employees
    GROUP BY department_id
);

B. Employees who have dependents
SELECT * FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents d
    WHERE d.employee_id = e.employee_id
);

C. Salary between 2500 and 2900
SELECT * FROM employees
WHERE salary BETWEEN 2500 AND 2900;

D. Salary NOT between 2500 and 2900
SELECT * FROM employees
WHERE salary NOT BETWEEN 2500 AND 2900;

E. Joined between 1 Jan 1999 and 31 Dec 2000
SELECT * FROM employees
WHERE hire_date BETWEEN '1999-01-01' AND '2000-12-31';

F. Employees not hired between 1989 and 1999
SELECT * FROM employees
WHERE hire_date NOT BETWEEN '1989-01-01' AND '1999-12-31';

G. Employees hired between 1990 and 1993
SELECT * FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1993-12-31';

PART3:

A. First names start with 'Da'
SELECT * FROM employees
WHERE first_name LIKE 'Da%';

B. First names end with 'er'
SELECT * FROM employees
WHERE first_name LIKE '%er';

C. Last name contains 'an'
SELECT * FROM employees
WHERE last_name LIKE '%an%';

D. Names starting with Jo + max 2 characters
SELECT * FROM employees
WHERE first_name LIKE 'Jo__';

E. Any starting characters + at most 1 char
SELECT * FROM employees
WHERE first_name LIKE '%_';

F. First names start with S but NOT Sh
SELECT * FROM employees
WHERE first_name LIKE 'S%' 
  AND first_name NOT LIKE 'Sh%';

PART4:

A. Employees in department 5
SELECT * FROM employees
WHERE department_id = 5;

B. Dept 5 employees with salary ? 5000
SELECT * FROM employees
WHERE department_id = 5 AND salary <= 5000;

C. Not in departments 1, 2, or 3
SELECT * FROM employees
WHERE department_id NOT IN (1, 2, 3);

D. First names NOT starting with D
SELECT * FROM employees
WHERE first_name NOT LIKE 'D%';

E. Salary NOT between 1000 and 5000
SELECT * FROM employees
WHERE salary NOT BETWEEN 1000 AND 5000;

PART5:

A. Employees WITHOUT dependents
SELECT * FROM employees e
WHERE NOT EXISTS (
    SELECT 1 
    FROM dependents d
    WHERE d.employee_id = e.employee_id
);

B. Employees who do NOT have phone numbers
SELECT * FROM employees
WHERE phone_number IS NULL;

C. Employees who DO have phone numbers
SELECT * FROM employees
WHERE phone_number IS NOT NULL;

Task3:-----------------------------------------------------------------------------------
1) INNER JOIN
A. Get information of departments with id 1, 2, 3
SELECT * FROM departments
WHERE department_id IN (1, 2, 3);

B. Employees who work in department 1, 2, 3
SELECT * FROM employees
WHERE department_id IN (1, 2, 3);

C. First name, last name, job title, department name
SELECT e.first_name,
       e.last_name,
       j.job_title,
       d.department_name
FROM employees e
INNER JOIN jobs j
    ON e.job_id = j.job_id
INNER JOIN departments d
    ON e.department_id = d.department_id
WHERE e.department_id IN (1, 2, 3);

2) LEFT JOIN
A. Country names of US, UK, China
SELECT country_name
FROM countries
WHERE country_id IN ('US', 'UK', 'CN');

B. Locations in US, UK, China
SELECT l.*
FROM locations l
INNER JOIN countries c
    ON l.country_id = c.country_id
WHERE c.country_id IN ('US', 'UK', 'CN');

C. Join countries with locations
SELECT c.country_name,
       l.city,
       l.street_address
FROM countries c
LEFT JOIN locations l
    ON c.country_id = l.country_id;

D. Countries with NO locations
SELECT c.country_name
FROM countries c
LEFT JOIN locations l
    ON c.country_id = l.country_id
WHERE l.location_id IS NULL;

3) JOIN 3 TABLES (regions, countries, locations)
SELECT r.region_name,
       c.country_name,
       l.city
FROM regions r
INNER JOIN countries c
    ON r.region_id = c.region_id
INNER JOIN locations l
    ON c.country_id = l.country_id;

4) SELF JOIN (Employee → Manager)
SELECT e.first_name AS Employee,
       m.first_name AS Manager
FROM employees e
INNER JOIN employees m
    ON e.manager_id = m.employee_id;

TASK4:--------------------------------------------------------------------------
1) GROUP BY
A. Group by department_id
SELECT department_id
FROM employees
GROUP BY department_id;

B. Count number of employees by department
SELECT department_id,
       COUNT(*) AS Total_Employees
FROM employees
GROUP BY department_id;

C. Return number of employees by department
SELECT department_id,
       COUNT(employee_id) AS Employee_Count
FROM employees
GROUP BY department_id;

D. Sort departments by headcount
SELECT department_id,
       COUNT(*) AS Head_Count
FROM employees
GROUP BY department_id
ORDER BY Head_Count DESC;

E. Departments with headcount > 5
SELECT department_id,
       COUNT(*) AS Head_Count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 5;

F. Min, Max, Avg salary per department
SELECT department_id,
       MIN(salary) AS Min_Salary,
       MAX(salary) AS Max_Salary,
       AVG(salary) AS Avg_Salary
FROM employees
GROUP BY department_id;

G. Total salary per department
SELECT department_id,
       SUM(salary) AS Total_Salary
FROM employees
GROUP BY department_id;

H. Group by department_id AND job_id
SELECT department_id,
       job_id,
       COUNT(*) AS Total_Employees
FROM employees
GROUP BY department_id, job_id;

2) HAVING CLAUSE
A. Managers and count of direct reports
SELECT manager_id,
       COUNT(*) AS Direct_Reports
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

B. Managers with at least 5 direct reports
SELECT manager_id,
       COUNT(*) AS Direct_Reports
FROM employees
GROUP BY manager_id
HAVING COUNT(*) >= 5;

C. Departments where total salary is between 20000 and 30000
SELECT department_id,
       SUM(salary) AS Total_Salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) BETWEEN 20000 AND 30000;

D. Department where minimum salary > 10000
SELECT department_id
FROM employees
GROUP BY department_id
HAVING MIN(salary) > 10000;

E. Departments with average salary between 5000 and 7000
SELECT department_id,
       AVG(salary) AS Avg_Salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) BETWEEN 5000 AND 7000;

TASK5:-----------------------------------------------------------------------------
1) SET OPERATORS
A. UNION
SELECT employee_id, first_name, department_id
FROM employees
WHERE department_id = 1

UNION

SELECT employee_id, first_name, department_id
FROM employees
WHERE department_id = 2;

B. UNION ALL
SELECT employee_id, first_name, department_id
FROM employees
WHERE department_id = 1

UNION ALL

SELECT employee_id, first_name, department_id
FROM employees
WHERE department_id = 2;

C. INTERSECT
SELECT employee_id, first_name
FROM employees
WHERE department_id = 1

INTERSECT

SELECT employee_id, first_name
FROM employees
WHERE salary > 5000;

D. EXCEPT
SELECT employee_id, first_name
FROM employees
WHERE department_id = 1

EXCEPT

SELECT employee_id, first_name
FROM employees
WHERE salary > 5000;

2) SUBQUERIES
A. Employees earning more than average salary
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

B. Employees working in IT department
SELECT *
FROM employees
WHERE department_id = (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT'
);

C. Employees whose salary is higher than their manager
SELECT e.*
FROM employees e
JOIN employees m
  ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;

3) CASE STATEMENT
A. SELECT first_name,
       salary,
       CASE
           WHEN salary < 5000 THEN 'LOW'
           WHEN salary BETWEEN 5000 AND 10000 THEN 'MEDIUM'
           ELSE 'HIGH'
       END AS Salary_Grade
FROM employees;

4) UPDATE
A. UPDATE employees
SET salary = salary * 1.10
WHERE department_id = 5;

5) DELETE
A. DELETE FROM employees
WHERE salary < 3000;

6) EXISTS
A.SELECT *
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM dependents d
    WHERE d.employee_id = e.employee_id
);

7) IN
A. SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location_id IN (
        SELECT location_id
        FROM locations
        WHERE country_id = 'US'
    )
);

TASK5:-----------------------------------------------------------------------
1) VIEWS
A. CREATE VIEW vw_employee_details AS
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.salary,
       d.department_name 
FROM employees e
JOIN departments d
  ON e.department_id = d.department_id;












































