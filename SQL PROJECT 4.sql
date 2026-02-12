CREATE DATABASE WorkforceDB;
GO

USE WorkforceDB;
GO


---------------------------------------------


CREATE TABLE workforce (
    work_year INT,
    experience_level VARCHAR(5),
    employment_type VARCHAR(5),
    job_title VARCHAR(100),
    salary DECIMAL(12,2),
    salary_currency VARCHAR(10),
    salary_in_usd DECIMAL(12,2),
    employee_residence VARCHAR(5),
    remote_ratio INT,
    company_location VARCHAR(5),
    company_size CHAR(1)
);


-------------------------------------------------


INSERT INTO workforce VALUES
(2023, 'SE', 'FT', 'Data Scientist', 120000, 'USD', 120000, 'US', 100, 'US', 'L'),
(2023, 'MI', 'FT', 'Data Analyst', 70000, 'USD', 70000, 'IN', 50, 'IN', 'M');

---------------------------------------------------

SELECT 
    company_size,
    COUNT(*) AS employee_count
FROM workforce
WHERE work_year = 2021
GROUP BY company_size;


-------------------------------------------------------

SELECT TOP 3
    job_title,
    AVG(salary_in_usd) AS avg_salary
FROM workforce
WHERE work_year = 2023
  AND employment_type = 'PT'
GROUP BY job_title
HAVING COUNT(*) > 50
ORDER BY avg_salary DESC;

-----------------------------------------------------

INSERT INTO workforce VALUES
-- ===== 2020 =====
(2020, 'EN', 'FT', 'Data Analyst', 45000, 'USD', 45000, 'IN', 0, 'IN', 'M'),
(2020, 'EN', 'FT', 'Data Scientist', 55000, 'USD', 55000, 'US', 50, 'US', 'L'),
(2020, 'MI', 'FT', 'Machine Learning Engineer', 85000, 'USD', 85000, 'US', 0, 'US', 'L'),
(2020, 'SE', 'FT', 'AI Engineer', 120000, 'USD', 120000, 'CA', 50, 'CA', 'L'),
(2020, 'EN', 'PT', 'Business Analyst', 30000, 'USD', 30000, 'IN', 0, 'IN', 'S'),

-- ===== 2021 =====
(2021, 'EN', 'FT', 'Data Analyst', 50000, 'USD', 50000, 'IN', 50, 'IN', 'M'),
(2021, 'MI', 'FT', 'Data Scientist', 90000, 'USD', 90000, 'US', 100, 'US', 'L'),
(2021, 'MI', 'PT', 'Data Engineer', 60000, 'USD', 60000, 'UK', 100, 'UK', 'M'),
(2021, 'SE', 'FT', 'ML Engineer', 130000, 'USD', 130000, 'US', 50, 'US', 'L'),
(2021, 'SE', 'FT', 'Project Manager', 110000, 'USD', 110000, 'AU', 0, 'AU', 'L'),

-- ===== 2022 =====
(2022, 'EN', 'FT', 'Data Analyst', 55000, 'USD', 55000, 'IN', 100, 'IN', 'M'),
(2022, 'MI', 'FT', 'Data Scientist', 95000, 'USD', 95000, 'US', 100, 'US', 'L'),
(2022, 'MI', 'FT', 'Analytics Manager', 105000, 'USD', 105000, 'CA', 50, 'CA', 'L'),
(2022, 'SE', 'FT', 'AI Manager', 145000, 'USD', 145000, 'US', 100, 'US', 'L'),
(2022, 'SE', 'PT', 'Consulting Manager', 90000, 'USD', 90000, 'UK', 100, 'UK', 'M'),

-- ===== 2023 =====
(2023, 'EN', 'FT', 'Data Analyst', 60000, 'USD', 60000, 'IN', 100, 'IN', 'M'),
(2023, 'EN', 'FT', 'Business Analyst', 65000, 'USD', 65000, 'AE', 50, 'AE', 'M'),
(2023, 'MI', 'FT', 'Data Scientist', 110000, 'USD', 110000, 'US', 100, 'US', 'L'),
(2023, 'MI', 'PT', 'Data Engineer', 80000, 'USD', 80000, 'UK', 100, 'UK', 'L'),
(2023, 'SE', 'FT', 'AI Engineer', 155000, 'USD', 155000, 'US', 100, 'US', 'L'),
(2023, 'SE', 'FT', 'Product Manager', 140000, 'USD', 140000, 'AU', 50, 'AU', 'L'),
(2023, 'SE', 'PT', 'Technical Manager', 95000, 'USD', 95000, 'CA', 100, 'CA', 'M'),

-- ===== 2024 =====
(2024, 'EN', 'FT', 'Data Analyst', 70000, 'USD', 70000, 'IN', 100, 'IN', 'M'),
(2024, 'MI', 'FT', 'Data Scientist', 125000, 'USD', 125000, 'US', 100, 'US', 'L'),
(2024, 'MI', 'FT', 'ML Engineer', 130000, 'USD', 130000, 'CA', 100, 'CA', 'L'),
(2024, 'SE', 'FT', 'AI Engineer', 180000, 'USD', 180000, 'US', 100, 'US', 'L'),
(2024, 'SE', 'FT', 'Engineering Manager', 170000, 'USD', 170000, 'AU', 100, 'AU', 'L');


-----------

SELECT * FROM workforce;

---------------------------------------------------------------------------

SELECT 
    employee_residence,
    AVG(salary_in_usd) AS country_avg_salary
FROM workforce
WHERE experience_level = 'MI'
  AND work_year = 2023
GROUP BY employee_residence
HAVING AVG(salary_in_usd) >
      (SELECT AVG(salary_in_usd)
       FROM workforce
       WHERE experience_level = 'MI'
         AND work_year = 2023);

         --------------------------------------------------------


SELECT 
    company_location,
    AVG(salary_in_usd) AS avg_salary
FROM workforce
WHERE experience_level = 'SE'
  AND work_year = 2023
GROUP BY company_location
ORDER BY avg_salary DESC;


---------------------------------------------------------

SELECT 
    a.job_title,
    ((AVG(b.salary_in_usd) - AVG(a.salary_in_usd)) 
     / AVG(a.salary_in_usd)) * 100 AS growth_percentage
FROM workforce a
JOIN workforce b
  ON a.job_title = b.job_title
WHERE a.work_year = 2023
  AND b.work_year = 2024
GROUP BY a.job_title;

---------------------------------------------------

SELECT TOP 3
    employee_residence,
    ((AVG(CASE WHEN work_year = 2023 THEN salary_in_usd END) -
      AVG(CASE WHEN work_year = 2020 THEN salary_in_usd END))
     / AVG(CASE WHEN work_year = 2020 THEN salary_in_usd END)) * 100
     AS growth_percentage
FROM workforce
WHERE experience_level = 'EN'
  AND work_year IN (2020, 2023)
GROUP BY employee_residence
HAVING COUNT(*) > 50
ORDER BY growth_percentage DESC;


---------------------------------------------------------

UPDATE workforce
SET remote_ratio = 100
WHERE salary_in_usd > 90000
  AND employee_residence IN ('US', 'AU');

  ---------------------------------------------------


  UPDATE workforce
SET salary_in_usd =
    CASE
        WHEN experience_level = 'SE' THEN salary_in_usd * 1.22
        WHEN experience_level = 'MI' THEN salary_in_usd * 1.30
        WHEN experience_level = 'EN' THEN salary_in_usd * 1.18
        ELSE salary_in_usd
    END
WHERE work_year = 2024;


-----------------------------------------------------------

SELECT job_title, work_year, avg_salary
FROM (
    SELECT 
        job_title,
        work_year,
        AVG(salary_in_usd) AS avg_salary,
        RANK() OVER (PARTITION BY job_title ORDER BY AVG(salary_in_usd) DESC) AS rnk
    FROM workforce
    GROUP BY job_title, work_year
) t
WHERE rnk = 1;


-------------------------------------------------------------

SELECT 
    job_title,
    SUM(CASE WHEN employment_type = 'FT' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS ft_percentage,
    SUM(CASE WHEN employment_type = 'PT' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS pt_percentage
FROM workforce
GROUP BY job_title;

--------------------------------------------------------------------

SELECT DISTINCT employee_residence
FROM workforce
WHERE job_title LIKE '%Manager%'
  AND salary_in_usd > 90000
  AND remote_ratio = 100;


  -----------------------------------------------------

  SELECT TOP 5
    company_location,
    COUNT(*) AS large_company_count
FROM workforce
WHERE company_size = 'L'
GROUP BY company_location
ORDER BY large_company_count DESC;

----------------------------------------------------------

SELECT 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM workforce) AS percentage_remote_high_salary
FROM workforce
WHERE remote_ratio = 100
  AND salary_in_usd > 100000;


  -------------------------------------------------


  SELECT 
    employee_residence,
    AVG(salary_in_usd) AS avg_salary
FROM workforce
WHERE experience_level = 'EN'
GROUP BY employee_residence
HAVING AVG(salary_in_usd) >
      (SELECT AVG(salary_in_usd)
       FROM workforce
       WHERE experience_level = 'EN');


       --------------------------------------------------

       SELECT job_title, employee_residence, avg_salary
FROM (
    SELECT 
        job_title,
        employee_residence,
        AVG(salary_in_usd) AS avg_salary,
        RANK() OVER (PARTITION BY job_title ORDER BY AVG(salary_in_usd) DESC) AS rnk
    FROM workforce
    GROUP BY job_title, employee_residence
) t
WHERE rnk = 1;

--------------------------------------------------------------

SELECT employee_residence
FROM workforce
WHERE work_year IN (2021, 2022, 2023)
GROUP BY employee_residence
HAVING 
    AVG(CASE WHEN work_year = 2021 THEN salary_in_usd END) <
    AVG(CASE WHEN work_year = 2022 THEN salary_in_usd END)
AND AVG(CASE WHEN work_year = 2022 THEN salary_in_usd END) <
    AVG(CASE WHEN work_year = 2023 THEN salary_in_usd END);


    --------------------------------------------------------------

    SELECT 
    experience_level,
    work_year,
    COUNT(CASE WHEN remote_ratio = 100 THEN 1 END) * 100.0 / COUNT(*) AS remote_percentage
FROM workforce
WHERE work_year IN (2021, 2024)
GROUP BY experience_level, work_year;


-------------------------------------------------------------------

SELECT 
    a.experience_level,
    a.job_title,
    ((AVG(b.salary_in_usd) - AVG(a.salary_in_usd)) / AVG(a.salary_in_usd)) * 100
        AS avg_increase_percentage
FROM workforce a
JOIN workforce b
  ON a.job_title = b.job_title
 AND a.experience_level = b.experience_level
WHERE a.work_year = 2023
  AND b.work_year = 2024
GROUP BY a.experience_level, a.job_title;
