-- Create Countries table
CREATE TABLE Countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INT
);

-- Create Locations table
CREATE TABLE Locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id)
);

-- Create Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id INT,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES Locations(location_id)
);

-- Create Jobs table
CREATE TABLE Jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(50),
    min_salary DECIMAL(8, 2),
    max_salary DECIMAL(8, 2)
);

-- Create Employees table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id INT,
    salary DECIMAL(8, 2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Insert values into Countries table
INSERT INTO Countries (country_id, country_name, region_id) VALUES
(1, 'United States', 1),
(2, 'Canada', 1),
(3, 'United Kingdom', 2);

-- Insert values into Locations table
INSERT INTO Locations (location_id, street_address, postal_code, city, state_province, country_id) VALUES
(1, '1234 Elm St', '10001', 'New York', 'NY', 1),
(2, '5678 Maple Ave', 'V5K0A1', 'Vancouver', 'BC', 2),
(3, '9101 Oak Rd', 'SW1A1AA', 'London', 'LDN', 3);

-- Insert values into Departments table
INSERT INTO Departments (department_id, department_name, manager_id, location_id) VALUES
(1, 'HR', NULL, 1),
(2, 'IT', 101, 2),
(3, 'Finance', 102, 3);

-- Insert values into Jobs table
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES
(1, 'HR Manager', 60000, 90000),
(2, 'Software Developer', 80000, 120000),
(3, 'Accountant', 50000, 70000);

-- Insert values into Employees table
INSERT INTO Employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, manager_id, department_id) VALUES
(100, 'John', 'Doe', 'johndoe@example.com', '555-1234', '2020-01-15', 1, 65000, NULL, 1),
(101, 'Jane', 'Smith', 'janesmith@example.com', '555-5678', '2019-03-23', 2, 85000, 100, 2),
(102, 'Mary', 'Johnson', 'maryjohnson@example.com', '555-8765', '2018-05-30', 3, 60000, 101, 3);


-- Retrieve the names of employees and their job titles in the 'IT' department.

SELECT E.FIRST_NAME,E.LAST_NAME,J.JOB_TITLE,D.DEPARTMENT_NAME
FROM EMPLOYEES AS E INNER JOIN DEPARTMENTS AS D 
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
INNER JOIN JOBS AS J
ON E.JOB_ID = J.JOB_ID 
WHERE D.DEPARTMENT_NAME = 'IT';

-- Find employees who work in the same location as 'Jane Smith'.

SELECT E.FIRST_NAME,E.LAST_NAME
FROM EMPLOYEES AS E
INNER JOIN DEPARTMENTS AS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
INNER JOIN LOCATIONS AS L 
ON L.LOCATION_ID = D.LOCATION_ID 
WHERE L.LOCATION_ID = (
	SELECT L2.LOCATION_ID
	FROM EMPLOYEES AS E2 
	INNER JOIN DEPARTMENTS AS D2 ON E2.DEPARTMENT_ID = D2.DEPARTMENT_ID
	INNER JOIN LOCATIONS AS L2 ON L2.LOCATION_ID = D2.LOCATION_ID
	WHERE E2.FIRST_NAME = 'JANE' AND E2.LAST_NAME = 'SMITH'
);

-- List all employees and their respective countries, including unmatched records.

SELECT E.FIRST_NAME,E.LAST_NAME,C.COUNTRY_NAME
FROM EMPLOYEES AS E
LEFT JOIN DEPARTMENTS AS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS AS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES AS C ON L.COUNTRY_ID = C.COUNTRY_ID

-- Show employees who work in the same department as their manager.
	
SELECT
	EMP.FIRST_NAME AS EMP_FIRST,
	EMP.LAST_NAME AS EMP_LAST,
	MANAGER.FIRST_NAME AS MG_FIRST,
	MANAGER.LAST_NAME AS MG_LAST
FROM EMPLOYEES AS EMP
JOIN EMPLOYEES AS MANAGER
ON EMP.MANAGER_ID = MANAGER.EMPLOYEE_ID
WHERE EMP.DEPARTMENT_ID = MANAGER.DEPARTMENT_ID;

-- List the employees and their department names.

SELECT E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_NAME
FROM EMPLOYEES AS E INNER JOIN 
DEPARTMENTS AS D ON
E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- Retrieve employees and their manager's names.

SELECT
	EMP.FIRST_NAME AS E_FIRST,
	EMP.LAST_NAME AS E_LAST,
	MANAGER.FIRST_NAME AS MG_FIRST,
	MANAGER.LAST_NAME AS MG_LAST
FROM EMPLOYEES AS EMP LEFT JOIN EMPLOYEES AS MANAGER 
ON EMP.MANAGER_ID = MANAGER.EMPLOYEE_ID;


-- Show all employees and their respective departments, if assigned.

SELECT E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_NAME
FROM EMPLOYEES AS E LEFT JOIN
DEPARTMENTS AS D ON
E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- Find all employees who are managers.

SELECT 
	MANAGER.FIRST_NAME,
	MANAGER.LAST_NAME
FROM EMPLOYEES AS EMP JOIN
EMPLOYEES AS MANAGER 
ON EMP.MANAGER_ID = MANAGER.EMPLOYEE_ID;

-- List all employees and their job titles.

SELECT E.FIRST_NAME,E.LAST_NAME,J.JOB_TITLE
FROM EMPLOYEES AS E LEFT JOIN
JOBS AS J ON
E.JOB_ID = J.JOB_ID;

-- Show employees who have no manager.

SELECT E.FIRST_NAME,E.LAST_NAME
FROM EMPLOYEES AS E 
WHERE MANAGER_ID IS NULL;

-- List employees and their indirect managers (manager's manager).

SELECT 
	EMP.FIRST_NAME AS E_FIRST,
	EMP.LAST_NAME AS E_LAST,
	MANAGER.FIRST_NAME AS INDIRECT_MG_FIRST,
	MANAGER.LAST_NAME AS INDIRECT_MG_LAST
FROM EMPLOYEES AS EMP JOIN
EMPLOYEES AS MANAGER 
ON EMP.MANAGER_ID = MANAGER.EMPLOYEE_ID;

-- List all locations including those without any departments.

SELECT L.CITY,L.STATE_PROVINCE,D.DEPARTMENT_NAME
FROM LOCATIONS AS L LEFT JOIN 
DEPARTMENTS AS D ON
L.LOCATION_ID = D.LOCATION_ID;

-- Retrieve all jobs including those without any employees assigned.

SELECT J.JOB_TITLE,E.FIRST_NAME,E.LAST_NAME
FROM EMPLOYEES AS E 
RIGHT JOIN JOBS AS J 
ON E.JOB_ID = J.JOB_ID;

-- Find employees who work in the same department as their manager.

SELECT 
	E.FIRST_NAME AS E_FIRST,
	E.LAST_NAME AS E_LAST,
	MANAGER.FIRST_NAME AS MG_FIRST,
	MANAGER.LAST_NAME AS MG_LAST
	FROM EMPLOYEES AS E 
	JOIN EMPLOYEES AS MANAGER 
	ON E.MANAGER_ID = MANAGER.EMPLOYEE_ID
	WHERE MANAGER.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- Find employees who work in the same location as 'John Doe'.

SELECT 
	E.FIRST_NAME,
	E.LAST_NAME,
	L.LOCATION_ID
	FROM EMPLOYEES AS E 
	INNER JOIN DEPARTMENTS AS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
	INNER JOIN LOCATIONS AS L ON L.LOCATION_ID = D.LOCATION_ID
	WHERE L.LOCATION_ID = (
	SELECT 
	L2.LOCATION_ID
	FROM EMPLOYEES AS E2 
	INNER JOIN DEPARTMENTS AS D2 ON E2.DEPARTMENT_ID = D2.DEPARTMENT_ID
	INNER JOIN LOCATIONS AS L2 ON L2.LOCATION_ID = D2.LOCATION_ID
	WHERE E2.FIRST_NAME = 'JOHN' AND E2.LAST_NAME = 'DOE'
	);

-- Find the job titles and the departments they are associated with.

SELECT 
	D.DEPARTMENT_NAME AS DEPT_NAME,
	J.JOB_TITLE AS JOB
	FROM EMPLOYEES AS E INNER JOIN 
	DEPARTMENTS AS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
	INNER JOIN JOBS AS J ON E.JOB_ID = J.JOB_ID;

-- List all departments and their managers, including unmatched records.

SELECT 
	D.DEPARTMENT_NAME AS DEPT_NAME,
	M.FIRST_NAME AS MG_FIRST,
	M.LAST_NAME AS MG_LAST
	FROM DEPARTMENTS AS D LEFT JOIN
	EMPLOYEES AS M ON
	D.MANAGER_ID = M.EMPLOYEE_ID;

-- Show all jobs and employees, including unmatched records.

SELECT 
	J.JOB_TITLE AS JOB,
	E.FIRST_NAME AS E_FIRST,
	E.LAST_NAME AS E_LAST 
	FROM JOBS AS J FULL JOIN 
	EMPLOYEES AS E ON
	J.JOB_ID = E.JOB_ID;

-- Retrieve all departments including those with no employees.

SELECT 
	D.DEPARTMENT_NAME AS DEPT_NAME,
	E.FIRST_NAME AS E_FIRST,
	E.LAST_NAME AS E_LAST
	FROM DEPARTMENTS AS D LEFT JOIN 
	EMPLOYEES AS E ON
	D.DEPARTMENT_ID = E.DEPARTMENT_ID;

-- List employees and their manager details, if available.

SELECT 
	EMP.FIRST_NAME AS E_FIRST,
	EMP.LAST_NAME AS E_LAST,
	MANAGER.FIRST_NAME AS MG_FIRST,
	MANAGER.LAST_NAME AS MG_LAST,
	MANAGER.EMAIL AS MG_EMAIL,
	MANAGER.PHONE_NUMBER AS MG_PHONE,
	MANAGER.SALARY AS MG_SALARY
	FROM EMPLOYEES AS EMP 
	JOIN EMPLOYEES AS MANAGER ON
	EMP.MANAGER_ID = MANAGER.EMPLOYEE_ID;









