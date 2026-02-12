CREATE DATABASE SupplyChainFinanceManagement;
GO

USE SupplyChainFinanceManagement;
GO


CREATE TABLE dim_customer (
    customer_code INT PRIMARY KEY,
    customer_name VARCHAR(100),
    market VARCHAR(50),
    region VARCHAR(50),
    channel VARCHAR(50)
);



CREATE TABLE dim_product (
    product_code VARCHAR(20) PRIMARY KEY,
    product_name VARCHAR(100),
    variant VARCHAR(50),
    category VARCHAR(50)
);



CREATE TABLE fact_forecast_monthly (
    date DATE,
    fiscal_year INT,
    product_code VARCHAR(20),
    forecast_quantity INT,
    PRIMARY KEY (date, product_code),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);


CREATE TABLE fact_freight_cost (
    market VARCHAR(50),
    fiscal_year INT,
    freight_cost DECIMAL(10,2),
    PRIMARY KEY (market, fiscal_year)
);



CREATE TABLE fact_gross_price (
    product_code VARCHAR(20),
    fiscal_year INT,
    gross_price DECIMAL(10,2),
    PRIMARY KEY (product_code, fiscal_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);



CREATE TABLE fact_manufacturing_cost (
    product_code VARCHAR(20),
    fiscal_year INT,
    manufacturing_cost DECIMAL(10,2),
    PRIMARY KEY (product_code, fiscal_year),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);


CREATE TABLE fact_post_invoice_deductions (
    customer_code INT,
    product_code VARCHAR(20),
    date DATE,
    post_invoice_discount DECIMAL(10,2),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);


CREATE TABLE fact_pre_invoice_deductions (
    customer_code INT,
    fiscal_year INT,
    pre_invoice_discount_pct DECIMAL(5,2),
    PRIMARY KEY (customer_code, fiscal_year),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code)
);


CREATE TABLE fact_sales_monthly (
    date DATE,
    fiscal_year INT,
    customer_code INT,
    product_code VARCHAR(20),
    sold_quantity INT,
    PRIMARY KEY (date, customer_code, product_code),
    FOREIGN KEY (customer_code) REFERENCES dim_customer(customer_code),
    FOREIGN KEY (product_code) REFERENCES dim_product(product_code)
);

-----------------------------------------------------
      -----TASK 2------

    
INSERT INTO dim_customer VALUES
(1001, 'Croma', 'India', 'APAC', 'Retailer'),
(1002, 'Reliance Digital', 'India', 'APAC', 'Retailer'),
(1003, 'Amazon India', 'India', 'APAC', 'E-Commerce'),
(1004, 'Flipkart', 'India', 'APAC', 'E-Commerce'),
(1005, 'AtliQ Exclusive Store', 'India', 'APAC', 'Direct');


INSERT INTO dim_product VALUES
('P001', 'Wireless Mouse', 'Black', 'Accessories'),
('P002', 'Mechanical Keyboard', 'RGB', 'Accessories'),
('P003', 'Laptop', 'i5 16GB', 'Computers'),
('P004', 'Printer', 'Laser', 'Office');


INSERT INTO fact_gross_price VALUES
('P001', 2023, 30),
('P002', 2023, 80),
('P003', 2023, 900),
('P004', 2023, 200);


INSERT INTO fact_pre_invoice_deductions VALUES
(1001, 2023, 5.00),
(1002, 2023, 6.50),
(1003, 2023, 7.00),
(1004, 2023, 6.00),
(1005, 2023, 4.00);


INSERT INTO fact_post_invoice_deductions VALUES
(1001, 'P001', '2023-07-01', 3),
(1002, 'P002', '2023-07-01', 5),
(1003, 'P003', '2023-07-01', 20),
(1004, 'P004', '2023-07-01', 8);


INSERT INTO fact_manufacturing_cost VALUES
('P001', 2023, 20),
('P002', 2023, 50),
('P003', 2023, 700),
('P004', 2023, 150);


INSERT INTO fact_freight_cost VALUES
('India', 2023, 2.50),
('USA', 2023, 6.00),
('Europe', 2023, 5.50);


INSERT INTO fact_sales_monthly VALUES
('2023-07-01', 2023, 1001, 'P001', 500),
('2023-07-01', 2023, 1002, 'P002', 300),
('2023-07-01', 2023, 1003, 'P003', 100),
('2023-07-01', 2023, 1004, 'P004', 150);



INSERT INTO fact_forecast_monthly VALUES
('2023-07-01', 2023, 'P001', 550),
('2023-07-01', 2023, 'P002', 320),
('2023-07-01', 2023, 'P003', 120),
('2023-07-01', 2023, 'P004', 180);

---------------------------------------------------------
            -- TASK 3

SELECT 
    calendar_date = '2023-07-15',
    fiscal_year =
    CASE 
        WHEN MONTH('2023-07-15') >= 9 
        THEN YEAR('2023-07-15') + 1
        ELSE YEAR('2023-07-15')
    END;
--------------------------------------------------------

    SELECT
    s.date,
    p.product_code,
    p.product_name,
    p.variant,
    s.sold_quantity,
    g.gross_price,
    (s.sold_quantity * g.gross_price) AS gross_price_total
FROM fact_sales_monthly s
JOIN dim_product p
    ON s.product_code = p.product_code
JOIN fact_gross_price g
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
JOIN dim_customer c
    ON s.customer_code = c.customer_code
WHERE
    c.customer_code = 1001
    AND s.fiscal_year = 2023;

    ------------------------------------------------
    ---- TASK 4

    SELECT
    product_code,
    fiscal_year,
    MONTH(date) AS sales_month,
    SUM(sold_quantity) AS total_quantity
FROM fact_sales_monthly
GROUP BY product_code, fiscal_year, MONTH(date)
ORDER BY product_code, sales_month;

----------------------------------------------------------

SELECT
    c.customer_name,
    SUM(s.sold_quantity * g.gross_price) AS total_revenue
FROM fact_sales_monthly s
JOIN dim_customer c ON s.customer_code = c.customer_code
JOIN fact_gross_price g 
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
GROUP BY c.customer_name
ORDER BY total_revenue DESC;

----------------------------------------------------------

SELECT
    p.product_name,
    SUM(s.sold_quantity) AS total_units_sold,
    SUM(s.sold_quantity * g.gross_price) AS revenue
FROM fact_sales_monthly s
JOIN dim_product p ON s.product_code = p.product_code
JOIN fact_gross_price g 
    ON s.product_code = g.product_code
    AND s.fiscal_year = g.fiscal_year
GROUP BY p.product_name
ORDER BY revenue DESC;

------------------------------------------------------------

SELECT
    product_code,
    SUM(forecast_quantity) AS total_forecast
FROM fact_forecast_monthly
GROUP BY product_code
ORDER BY total_forecast DESC;

-----------------------------------------------------

SELECT
    p.product_name,
    g.gross_price,
    m.manufacturing_cost,
    (g.gross_price - m.manufacturing_cost) AS profit_per_unit
FROM fact_gross_price g
JOIN fact_manufacturing_cost m
    ON g.product_code = m.product_code
    AND g.fiscal_year = m.fiscal_year
JOIN dim_product p ON g.product_code = p.product_code
ORDER BY profit_per_unit DESC;

------------------------------------------------------------


SELECT
    customer_code,
    fiscal_year,
    AVG(pre_invoice_discount_pct) AS avg_discount
FROM fact_pre_invoice_deductions
GROUP BY customer_code, fiscal_year;

--------------------------------------------------

SELECT
    market,
    AVG(freight_cost) AS avg_freight_cost
FROM fact_freight_cost
GROUP BY market;

------------------------------------------------------

SELECT
    MONTH(date) AS sales_month,
    SUM(sold_quantity) AS total_sales
FROM fact_sales_monthly
GROUP BY MONTH(date)
ORDER BY sales_month;


---------------------------------------------------------

SELECT
    customer_code,
    COUNT(DISTINCT date) AS purchase_frequency,
    SUM(sold_quantity) AS total_quantity
FROM fact_sales_monthly
GROUP BY customer_code
ORDER BY purchase_frequency DESC;

-------------------------------------------------------------


SELECT
    s.product_code,
    s.date,
    f.forecast_quantity,
    s.sold_quantity,
    (s.sold_quantity * 100.0 / f.forecast_quantity) AS forecast_accuracy_pct
FROM fact_sales_monthly s
JOIN fact_forecast_monthly f
    ON s.product_code = f.product_code
    AND s.date = f.date;
         

---------------------------------------------------------------

      ------TASK 5-------------

 CREATE FUNCTION dbo.fn_total_forecast_qty
(
    @product_code VARCHAR(20),
    @fiscal_year INT
)
RETURNS INT
AS
BEGIN
    DECLARE @total_qty INT;

    SELECT @total_qty = SUM(forecast_quantity)
    FROM fact_forecast_monthly
    WHERE product_code = @product_code
      AND fiscal_year = @fiscal_year;

    RETURN @total_qty;
END;

------------------------------------------------------

SELECT customer_code
FROM fact_sales_monthly
GROUP BY customer_code
HAVING SUM(sold_quantity) >
(
    SELECT AVG(sold_quantity)
    FROM fact_sales_monthly
);

--------------------------------------------

CREATE PROCEDURE sp_update_gross_price
    @product_code VARCHAR(20),
    @fiscal_year INT,
    @new_price DECIMAL(10,2)
AS
BEGIN
    UPDATE fact_gross_price
    SET gross_price = @new_price
    WHERE product_code = @product_code
      AND fiscal_year = @fiscal_year;
END;

----------------------------------------

CREATE TABLE sales_audit_log (
    audit_id INT IDENTITY PRIMARY KEY,
    sale_date DATE,
    product_code VARCHAR(20),
    quantity INT,
    created_at DATETIME DEFAULT GETDATE()
);


CREATE TRIGGER trg_sales_audit
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    INSERT INTO sales_audit_log (sale_date, product_code, quantity)
    SELECT date, product_code, sold_quantity
    FROM inserted;
END;

---------------------------------------------------------------------


SELECT
    product_code,
    fiscal_year,
    sold_quantity,
    RANK() OVER (PARTITION BY fiscal_year ORDER BY sold_quantity DESC) AS sales_rank
FROM fact_sales_monthly;

-------------------------------------------------------------

SELECT
    s.product_code,
    STRING_AGG(c.customer_name, ', ') AS customers
FROM fact_sales_monthly s
JOIN dim_customer c ON s.customer_code = c.customer_code
GROUP BY s.product_code;


-------------------------------------------------------------

CREATE FUNCTION dbo.fn_total_manufacturing_cost
(
    @product_code VARCHAR(20),
    @start_year INT,
    @end_year INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total_cost DECIMAL(10,2);

    SELECT @total_cost = SUM(manufacturing_cost)
    FROM fact_manufacturing_cost
    WHERE product_code = @product_code
      AND fiscal_year BETWEEN @start_year AND @end_year;

    RETURN @total_cost;
END;


-----------------------------------------------------------

ALTER TABLE dim_product ADD inventory_qty INT DEFAULT 1000;


CREATE PROCEDURE sp_insert_sale
(
    @date DATE,
    @fiscal_year INT,
    @customer_code INT,
    @product_code VARCHAR(20),
    @qty INT
)
AS
BEGIN
    INSERT INTO fact_sales_monthly
    VALUES (@date, @fiscal_year, @customer_code, @product_code, @qty);
END;



CREATE TRIGGER trg_inventory_check
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    UPDATE dim_product
    SET inventory_qty = inventory_qty - i.sold_quantity
    FROM dim_product p
    JOIN inserted i ON p.product_code = i.product_code;
END;


----------------------------------------------------------


SELECT
    product_code,
    date,
    sold_quantity,
    LAG(sold_quantity) OVER (PARTITION BY product_code ORDER BY date) AS prev_month_sales
FROM fact_sales_monthly;

----------------------------------------------------------------

SELECT *
FROM (
    SELECT
        c.market,
        s.product_code,
        SUM(s.sold_quantity) AS total_sales,
        RANK() OVER (PARTITION BY c.market ORDER BY SUM(s.sold_quantity) DESC) AS rnk
    FROM fact_sales_monthly s
    JOIN dim_customer c ON s.customer_code = c.customer_code
    GROUP BY c.market, s.product_code
) x
WHERE rnk = 1;

-------------------------------------------------------------------

CREATE FUNCTION dbo.fn_total_freight_cost
(
    @market VARCHAR(50),
    @fiscal_year INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @cost DECIMAL(10,2);

    SELECT @cost = freight_cost
    FROM fact_freight_cost
    WHERE market = @market
      AND fiscal_year = @fiscal_year;

    RETURN @cost;
END;


-------------------------------------------------------------

CREATE TRIGGER trg_inventory_check1
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    UPDATE dim_product
    SET inventory_qty = inventory_qty - i.sold_quantity
    FROM dim_product p
    JOIN inserted i ON p.product_code = i.product_code;
END;


--------------------------------------------------------------

CREATE TRIGGER trg_product_validation
ON fact_sales_monthly
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN dim_product p
        ON i.product_code = p.product_code
        WHERE p.product_code IS NULL
    )
    BEGIN
        RAISERROR ('Invalid product code', 16, 1);
        ROLLBACK;
        RETURN;
    END

    INSERT INTO fact_sales_monthly
    SELECT * FROM inserted;
END;


---------------------------------------------------------------


SELECT
    product_code,
    date,
    sold_quantity,
    (sold_quantity - LAG(sold_quantity) OVER (PARTITION BY product_code ORDER BY date))
    * 100.0 / LAG(sold_quantity) OVER (PARTITION BY product_code ORDER BY date)
    AS mom_growth_pct
FROM fact_sales_monthly;

--------------------------------------------------------------


CREATE FUNCTION dbo.fn_avg_discount
(
    @product_code VARCHAR(20)
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @avg_discount DECIMAL(5,2);

    SELECT @avg_discount = AVG(pre_invoice_discount_pct)
    FROM fact_pre_invoice_deductions;

    RETURN @avg_discount;
END;

------------------------------------------------------------


SELECT *
FROM (
    SELECT
        c.region,
        c.customer_name,
        SUM(s.sold_quantity) AS total_qty,
        RANK() OVER (PARTITION BY c.region ORDER BY SUM(s.sold_quantity) DESC) AS rnk
    FROM fact_sales_monthly s
    JOIN dim_customer c ON s.customer_code = c.customer_code
    GROUP BY c.region, c.customer_name
) t
WHERE rnk = 1;


-----------------------------------------------------------------------


CREATE PROCEDURE sp_total_revenue
(
    @start_date DATE,
    @end_date DATE
)
AS
BEGIN
    SELECT
        SUM(s.sold_quantity * g.gross_price) AS total_revenue
    FROM fact_sales_monthly s
    JOIN fact_gross_price g
        ON s.product_code = g.product_code
        AND s.fiscal_year = g.fiscal_year
    WHERE s.date BETWEEN @start_date AND @end_date;
END;


---------------------------------------------------------------


CREATE TRIGGER trg_auto_forecast
ON dim_product
AFTER INSERT
AS
BEGIN
    INSERT INTO fact_forecast_monthly
    SELECT
        GETDATE(),
        YEAR(GETDATE()),
        product_code,
        100
    FROM inserted;
END;

-------------------------------------------------------------------

CREATE TABLE sales_outliers (
    product_code VARCHAR(20),
    date DATE,
    sold_quantity INT
);


CREATE TRIGGER trg_sales_outlier
ON fact_sales_monthly
AFTER INSERT
AS
BEGIN
    INSERT INTO sales_outliers
    SELECT i.product_code, i.date, i.sold_quantity
    FROM inserted i
    WHERE i.sold_quantity >
    (
        SELECT AVG(sold_quantity) * 2 FROM fact_sales_monthly
    );
END;

------------------------------------------------------------


SELECT product_code, AVG(gross_price) AS avg_price
FROM fact_gross_price
GROUP BY product_code
ORDER BY avg_price DESC;

--------------------------------------------------------------

 -----------TASK 6---------


 SELECT
    s.product_code,
    s.fiscal_year,
    MONTH(s.date) AS sales_month,
    f.forecast_quantity,
    s.sold_quantity
FROM fact_sales_monthly s
LEFT JOIN fact_forecast_monthly f
    ON s.product_code = f.product_code
    AND s.date = f.date
WHERE s.product_code = 'P001'
ORDER BY fiscal_year, sales_month;

------------------------------------------------------------------


SELECT
    fiscal_year,
    sales_month,
    SUM(forecast_quantity) AS forecast_qty,
    SUM(sold_quantity) AS actual_qty
FROM (
    SELECT
        s.fiscal_year,
        MONTH(s.date) AS sales_month,
        f.forecast_quantity,
        s.sold_quantity
    FROM fact_sales_monthly s
    LEFT JOIN fact_forecast_monthly f
        ON s.product_code = f.product_code
        AND s.date = f.date
    WHERE s.product_code = 'P001'
) t
GROUP BY fiscal_year, sales_month
ORDER BY fiscal_year, sales_month;

---------------------------------------------------------------


SELECT
    fiscal_year,
    sales_month,
    forecast_qty,
    actual_qty,
    CASE 
        WHEN forecast_qty = 0 OR forecast_qty IS NULL
        THEN NULL
        ELSE ROUND((actual_qty * 100.0 / forecast_qty), 2)
    END AS forecast_accuracy_pct
FROM (
    SELECT
        s.fiscal_year,
        MONTH(s.date) AS sales_month,
        SUM(f.forecast_quantity) AS forecast_qty,
        SUM(s.sold_quantity) AS actual_qty
    FROM fact_sales_monthly s
    LEFT JOIN fact_forecast_monthly f
        ON s.product_code = f.product_code
        AND s.date = f.date
    WHERE s.product_code = 'P001'
    GROUP BY s.fiscal_year, MONTH(s.date)
) x
ORDER BY fiscal_year, sales_month;


