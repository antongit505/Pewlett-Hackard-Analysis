SELECT e.emp_no,e.first_name, e.last_name,ti.title,ti.from_date,ti.to_date
--INTO retirement_titles
FROM employees AS e
INNER JOIN titles as ti
ON e.emp_no=ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate emp_no to keep the most recent title for each employee

SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--INTO unique_titles
FROM retirement_titles
WHERE (to_date='9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

--Retrieve the number of employees by their most recent job title who are about to retire.

SELECT COUNT(title),title
--INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(title) DESC;

--Create a mentorship-eligibility table that holds the current employees who were born between January 1, 1965 and 
--December 31, 1965.

SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date,ti.title
--INTO mentorship_elegibility
FROM employees AS e
INNER JOIN department_employees as de
ON e.emp_no=de.emp_no
INNER JOIN titles as ti
ON e.emp_no=ti.emp_no
WHERE (de.to_date='9999-01-01') 
	AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

--Count the amount of employees per title who're elegible for mentorship
SELECT title,COUNT(emp_no) as total_employees
FROM mentorship_elegibility 
GROUP BY title
ORDER BY total_employees DESC;

--Count the amount of current HR employees to organize teams and look for candidates
SELECT DISTINCT ON(e.emp_no) e.emp_no,e.first_name,e.last_name, di.dept_name,ei.to_date
--INTO HR_current_emp
FROM employees AS e
INNER JOIN dept_info AS di
ON e.emp_no=di.emp_no
INNER JOIN emp_info AS ei
ON di.emp_no=ei.emp_no
WHERE (ei.to_date='9999-01-01')
	AND (dept_name='Human Resources')
ORDER BY e.emp_no ASC;

--Retrieve the amount of actual HR employees
SELECT COUNT(emp_no) as Total_HR_employees
FROM HR_current_emp 
GROUP BY dept_name;
