-- Creating tables for PH-EmployeeDB
DROP TABLE departments CASCADE;
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL, 
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

DROP TABLE employees CASCADE;
CREATE TABLE employees (
	emp_no INT NOT NULL,
	bith_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	gender VARCHAR NOT NULL, 
	hire_date DATE NOT NULL,
	PRIMARY KEY (emp_no)
);

DROP TABLE dept_manager;
CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL, 
	emp_no INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE salaries;
CREATE TABLE salaries (
	emp_no INT NOT NULL, 
	salary INT NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no)
);

SELECT * FROM salaries;

DROP TABLE dept_emp;
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL, 
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);
SELECT * FROM dept_emp;

DROP TABLE titles;
CREATE TABLE titles (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	PRIMARY KEY (emp_no, title, from_date),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM dept_emp;

--Import data from csv file
--right click newly created table
--import/export> file path> Header toggle "YES", comma delimiter
-- **NOTE** the order of import is importaint
--... if the key hasn't been created to reference it wont work
-- read the errors. They help. 

-- BEGIN THE QUERY 

--find # of EE ready to retire with birthdates in 1952-1955
SELECT first_name, last_name
FROM employees
WHERE bith_date BETWEEN '1952-01-01' AND '1955-12-31'

-- find # EE retire ready 1952
-- output 21209 
SELECT first_name, last_name
FROM employees
WHERE bith_date BETWEEN '1952-01-01' AND '1952-12-31'

-- find # EE retire ready 1953
-- output 22857 
SELECT first_name, last_name
FROM employees
WHERE bith_date BETWEEN '1953-01-01' AND '1953-12-31'

-- find # EE retire ready 1954
-- output 23228 
SELECT first_name, last_name
FROM employees
WHERE bith_date BETWEEN '1954-01-01' AND '1954-12-31'

-- find # EE retire ready 1955
-- output 23104 
-- add AND statement for hire date ** NOTICE** (tuple)
-- second output 10590 (still in 1955 birthdate)
SELECT first_name, last_name
FROM employees
WHERE bith_date BETWEEN '1955-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- add COUNT **notice** PARENTHASIS
-- expand bithdate back to 1952-1955
--output 41380 (only need first names to count rows)
SELECT COUNT (first_name)
FROM employees
WHERE bith_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--create a new table with our new info!!! COOL. 
--INTO 
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE bith_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--Show the new table --BOOM--
SELECT * FROM retirement_info; 

-- EXPORT THE NEW FILE and save as CSV
-- right click on table> import/export
-- enter file path, format CSV, header toggle "YES", comma delimiter
-- Commit to GIT HUB

