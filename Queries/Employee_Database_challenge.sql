--DELIVERABLE 1: The Number of Retiring Employees by Title 

-- Query 
-- Create table Retirement_Titles with EE info, birthdate, title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
-- INNER JOIN on primary key
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
-- filter on birthdate
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
-- ORDER BY employee number
ORDER BY emp_no 

-- view retirement_titles
SELECT * FROM retirement_titles;

-- EXPORT retirement_titles as to data folder as csv. 

--Query 
--REMOVE duplicates from retirement_titles
-- Use Dictinct with Orderby to remove duplicate rows
-- filter current employees using WHERE to_date =
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--view table 
SELECT * FROM unique_titles;

-- EXPORT unique_titles to data folder as csv.

-- Query 
-- COUNT # of EE recent job title about to retire
SELECT COUNT (title) 
FROM unique_titles;
-- output 72458 total titles

-- CREATE "Retiring Titles" table with # EE for each title
-- NotiCE "AS count" created new column "count", title column as title
SELECT COUNT(emp_no) AS count, title 
INTO retiring_titles 
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- view retiring_titles table
SELECT * FROM retiring_titles;

-- EXPORT "retiring_titles" to data folder as csv.


--Deliverable 2: The Employees Eligible for the Mentorship Program
-- CREATE "Mentorship Eligibilty" file with current EE's born in 1965
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY emp_no;
 
SELECT * FROM mentorship_eligibilty;

-- EXPORT mentorship_eligibilty to DAta file as csv.

--DELIVERABLE #3: Two additional queries to provide more insight into the upcoming "silver tsunami."

-- Lets widen the range of eligible EE Three Year range
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
--INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1964-01-01' AND '1966-12-31'
ORDER BY emp_no;

-- Lets widen the range of eligible EE Five Year range
SELECT DISTINCT ON (emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO five_yr_mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE de.to_date = '9999-01-01'
AND e.birth_date BETWEEN '1963-01-01' AND '1967-12-31'
ORDER BY emp_no;

SELECT * FROM five_yr_mentorship_eligibilty;


--mentor ready by department
SELECT COUNT(emp_no) AS count, title 
INTO mentor_titles 
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count DESC;


SELECT * FROM mentor_titles;



-- FIND LENGTH OF EMPLOYMENT

--List of non_current employees = 118660
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.hire_date,
	de.from_date,
	de.to_date,
	t.title
--INTO non_current_employees
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN titles AS t
ON e.emp_no = t.emp_no
WHERE de.to_date NOT IN ('9999-01-01')
ORDER BY to_date DESC;

SELECT * FROM non_current_employees;
-- this data shows me comparisson with "hire_date" and "from_date". 
-- realizing I don't need "from_date" with job transphers
-- I also don't need titles

DROP TABLE non_current_employees

-- recreate non_current_employees = 91479 rows
-- NOTE this did not have duplicate EE's... NICE. 
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.hire_date,
	de.to_date
INTO non_current_employees
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
WHERE de.to_date NOT IN ('9999-01-01')
ORDER BY to_date DESC;

-- ADD another column with durration of employment
SELECT emp_no,
	first_name,
	last_name,
	hire_date,
	to_date,
	to_date - hire_date AS durration_of_employment
INTO non_ee_durration
FROM non_current_employees
ORDER BY durration_of_employment DESC;

--View table 
SELECT * FROM non_ee_durration;
-- EXPORT to data file as csv

--find avereage length of employment from non_current_employees... in DAYS.
-- output... findings = 2,635.32 days
SELECT ROUND(AVG(durration_of_employment), 2) AS "Average durration of Employees no longer with PH (DAYS)"
INTO avg_durration_non_current_ee
FROM non_ee_durration;

-- view results
SELECT * FROM avg_durration_non_current_ee
-- EXPORT to data file as csv

-- COMMIT TO GIT HUB
