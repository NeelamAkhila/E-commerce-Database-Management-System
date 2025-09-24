create database ecommers;
use ecommers;
drop database ecommers;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    customer_email VARCHAR(100),
    customer_phone VARCHAR(20)
);

INSERT INTO customers (customer_name, customer_email, customer_phone) VALUES
('Akhil', 'akhil@example.com', '9876543210'),
('Neha', 'neha@example.com', '9876543211'),
('Ravi', 'ravi@example.com', '9876543212'),
('Priya', 'priya@example.com', '9876543213'),
('Kiran', 'kiran@example.com', '9876543214'),
('Deepa', 'deepa@example.com', '9876543215'),
('Manoj', 'manoj@example.com', '9876543216'),
('Sita', 'sita@example.com', '9876543217'),
('Arjun', 'arjun@example.com', '9876543218'),
('Divya', 'divya@example.com', '9876543219');


CREATE TABLE sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(100),
    seller_email VARCHAR(100)
);

INSERT INTO sellers (seller_name, seller_email) VALUES
('Seller1', 'seller1@example.com'),
('Seller2', 'seller2@example.com'),
('Seller3', 'seller3@example.com'),
('Seller4', 'seller4@example.com'),
('Seller5', 'seller5@example.com'),
('Seller6', 'seller6@example.com'),
('Seller7', 'seller7@example.com'),
('Seller8', 'seller8@example.com'),
('Seller9', 'seller9@example.com'),
('Seller10', 'seller10@example.com');


CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    seller_id INT,
    FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

INSERT INTO products (product_name, price, seller_id) VALUES
('Laptop', 60000.00, 1),
('Smartphone', 25000.00, 2),
('Tablet', 15000.00, 3),
('Headphones', 2000.00, 4),
('Keyboard', 1200.00, 5),
('Mouse', 800.00, 6),
('Monitor', 9000.00, 7),
('Printer', 7000.00, 8),
('Camera', 40000.00, 9),
('Smartwatch', 5000.00, 10);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (customer_id, order_date, status) VALUES
(1, '2023-01-15', 'Delivered'),
(2, '2023-05-20', 'Shipped'),
(3, '2024-02-10', 'Pending'),
(4, '2024-07-18', 'Delivered'),
(5, '2024-12-05', 'Cancelled'),
(6, '2025-03-22', 'Shipped'),
(7, '2025-06-30', 'Delivered'),
(8, '2025-08-14', 'Pending'),
(9, '2025-11-09', 'Delivered'),
(10, '2025-12-25', 'Shipped');



CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 3),
(5, 5, 1),
(6, 6, 2),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 2);


CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    status VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO payments (order_id, amount, payment_method, status) VALUES
(1, 60000.00, 'Credit Card', 'Paid'),
(2, 50000.00, 'UPI', 'Paid'),
(3, 15000.00, 'Cash', 'Pending'),
(4, 6000.00, 'Credit Card', 'Paid'),
(5, 1200.00, 'UPI', 'Refunded'),
(6, 1600.00, 'Cash', 'Paid'),
(7, 9000.00, 'Credit Card', 'Paid'),
(8, 7000.00, 'UPI', 'Pending'),
(9, 40000.00, 'Debit Card', 'Paid'),
(10, 10000.00, 'UPI', 'Paid');


CREATE TABLE geolocation (
    geo_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO geolocation (customer_id, address, city, state) VALUES
(1, 'Street 1', 'Hyderabad', 'Telangana'),
(2, 'Street 2', 'Chennai', 'Tamil Nadu'),
(3, 'Street 3', 'Bangalore', 'Karnataka'),
(4, 'Street 4', 'Pune', 'Maharashtra'),
(5, 'Street 5', 'Delhi', 'Delhi'),
(6, 'Street 6', 'Kochi', 'Kerala'),
(7, 'Street 7', 'Jaipur', 'Rajasthan'),
(8, 'Street 8', 'Ahmedabad', 'Gujarat'),
(9, 'Street 9', 'Lucknow', 'Uttar Pradesh'),
(10, 'Street 10', 'Patna', 'Bihar');


CREATE TABLE order_review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    rating INT,
    comments VARCHAR(200),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO order_review (order_id, rating, comments) VALUES
(1, 5, 'Excellent product!'),
(2, 4, 'Very good quality.'),
(3, 3, 'Average experience.'),
(4, 5, 'Superb service.'),
(5, 2, 'Not satisfied.'),
(6, 4, 'Worth the price.'),
(7, 5, 'Highly recommend.'),
(8, 3, 'Okay product.'),
(9, 5, 'Loved it!'),
(10, 4, 'Good product.');

select * 
from customers
limit 4;

# set time between range which the order is placed
SELECT 
    MIN(order_date) AS start_date,
    MAX(order_date) AS end_date
FROM orders;

#count the cities & states of customers during given period
SELECT g.city,g.state,
COUNT(DISTINCT g.customer_id) AS total_customers
FROM orders o
JOIN geolocation g ON o.customer_id = g.customer_id
WHERE o.order_date BETWEEN '2023-09-01' AND '2024-09-05'
GROUP BY g.city, g.state;

#is there a growing trend in the no of orders placed over past years
SELECT 
    YEAR(order_date) AS order_year,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date)
ORDER BY order_year;

#Total Revenue by Year and Payment Status
SELECT 
    YEAR(o.order_date) AS order_year,
    p.status AS payment_status,
    SUM(p.amount) AS total_revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY YEAR(o.order_date), p.status
ORDER BY order_year, total_revenue DESC;

#Best-Selling Products with Quantity Sold

SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 5;

#Average Order Value (AOV) per Customer
SELECT 
    c.customer_name,
    ROUND(AVG(p.amount), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'Paid'
GROUP BY c.customer_id, c.customer_name
ORDER BY avg_order_value DESC;

#No. of Orders per Customer
SELECT 
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

#Rating Analysis – Average Review Score per Seller
SELECT 
    s.seller_name,
    ROUND(AVG(r.rating), 2) AS avg_rating
FROM sellers s
JOIN products p ON s.seller_id = p.seller_id
JOIN order_items oi ON p.product_id = oi.product_id
JOIN order_review r ON oi.order_id = r.order_id
GROUP BY s.seller_id, s.seller_name
ORDER BY avg_rating DESC;

#City-wise Revenue Contribution
SELECT 
    g.city,
    g.state,
    SUM(p.amount) AS total_revenue
FROM geolocation g
JOIN customers c ON g.customer_id = c.customer_id
JOIN orders o ON c.customer_id = o.customer_id
JOIN payments p ON o.order_id = p.order_id
WHERE p.status = 'Paid'
GROUP BY g.city, g.state
ORDER BY total_revenue DESC;

#Monthly Trend of Orders (Year + Month)
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY year, month;



