CREATE DATABASE sales_analytics;
USE sales_analytics;
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL,
    order_date DATE,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
SHOW TABLES;
USE sales_analytics;
INSERT INTO customers (name, email) VALUES
('Amit Sharma', 'amit.sharma@gmail.com'),
('Neha Verma', 'neha.verma@gmail.com'),
('Rohit Singh', 'rohit.singh@gmail.com'),
('Pooja Patel', 'pooja.patel@gmail.com'),
('Karan Mehta', 'karan.mehta@gmail.com'),
('Sneha Iyer', 'sneha.iyer@gmail.com'),
('Arjun Malhotra', 'arjun.malhotra@gmail.com'),
('Riya Gupta', 'riya.gupta@gmail.com'),
('Vikas Rao', 'vikas.rao@gmail.com'),
('Ananya Das', 'ananya.das@gmail.com');
SELECT * FROM customers;

INSERT INTO products (product_name, price) VALUES
('Laptop', 55000),
('Smartphone', 25000),
('Headphones', 3000),
('Keyboard', 1500),
('Mouse', 800),
('Monitor', 12000),
('Tablet', 18000),
('Power Bank', 2000),
('Webcam', 3500),
('USB Hub', 1200);
SELECT * FROM products;
SELECT COUNT(*) FROM products;

INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2024-01-01'),
(2, 2, 2, '2024-01-02'),
(3, 3, 1, '2024-01-03'),
(4, 4, 2, '2024-01-04'),
(5, 5, 3, '2024-01-05'),

(1, 2, 1, '2024-01-06'),
(2, 3, 2, '2024-01-07'),
(3, 4, 1, '2024-01-08'),
(4, 5, 2, '2024-01-09'),
(5, 1, 1, '2024-01-10'),

(1, 3, 2, '2024-01-11'),
(2, 4, 1, '2024-01-12'),
(3, 5, 3, '2024-01-13'),
(4, 1, 1, '2024-01-14'),
(5, 2, 2, '2024-01-15'),

(1, 4, 1, '2024-01-16'),
(2, 5, 2, '2024-01-17'),
(3, 1, 1, '2024-01-18'),
(4, 2, 3, '2024-01-19'),
(5, 3, 1, '2024-01-20');
SELECT COUNT(*) FROM orders;
SELECT * FROM orders;

USE sales_analytics;
SELECT 
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    o.quantity,
    p.price,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

SELECT 
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    o.quantity,
    p.price,
    (o.quantity * p.price) AS total_amount,
    o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id;

SELECT 
    c.name AS customer_name,
    p.product_name,
    o.quantity,
    (o.quantity * p.price) AS total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
ORDER BY total_amount DESC;

SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name;

USE sales_analytics;
SELECT 
    SUM(o.quantity * p.price) AS total_store_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id;

SELECT 
    p.product_name,
    SUM(o.quantity) AS total_units_sold
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC
LIMIT 1;

SELECT 
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.quantity * p.price) AS total_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;

SELECT 
    c.name AS customer_name,
    SUM(o.quantity * p.price) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 1;

SELECT 
    o.order_date,
    SUM(o.quantity * p.price) AS daily_revenue
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY o.order_date
ORDER BY o.order_date;


















