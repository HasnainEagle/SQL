USE MIXED_DATABASE;
CREATE TABLE Sales (
    Employee_ID INT,
    Employee_Name VARCHAR(255),
    Sales_Order INT,  -- To track the order of sales (instead of a date)
    Sales_Amount DECIMAL(10, 2)
);
INSERT INTO Sales (Employee_ID, Employee_Name, Sales_Order, Sales_Amount) VALUES
(1, 'Alice', 1, 200.50),
(1, 'Alice', 2, 150.75),
(1, 'Alice', 3, 300.00),
(1, 'Alice', 4, 250.25),
(1, 'Alice', 5, 400.00),
(2, 'Bob', 1, 100.00),
(2, 'Bob', 2, 300.00),
(2, 'Bob', 3, 200.00),
(2, 'Bob', 4, 250.00),
(3, 'Charlie', 1, 450.00),
(3, 'Charlie', 2, 350.00),
(3, 'Charlie', 3, 400.00),
(3, 'Charlie', 4, 500.00);


-- NTH_VALUE()

-- Sales Performance:
-- You have a table of monthly sales by employees.
-- Find the 3rd highest sales amount for each employee and compare it to their most recent sales.

SELECT *,
NTH_VALUE(SALES_AMOUNT,3)
OVER(PARTITION BY EMPLOYEE_ID ORDER BY SALES_AMOUNT DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS THIRD_HIGH_SALES_AMOUNT,
FIRST_VALUE(SALES_AMOUNT) OVER(PARTITION BY EMPLOYEE_ID ORDER BY SALES_ORDER DESC) AS MOST_RECENT_SALE
FROM SALES;

CREATE TABLE Customer_Orders (
    Customer_ID INT,
    Customer_Name VARCHAR(255),
    Order_Date DATE,  -- Date of the order
    Order_Amount DECIMAL(10, 2)  -- Amount of the order
);

INSERT INTO Customer_Orders (Customer_ID, Customer_Name, Order_Date, Order_Amount) VALUES
-- Customer 1 Orders
(1, 'John Doe', '2023-01-15', 150.50),
(1, 'John Doe', '2023-02-20', 200.75),
(1, 'John Doe', '2023-03-25', 250.00),
(1, 'John Doe', '2023-04-30', 300.00),
(1, 'John Doe', '2023-05-10', 350.50),

-- Customer 2 Orders
(2, 'Jane Smith', '2023-01-10', 100.00),
(2, 'Jane Smith', '2023-02-12', 150.50),
(2, 'Jane Smith', '2023-03-18', 180.75),
(2, 'Jane Smith', '2023-04-20', 210.00),
(2, 'Jane Smith', '2023-05-25', 250.00),

-- Customer 3 Orders
(3, 'Mark Taylor', '2023-01-05', 50.00),
(3, 'Mark Taylor', '2023-02-07', 75.50),
(3, 'Mark Taylor', '2023-03-10', 125.00),
(3, 'Mark Taylor', '2023-04-15', 160.00),
(3, 'Mark Taylor', '2023-05-22', 200.00),

-- Customer 4 Orders
(4, 'Emily Davis', '2023-02-01', 80.00),
(4, 'Emily Davis', '2023-03-05', 100.00),
(4, 'Emily Davis', '2023-04-10', 130.00),
(4, 'Emily Davis', '2023-05-15', 180.50),
(4, 'Emily Davis', '2023-06-20', 220.75),

-- Customer 5 Orders
(5, 'Michael Johnson', '2023-01-15', 175.00),
(5, 'Michael Johnson', '2023-02-18', 200.50),
(5, 'Michael Johnson', '2023-03-25', 250.00),
(5, 'Michael Johnson', '2023-04-28', 275.25),
(5, 'Michael Johnson', '2023-05-30', 325.50),

-- Customer 6 Orders
(6, 'Sarah Brown', '2023-02-14', 90.00),
(6, 'Sarah Brown', '2023-03-17', 120.50),
(6, 'Sarah Brown', '2023-04-21', 160.00),
(6, 'Sarah Brown', '2023-05-19', 190.25),
(6, 'Sarah Brown', '2023-06-22', 230.00);

SELECT * FROM CUSTOMER_ORDERS;
-- Customer Orders:
-- In a table of customer orders sorted by date,
-- get the 2nd most recent order for each customer and check how its value compares to their latest order.
SELECT *,
NTH_VALUE(ORDER_AMOUNT,2)
OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS SEC_MOST_ORDER,
FIRST_VALUE(ORDER_AMOUNT)
OVER(PARTITION BY CUSTOMER_ID ORDER BY ORDER_DATE DESC) AS LATEST_ORDER
FROM CUSTOMER_ORDERS;

CREATE TABLE Stock_Prices (
    Stock_Symbol VARCHAR(10),
    Stock_Date DATE,
    Stock_Price DECIMAL(10, 2)
);

INSERT INTO Stock_Prices (Stock_Symbol,Stock_Date,Stock_Price) VALUES
('AAPL', '2023-01-01', 150.00),
('AAPL', '2023-01-02', 152.00),
('AAPL', '2023-01-03', 149.00),
('AAPL', '2023-01-04', 153.50),
('AAPL', '2023-01-05', 155.00),
('AAPL', '2023-01-06', 157.00),
('GOOG', '2023-01-01', 2800.00),
('GOOG', '2023-01-02', 2850.00),
('GOOG', '2023-01-03', 2900.00),
('GOOG', '2023-01-04', 2950.00),
('GOOG', '2023-01-05', 3000.00),
('GOOG', '2023-01-06', 3050.00),
('MSFT', '2023-01-01', 290.00),
('MSFT', '2023-01-02', 295.00),
('MSFT', '2023-01-03', 292.00),
('MSFT', '2023-01-04', 297.00),
('MSFT', '2023-01-05', 299.00),
('MSFT', '2023-01-06', 300.00),
('AMZN', '2023-01-01', 3200.00),
('AMZN', '2023-01-02', 3250.00),
('AMZN', '2023-01-03', 3300.00),
('AMZN', '2023-01-04', 3350.00),
('AMZN', '2023-01-05', 3400.00),
('AMZN', '2023-01-06', 3450.00),
('TSLA', '2023-01-01', 900.00),
('TSLA', '2023-01-02', 920.00),
('TSLA', '2023-01-03', 940.00),
('TSLA', '2023-01-04', 960.00),
('TSLA', '2023-01-05', 980.00),
('TSLA', '2023-01-06', 1000.00);

SELECT * FROM STOCK_PRICES;
-- Stock Prices:
-- For a list of daily stock prices sorted by date,
-- find the 5th stock price and compare it to the most recent stock price for each stock symbol.
SELECT *,
NTH_VALUE(STOCK_PRICE,5)
OVER(PARTITION BY STOCK_SYMBOL ORDER BY STOCK_DATE DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS FIFTH_STOCK_PRICE,
FIRST_VALUE(STOCK_PRICE)
OVER(PARTITION BY STOCK_SYMBOL ORDER BY STOCK_DATE DESC) AS MOST_RECENT_STOCK_PRICE
FROM STOCK_PRICES;

-- Employee Salaries:
-- In an employee table sorted by salary within each department, find the 4th highest salary in each department and check how it compares to the average salary of that department.

-- Student Grades:
-- In a table of students' exam results, find the 2nd highest grade for each student in the semester and compare it to their highest grade. 


-- NTILE
CREATE TABLE customer_purchases (
    customer_id INT,
    customer_name VARCHAR(255),
    total_purchase_amount DECIMAL(10, 2)
);

INSERT INTO customer_purchases (customer_id, customer_name, total_purchase_amount) VALUES
(1, 'Alice', 5000.00),
(2, 'Bob', 3500.00),
(3, 'Charlie', 7000.00),
(4, 'David', 4000.00),
(5, 'Eva', 6000.00),
(6, 'Frank', 2000.00),
(7, 'Grace', 8000.00),
(8, 'Hannah', 4500.00),
(9, 'Ivy', 3000.00),
(10, 'Jack', 5500.00),
(11, 'Karen', 7500.00),
(12, 'Leo', 2800.00),
(13, 'Mia', 6500.00),
(14, 'Nathan', 3700.00),
(15, 'Olivia', 5200.00),
(16, 'Paul', 4100.00),
(17, 'Quincy', 4700.00),
(18, 'Rachel', 5300.00),
(19, 'Steve', 6200.00),
(20, 'Tina', 2900.00),
(21, 'Uma', 3500.00),
(22, 'Vera', 5800.00),
(23, 'Will', 3000.00),
(24, 'Xena', 8000.00),
(25, 'Yvonne', 4400.00),
(26, 'Zack', 5700.00),
(27, 'Amy', 7200.00),
(28, 'Brian', 4900.00),
(29, 'Chloe', 6000.00),
(30, 'Derek', 3300.00),
(31, 'Ella', 4900.00),
(32, 'Frankie', 4300.00),
(33, 'Gina', 5200.00),
(34, 'Henry', 6800.00),
(35, 'Irene', 5400.00),
(36, 'James', 6200.00),
(37, 'Kathy', 5300.00),
(38, 'Lucas', 5000.00),
(39, 'Molly', 5500.00),
(40, 'Nina', 6100.00);


-- Customer Segmentation:
-- Divide customers into 5 equal groups based on the total amount of their purchases and analyze the average purchase amount in each group.
SELECT  DIV_5_EQL_GRPS,
AVG(TOTAL_PURCHASE_AMOUNT) AS AVERAGE_PURCHASE
FROM (
	SELECT *,
	NTILE(5) OVER(ORDER BY TOTAL_PURCHASE_AMOUNT DESC) AS DIV_5_EQL_GRPS
	FROM CUSTOMER_PURCHASES) AS X
GROUP BY DIV_5_EQL_GRPS;

CREATE TABLE employee_salaries (
    employee_id INT,
    employee_name VARCHAR(255),
    department VARCHAR(255),
    salary DECIMAL(10, 2)
);

INSERT INTO employee_salaries (employee_id, employee_name, department, salary) VALUES
(1, 'Alice', 'HR', 55000.00),
(2, 'Bob', 'Finance', 60000.00),
(3, 'Charlie', 'IT', 70000.00),
(4, 'David', 'Marketing', 65000.00),
(5, 'Eva', 'Finance', 75000.00),
(6, 'Frank', 'IT', 80000.00),
(7, 'Grace', 'HR', 50000.00),
(8, 'Hannah', 'Marketing', 55000.00),
(9, 'Ivy', 'Finance', 72000.00),
(10, 'Jack', 'IT', 68000.00),
(11, 'Karen', 'HR', 53000.00),
(12, 'Leo', 'Finance', 59000.00),
(13, 'Mia', 'Marketing', 64000.00),
(14, 'Nathan', 'IT', 75000.00),
(15, 'Olivia', 'HR', 51000.00),
(16, 'Paul', 'Finance', 67000.00),
(17, 'Quincy', 'Marketing', 57000.00),
(18, 'Rachel', 'IT', 79000.00),
(19, 'Steve', 'HR', 52000.00),
(20, 'Tina', 'Finance', 71000.00),
(21, 'Uma', 'Marketing', 56000.00),
(22, 'Vera', 'IT', 72000.00),
(23, 'Will', 'HR', 54000.00),
(24, 'Xena', 'Finance', 75000.00),
(25, 'Yvonne', 'Marketing', 58000.00),
(26, 'Zack', 'IT', 76000.00),
(27, 'Amy', 'HR', 49000.00),
(28, 'Brian', 'Finance', 68000.00),
(29, 'Chloe', 'Marketing', 60000.00),
(30, 'Derek', 'IT', 74000.00),
(31, 'Ella', 'Finance', 69000.00),
(32, 'Frankie', 'HR', 50000.00),
(33, 'Gina', 'Marketing', 62000.00),
(34, 'Henry', 'IT', 73000.00),
(35, 'Irene', 'HR', 47000.00),
(36, 'James', 'Finance', 72000.00),
(37, 'Kathy', 'Marketing', 59000.00),
(38, 'Lucas', 'IT', 78000.00),
(39, 'Molly', 'Finance', 71000.00),
(40, 'Nina', 'Marketing', 60000.00);

-- Employee Salary Ranges:
-- Divide employees into 4 salary brackets and calculate the average salary in each group.
SELECT FOUR_BUCKETS,
AVG(SALARY) AS AVG_SALARY
FROM(
	SELECT *,
	NTILE(4) OVER(ORDER BY SALARY DESC) AS FOUR_BUCKETS
	FROM EMPLOYEE_SALARIES) AS X
GROUP BY FOUR_BUCKETS;


CREATE TABLE stock_prices2 (
    company_id INT,
    company_name VARCHAR(255),
    stock_symbol VARCHAR(10),
    stock_price DECIMAL(10, 2),
    stock_date DATE
);

INSERT INTO stock_prices2 (company_id, company_name, stock_symbol, stock_price, stock_date) VALUES
(1, 'Company A', 'AAPL', 150.00, '2024-01-01'),
(2, 'Company B', 'GOOGL', 2800.00, '2024-01-01'),
(3, 'Company C', 'AMZN', 3400.00, '2024-01-01'),
(4, 'Company D', 'MSFT', 320.00, '2024-01-01'),
(5, 'Company E', 'TSLA', 700.00, '2024-01-01'),
(6, 'Company F', 'META', 150.00, '2024-01-01'),
(7, 'Company G', 'NFLX', 500.00, '2024-01-01'),
(8, 'Company H', 'DIS', 180.00, '2024-01-01'),
(9, 'Company I', 'BA', 220.00, '2024-01-01'),
(10, 'Company J', 'GS', 400.00, '2024-01-01'),
(11, 'Company K', 'WMT', 150.00, '2024-01-01'),
(12, 'Company L', 'V', 250.00, '2024-01-01'),
(13, 'Company M', 'MA', 350.00, '2024-01-01'),
(14, 'Company N', 'PFE', 60.00, '2024-01-01'),
(15, 'Company O', 'JPM', 160.00, '2024-01-01'),
(16, 'Company P', 'C', 50.00, '2024-01-01'),
(17, 'Company Q', 'BA', 220.00, '2024-01-01'),
(18, 'Company R', 'LMT', 400.00, '2024-01-01'),
(19, 'Company S', 'HD', 340.00, '2024-01-01'),
(20, 'Company T', 'IBM', 130.00, '2024-01-01'),
(21, 'Company U', 'AAPL', 160.00, '2024-01-02'),
(22, 'Company V', 'GOOGL', 2900.00, '2024-01-02'),
(23, 'Company W', 'AMZN', 3500.00, '2024-01-02'),
(24, 'Company X', 'MSFT', 330.00, '2024-01-02'),
(25, 'Company Y', 'TSLA', 710.00, '2024-01-02'),
(26, 'Company Z', 'META', 160.00, '2024-01-02'),
(27, 'Company AA', 'NFLX', 510.00, '2024-01-02'),
(28, 'Company BB', 'DIS', 190.00, '2024-01-02'),
(29, 'Company CC', 'BA', 230.00, '2024-01-02'),
(30, 'Company DD', 'GS', 420.00, '2024-01-02'),
(31, 'Company EE', 'WMT', 160.00, '2024-01-02'),
(32, 'Company FF', 'V', 260.00, '2024-01-02'),
(33, 'Company GG', 'MA', 360.00, '2024-01-02'),
(34, 'Company HH', 'PFE', 65.00, '2024-01-02'),
(35, 'Company II', 'JPM', 170.00, '2024-01-02'),
(36, 'Company JJ', 'C', 55.00, '2024-01-02'),
(37, 'Company KK', 'BA', 230.00, '2024-01-02'),
(38, 'Company LL', 'LMT', 410.00, '2024-01-02'),
(39, 'Company MM', 'HD', 350.00, '2024-01-02'),
(40, 'Company NN', 'IBM', 140.00, '2024-01-02');

-- Stock Market Tiers:
-- Break a list of companies into 10 equal-sized tiers based on their stock prices and analyze the performance of companies in each tier.
SELECT TEN_BUCKETS,
AVG(STOCK_PRICE) AS AVG_STOCK_PRICE
FROM(
	SELECT *,
	NTILE(10) OVER(ORDER BY STOCK_PRICE DESC) AS TEN_BUCKETS
	FROM STOCK_PRICES2) AS X
GROUP BY TEN_BUCKETS;


CREATE TABLE product_pricing (
    product_id INT,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

INSERT INTO product_pricing (product_id, product_name, price) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 20.00),
(3, 'Product C', 30.00),
(4, 'Product D', 40.00),
(5, 'Product E', 50.00),
(6, 'Product F', 60.00),
(7, 'Product G', 70.00),
(8, 'Product H', 80.00),
(9, 'Product I', 90.00),
(10, 'Product J', 100.00),
(11, 'Product K', 110.00),
(12, 'Product L', 120.00),
(13, 'Product M', 130.00),
(14, 'Product N', 140.00),
(15, 'Product O', 150.00),
(16, 'Product P', 160.00),
(17, 'Product Q', 170.00),
(18, 'Product R', 180.00),
(19, 'Product S', 190.00),
(20, 'Product T', 200.00),
(21, 'Product U', 210.00),
(22, 'Product V', 220.00),
(23, 'Product W', 230.00),
(24, 'Product X', 240.00),
(25, 'Product Y', 250.00),
(26, 'Product Z', 260.00),
(27, 'Product AA', 270.00),
(28, 'Product BB', 280.00),
(29, 'Product CC', 290.00),
(30, 'Product DD', 300.00),
(31, 'Product EE', 310.00),
(32, 'Product FF', 320.00),
(33, 'Product GG', 330.00),
(34, 'Product HH', 340.00),
(35, 'Product II', 350.00),
(36, 'Product JJ', 360.00),
(37, 'Product KK', 370.00),
(38, 'Product LL', 380.00),
(39, 'Product MM', 390.00),
(40, 'Product NN', 400.00);

-- Product Pricing:
-- Segment products into 3 price tiers and compare the sales performance of products in each tier.








CREATE TABLE income_distribution (
    individual_id INT,
    individual_name VARCHAR(255),
    income DECIMAL(10, 2)
);

INSERT INTO income_distribution (individual_id, individual_name, income) VALUES
(1, 'Alice', 30000.00),
(2, 'Bob', 32000.00),
(3, 'Charlie', 34000.00),
(4, 'David', 36000.00),
(5, 'Eva', 38000.00),
(6, 'Frank', 40000.00),
(7, 'Grace', 42000.00),
(8, 'Hannah', 44000.00),
(9, 'Ivy', 46000.00),
(10, 'Jack', 48000.00),
(11, 'Karen', 50000.00),
(12, 'Leo', 52000.00),
(13, 'Mia', 54000.00),
(14, 'Nathan', 56000.00),
(15, 'Olivia', 58000.00),
(16, 'Paul', 60000.00),
(17, 'Quincy', 62000.00),
(18, 'Rachel', 64000.00),
(19, 'Steve', 66000.00),
(20, 'Tina', 68000.00),
(21, 'Uma', 70000.00),
(22, 'Vera', 72000.00),
(23, 'Will', 74000.00),
(24, 'Xena', 76000.00),
(25, 'Yvonne', 78000.00),
(26, 'Zack', 80000.00),
(27, 'Amy', 82000.00),
(28, 'Brian', 84000.00),
(29, 'Chloe', 86000.00),
(30, 'Derek', 88000.00),
(31, 'Ella', 90000.00),
(32, 'Frankie', 92000.00),
(33, 'Gina', 94000.00),
(34, 'Henry', 96000.00),
(35, 'Irene', 98000.00),
(36, 'James', 100000.00),
(37, 'Kathy', 102000.00),
(38, 'Lucas', 104000.00),
(39, 'Molly', 106000.00),
(40, 'Nina', 108000.00);

-- Income Distribution:
-- Divide individuals into 5 income groups based on their earnings, and calculate the median income in each group.
-- SELECT FIVE_BUCKETS,
-- AVG(INCOME) AS AVG_INCOME
-- FROM(
-- 	SELECT *,
-- 	NTILE(5) OVER(ORDER BY INCOME DESC) AS FIVE_BUCKETS
-- 	FROM INCOME_DISTRIBUTION) AS X
-- GROUP BY FIVE_BUCKETS;










D














