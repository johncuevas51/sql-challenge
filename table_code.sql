DROP TABLE departments
DROP TABLE dept_emp
DROP TABLE dept_manager
DROP TABLE employees
DROP TABLE salaries
DROP TABLE titles


-- Create titles table
CREATE TABLE titles (
	title_id VARCHAR PRIMARY KEY NOT NULL,
	title VARCHAR (30) NOT NULL
);

-- Create employees table 
CREATE TABLE employees (
	emp_no INT PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex Varchar (1) NOT NULL,
	hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Create departments table 
CREATE TABLE departments(
    dept_no VARCHAR(8) PRIMARY KEY NOT NULL,
    dept_name VARCHAR (30) NOT NULL
);

-- Create department employee table 
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    CONSTRAINT pk_DEPT_EMP PRIMARY KEY (
        emp_no,dept_no)
);

-- Create department manager table
CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INT NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    CONSTRAINT pk_DEPT_MANAGER PRIMARY KEY (
        dept_no,emp_no)
);

-- Create salaries table
CREATE TABLE salaries(
	emp_no INT NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);



SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON
s.emp_no = e.emp_no

SELECT e.first_name, e.last_name, e.hire_date
FROM employees as e
WHERE date_part('year', hire_date) = 1986;

SELECT dm.emp_no, dm.dept_no, d.dept_name, e.last_name, e.first_name
FROM dept_manager as dm
LEFT JOIN departments as d ON
d.dept_no = dm.dept_no
LEFT JOIN employees as e ON
dm.emp_no= e.emp_no

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
FROM employees as e
INNER JOIN dept_emp as de ON e.emp_no= de.emp_no 
INNER JOIN departments as d ON d.dept_no= de.dept_no;

SELECT e.first_name, e.last_name, e.sex
FROM employees as e 
WHERE first_name = 'Hercules' and
last_name LIKE 'B%'

SELECT e.emp_no, e.last_name, e.first_name
FROM employees as e 
LEFT JOIN dept_emp as de ON 
e.emp_no=de.emp_no
INNER JOIN departments as d ON
d.dept_no=de.dept_no
WHERE d.dept_name= 'Sales';

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
LEFT JOIN dept_emp as de ON
e.emp_no= de.emp_no 
INNER JOIN departments as d ON
d.dept_no=de.dept_no
WHERE d.dept_name in ('Sales','Development')

SELECT last_name, COUNT(*) AS freq_count
FROM employees
GROUP BY last_name
ORDER BY freq_count DESC;
