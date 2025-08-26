CREATE DATABASE bike_store;
USE bike_store;

CREATE TABLE brand (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

CREATE TABLE category (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    email VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);

CREATE TABLE store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    street VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);


CREATE TABLE staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    active BOOLEAN,
    store_id INT,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (manager_id) REFERENCES staff(staff_id)
);

CREATE TABLE product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year YEAR,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE inventory (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_status VARCHAR(20),
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    store_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

SELECT * FROM brand;

-- Add indexes:
CREATE INDEX idx_product_brand ON product(brand_id);
CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_order_store ON orders(store_id);

SELECT * FROM product WHERE brand_id = 9;

-- Add constraint:
ALTER TABLE inventory
ADD CONSTRAINT chk_quantity CHECK (quantity >= 0);

-- Select products with price > 5000:
SELECT product_name, list_price FROM product WHERE list_price > 5000;

-- Joins
SELECT o.order_id, c.first_name, c.last_name, s.store_name
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN store s ON o.store_id = s.store_id;

-- Aggregations & Grouping
-- Total sales by store:
SELECT s.store_name, SUM(oi.quantity * oi.list_price * (1 - oi.discount/100)) AS total_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN store s ON o.store_id = s.store_id
GROUP BY s.store_name;

-- Subqueries
-- Find customers who spent more than $5000: 
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY customer_id
    HAVING SUM(oi.quantity * oi.list_price * (1 - oi.discount/100)) > 5000
);

-- Views
-- Create a view for sales summary:
CREATE VIEW sales_summary AS
SELECT o.order_id, c.first_name, c.last_name, s.store_name, 
       SUM(oi.quantity * oi.list_price * (1 - oi.discount/100)) AS total_order_value
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN store s ON o.store_id = s.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

SELECT * FROM sales_summary;

SELECT * 
FROM sales_summary
WHERE total_order_value > 5000
ORDER BY total_order_value DESC;

-- Stored Procedures / Functions
-- Example: Calculate total order value:
DELIMITER //
CREATE PROCEDURE get_order_total(IN orderId INT)
BEGIN
    SELECT SUM(quantity * list_price * (1 - discount/100)) AS total
    FROM order_items
    WHERE order_id = orderId;
END //
DELIMITER ;

CALL get_order_total(101);  

-- Triggers
-- Example: Update inventory after an order is inserted:
DELIMITER //
CREATE TRIGGER after_order_insert
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    UPDATE inventory
    SET quantity = quantity - NEW.quantity
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;

SHOW TRIGGERS;