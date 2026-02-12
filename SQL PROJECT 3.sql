CREATE DATABASE CustomerBehaviorDB;

USE CustomerBehaviorDB;

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE
);

CREATE TABLE user_name (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price INT
);

CREATE TABLE sales (
    user_id INT,
    product_id INT,
    created_date DATE
);

CREATE TABLE goldusers_signup (
    user_id INT,
    gold_signup_date DATE
);

INSERT INTO users (user_id, signup_date)
VALUES
(1,'2014-01-10'),
(2,'2015-02-15'),
(3,'2014-11-11'),
(4,'2016-05-01'),
(5,'2015-06-21'),
(6,'2016-07-12'),
(7,'2014-08-09'),
(8,'2014-08-09'),
(9,'2016-09-10'),
(10,'2016-09-10');

SELECT * FROM users

INSERT INTO user_name (user_id, user_name) 
VALUES
(1,'Ankit'),
(2,'Rohit'),
(3,'Ankur'),
(4,'Anand'),
(5,'Nitin'),
(6,'Saurabh'),
(7,'Vikram'),
(8,'Rahul'),
(9,'Amit'),
(10,'Vivek');

SELECT * FROM user_name

INSERT INTO product (product_id, product_name, price) 
VALUES
(1,'Dal Makhani',150),
(2,'Butter Chicken',280),
(3,'Fish Curry',320),
(4,'Paneer Butter Masala',250),
(5,'Chicken Biryani',300),
(6,'Mutton Biryani',450),
(7,'Veg Biryani',200),
(8,'Chole Bhature',120),
(9,'Rajma Chawal',140),
(10,'Masala Dosa',100),
(11,'Mango Lassi',80);

SELECT * FROM product

INSERT INTO sales (user_id, product_id, created_date) 
VALUES
(1,2,'2019-01-10'),
(1,3,'2019-02-10'),
(1,2,'2019-03-15'),
(2,1,'2018-01-15'),
(2,2,'2019-03-20'),
(2,2,'2019-04-10'),
(3,4,'2018-04-10'),
(3,5,'2019-06-12'),
(3,5,'2019-07-01'),
(4,6,'2019-07-18'),
(5,7,'2018-02-21'),
(5,8,'2019-08-15'),
(5,8,'2019-09-01'),
(6,9,'2018-03-30'),
(7,10,'2019-09-01'),
(7,10,'2019-09-10'),
(8,11,'2019-10-05'),
(9,2,'2019-11-20'),
(9,2,'2019-11-25'),
(10,5,'2019-12-25');

SELECT * FROM sales

INSERT INTO goldusers_signup (user_id, gold_signup_date) 
VALUES
(1,'2018-05-15'),
(3,'2017-09-20'),
(5,'2018-12-01'),
(7,'2019-03-10'),
(9,'2019-06-18');

SELECT * FROM goldusers_signup

Q1: Total revenue by each product
SELECT p.product_name,
       SUM(p.price) AS total_revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name;

Q2: Top 3 products by revenue
SELECT TOP 3 p.product_name,
       SUM(p.price) AS revenue
FROM sales s
JOIN product p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

Q3: Number of Gold users
SELECT COUNT(*) AS gold_user_count
FROM goldusers_signup;

Q4: Revenue from Gold users
SELECT SUM(p.price) AS gold_revenue
FROM sales s
JOIN goldusers_signup g ON s.user_id = g.user_id
JOIN product p ON s.product_id = p.product_id;

Q5: Total spend by each customer
SELECT u.user_name,
       SUM(p.price) AS total_spent
FROM sales s
JOIN user_name u ON s.user_id = u.user_id
JOIN product p ON s.product_id = p.product_id
GROUP BY u.user_name;






