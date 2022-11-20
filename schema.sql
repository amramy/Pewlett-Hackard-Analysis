-- Creating tables for PH-EmployeeDB
DROP TABLE departments CASCADE;
CREATE TABLE departments (
	dept_no VARCHAR(4) NOT NULL, 
	dept_name VARCHAR(40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE (dept_name)
);

DROP TABLE employees;
CREATE TABLE employees (
	emp_no INT NOT NULL,
	birth_date DATE NOT NULL,
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

-- We need to add EE id number
--Drop table so we can recreate
DROP TABLE retirement_info;

-- Add "emp_no" to our table
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- shOW THE new table
SELECT * FROM retirement_info;

-- LETS practice JOIN 

--SELECT table.column_name, (selecting columns we want to view from each table)
	--table.column_name,
--FROM table (points to first table to be joined)
--JOIN TYPE (points to the second table to be joined)
--ON (indicates where Postgres should look for matches);

--  INNER Join departments and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--  INNER JOIN WITH ALIAS
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- LEFT Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- let's clean up our code... recreate above code
-- use AS to create nicknames
SELECT ri.emp_no,
    ri.first_name,
ri.last_name,
    de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no;

--create NEW TABLE AS current_emp
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01')


SELECT * FROM retirement_info;

-- COUNT & Group By(has no order, if re-run different order)
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

SELECT * FROM departments;
-- ORDER BY
-- Employee count by department number
-- ** NOTICE order of dept_no is acending
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

-- CREATE NEW TABLE WITH ABOVE DATA ** add INTO 
SELECT COUNT(ce.emp_no), de.dept_no
INTO department_count
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT * FROM department_count

-- export department_count table 

-- lets look at the salaries table
SELECT * FROM salaries;

-- Decending order of to_date column
SELECT * FROM salaries
ORDER BY to_date DESC;

-- The dates look wierd... not most recent... must be something with salary
-- New table from employees, salaries and dept_emp
-- first select columns from each table
SELECT e.emp_no,
e.first_name,
e.last_name, 
e.gender, 
s.salary, 
de.to_date
INTO emp_info
-- call out alias employees table AS e, salaries AS s, 
FROM employees as e
-- INNER JOIN 
INNER JOIN salaries AS s
ON (e.emp_no = s.emp_no)
-- ADD third table to join and alias AS de
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
-- ADD filter ... range of dates to look at
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
 -- ADD filter in the WHERE clause ... to_date from dept_emp using "AND"
 	AND (de.to_date = '9999-01-01');
 
 -- I miss spelled birth_date in employee table creating... RENAME!
ALTER TABLE employees RENAME COLUMN bith_date TO birth_date;

SELECT * FROM emp_info;

-- Create new table of Managers who will retire soon(ish)
-- List of managers per department
SELECT dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- create query returning only retiring Sales Team info
SELECT * FROM dept_info;

SELECT * FROM retirement_info;

-- output 5860 (department Number d007)
SELECT *
INTO sales_retire_info
FROM dept_info
WHERE dept_name = 'Sales';

--output 9281 (department Number d005)
SELECT *
FROM dept_info
WHERE dept_name = 'Development';


-- output 15141 
SELECT *
INTO sales_development_retire_info
FROM dept_info
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

SELECT * FROM sales_development_retire_info;