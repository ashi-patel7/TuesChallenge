CREATE DATABASE onlineshop;
USE onlineshop;

-- CREATE TABLES --
CREATE TABLE users (
user_id int NOT NULL AUTO_INCREMENT,
forename varchar(60) NOT NULL,
surname varchar(60) NOT NULL,
email varchar(100) NOT NULL,
house_number int NOT NULL,
postcode varchar(10) NOT NULL,
PRIMARY KEY(user_id)
);

CREATE TABLE orders (
order_id int NOT NULL AUTO_INCREMENT,
fk_user_id int NOT NULL,
date_ordered datetime NOT NULL,
delivery_postcode varchar(10) NOT NULL,
status varchar(30) NOT NULL,
PRIMARY KEY(order_id),
FOREIGN KEY(fk_user_id) REFERENCES users(user_id)
);

CREATE TABLE products(
product_id int NOT NULL AUTO_INCREMENT,
product_name varchar(100) NOT NULL,
product_price decimal(4,2) NOT NULL,
stock int NOT NULL,
PRIMARY KEY(product_id)
);

CREATE TABLE orderline(
orderline_id int NOT NULL AUTO_INCREMENT,
fk_order_id int NOT NULL,
fk_product_id int NOT NULL,
order_value decimal(4,2) NOT NULL,
PRIMARY KEY(orderline_id),
FOREIGN KEY(fk_order_id) REFERENCES orders(order_id),
FOREIGN KEY(fk_product_id) REFERENCES products(product_id)
);


-- INSERT VALUES INTO TABLES --
INSERT INTO users (forename, surname, email, house_number, postcode) 
VALUES ('ashi', 'patel', 'ashipatel@email.com', 240, 'SM56OF'), ('john', 'hebbs', 'johnh@gmail.com', 54, 'LN5CTH'), ('Sarah', 'thomson', 'st98@email.co.uk', 78, 'CR6PL7'), ('luke', 'jones', 'lj66@email.com', 12, 'WTOH87'), ('Cameron', 'Lupoli', 'camlupoli@email.com', 10, 'FJS75N'), ('Alicia', 'Patternott', 'aliceolivia@email.co.uk', 14, 'AB5HR6'), ('Joe', 'Smith', 'jsmith78@email.com', 45, 'LS61HS');

INSERT INTO orders(fk_user_id, date_ordered, delivery_postcode, status)
VALUES (1, '21-01-22', 'SM5KDSF', 'processing'), (2, '14-11-21','LN5CTH', 'delivered'), (3, '07-01-22', 'CR6PL7', 'shipped'), (4, '19-01-22', 'WTOH87', 'processing'), (4, '09-12-21', 'WTOH87', 'delivered'), (5, '09-01-22', 'FJS75N', 'shipped'), (6, '09-12-21', 'AB5HR6', 'delivered'), (7, '19-12-21', 'LS61HS', 'shipped'), (7, '19-01-22', 'LS61HS', 'shipped'), (7, '19-12-21', 'LS61HS', 'delivered');

INSERT INTO products(product_name, product_price, stock)
VALUES ('fifa 2019', 60.99, 106), ('fifa 2020', 60.99, 70), ('fifa 2021', 70.99, 95), ('Call of Duty', 40.99, 50), ('Best game ever', 94.99, 150), ('Worlds best game', 70.99, 26), ('Ulitmate Game', 50.99, 80);

INSERT INTO orderline(fk_order_id, fk_product_id, order_value)
VALUES (1,1, 60.99), (1,4,40.99), (2,7, 50.99), (2,5, 94.99), (3,3,70.99), (4,4,40.99), (4,1, 60.99), (5,5, 94.99), (5,6, 70.99), (5,1,60.99), (6,4, 40.99), (7,7, 50.99), (7,1, 60.99);

-- UPDATE TABLES --
SET SQL_SAFE_UPDATES=0;

UPDATE users
SET forename='Ash'
WHERE forename='ashi'; 

UPDATE orders
SET delivery_postcode='SM56OF'
WHERE delivery_postcode='SM5KDSF';

SELECT * FROM users;
SELECT * FROM orders;
SELECT * FROM products;
SELECT * FROM orderline;

UPDATE products
SET product_name='Ultimate Game'
WHERE product_name='Ulitmate Game';

-- How many orders has user Smith placed? --
SELECT u.forename, u.surname, o.order_id, o.date_ordered
FROM users u
JOIN orders o ON u.user_id=o.fk_user_id
WHERE surname='Smith';

-- Max price of products --
SELECT MAX(product_price) FROM products;

-- Average price of products -- 
SELECT AVG(product_price) FROM products;

-- Average price of fifa products --
SELECT AVG(product_price) FROM products WHERE product_name LIKE 'fifa%'; 

-- What products did John Hebbs order? --
SELECT o.fk_order_id, o.order_value, p.product_name
FROM orderline o
JOIN products p ON o.fk_product_id=p.product_id
WHERE o.fk_order_id=2;

-- Who ordered the product Best Game Ever? --
SELECT o.fk_order_id, o.order_value, p.product_name
FROM orderline o
JOIN products p ON o.fk_product_id=p.product_id
WHERE product_name='Best Game Ever';

-- Number of users, products, orders the database contains --
SELECT COUNT(user_id) FROM users;
SELECT COUNT(product_id) FROM products;
SELECT COUNT(order_id) FROM orders;
SELECT COUNT(orderline_id) FROM orderline;

-- Number of products ordered above/below £60 --
SELECT COUNT(orderline_id) FROM orderline WHERE order_value>60;
SELECT COUNT(orderline_id) FROM orderline WHERE order_value<60;

-- Number of orders being delivered to postcodes beginning with L -- 
SELECT COUNT(order_id) FROM orders WHERE delivery_postcode LIKE 'L%';
SELECT * FROM orders WHERE delivery_postcode LIKE 'L%';

-- Order status --
SELECT * FROM orders WHERE status='shipped';
SELECT * FROM orders WHERE status='delivered';
SELECT * FROM orders WHERE status='processing';

-- Year ordered --
SELECT * FROM orders WHERE date_ordered LIKE '2019%';
SELECT COUNT(order_id) FROM orders WHERE date_ordered LIKE '2014%';

-- Top 3 Most/Least Expensive Products --
SELECT product_name, product_price FROM products ORDER BY product_price DESC LIMIT 3;
SELECT product_name, product_price FROM products ORDER BY product_price ASC LIMIT 3;

-- Order status and value of each product ordered --
SELECT o.status, o.order_id, o.fk_user_id, l.order_value
FROM orders o
JOIN orderline l ON o.order_id=l.fk_order_id;

-- Value of each product ordered that is still being shipped or processed --
SELECT o.status, o.order_id, o.fk_user_id, l.order_value
FROM orders o
JOIN orderline l ON o.order_id=l.fk_order_id
WHERE status IN ('shipped','processing');

-- Average price of order value -- 
SELECT AVG(order_value) FROM orderline;

-- Average price of order value on orders placed in 2009 --
SELECT AVG(l.order_value)
FROM orders o
JOIN orderline l ON o.order_id=l.fk_order_id
WHERE date_ordered LIKE '2009%';

-- DELETE RECORDS --
DELETE FROM orderline WHERE order_value=40.99;
SELECT * FROM orderline;

SET foreign_key_checks = 0;
DELETE FROM users WHERE user_id=1;
SELECT * FROM users;

DELETE FROM orders WHERE fk_user_id=1;
SELECT * FROM orders;

DELETE FROM products WHERE stock=70;
SELECT * FROM products;



