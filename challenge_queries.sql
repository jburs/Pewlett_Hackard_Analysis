-- Table 1
-- Number of Retiring Employees by Title
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	ti.title,
	ti.from_date,
	s.salary
INTO silver_tsunami
FROM retirement_info as ri
INNER JOIN titles as ti
ON (ri.emp_no = ti.emp_no)
INNER JOIN salaries as s
ON (ti.emp_no = s.emp_no)
ORDER BY emp_no ASC;
	
--check data 
select * FROM silver_tsunami;

-- Partition the data to show only most recent title per employee
SELECT emp_no,
	first_name, 
	last_name, 
	title, 
	from_date,
	salary
--INTO retire_by_title
FROM 
(SELECT emp_no,
	first_name, 
	last_name, 
	title, 
	from_date,
	salary, ROW_NUMBER() OVER
	(PARTITION BY (emp_no)
	ORDER BY from_date DESC) rn
	FROM silver_tsunami
) tmp WHERE rn = 1
ORDER BY emp_no;

--Check data
select * from retire_by_title;

--Count number of employees
select count(retire_by_title.emp_no) FROM retire_by_title;


-- Mentorship Eligibility
-- Table 2

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	ti.title,
	ti.from_date,
	ti.to_date
into mentor_eligible_rough
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

-- Partition the data to show only most recent title per employee
SELECT emp_no,
	birth_date,
	first_name, 
	last_name, 
	title, 
	from_date,
	to_date
INTO mentor_eligible
FROM 
(SELECT emp_no,
 	birth_date,
	first_name, 
	last_name, 
	title, 
	from_date,
	to_date, ROW_NUMBER() OVER
	(PARTITION BY (emp_no)
	ORDER BY from_date DESC) rn
	FROM mentor_eligible_rough
) tmp WHERE rn = 1
ORDER BY emp_no;

--Check data
select count(mentor_eligible.emp_no) FROM mentor_eligible;

-- Count number of employees
select * from mentor_eligible;
SELECT e.emp_no,
	e.birth_date,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
into mentor_eligible_rough
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no ASC;

-- Partition the data to show only most recent title per employee
SELECT emp_no,
	birth_date,
	first_name, 
	last_name, 
	title, 
	from_date,
	to_date
INTO mentor_eligible
FROM 
(SELECT emp_no,
 	birth_date,
	first_name, 
	last_name, 
	title, 
	from_date,
	to_date, ROW_NUMBER() OVER
	(PARTITION BY (emp_no)
	ORDER BY from_date DESC) rn
	FROM mentor_eligible_rough
) tmp WHERE rn = 1
ORDER BY emp_no;


select * from mentor_eligible;