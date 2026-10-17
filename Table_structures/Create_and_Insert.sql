CREATE DATABASE sql_engineering_lab;


-- SESSION 01: Database schema

CREATE TABLE customers (
    customer_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    city VARCHAR(80) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    stock_quantity INT NOT NULL DEFAULT 0
        CHECK (stock_quantity >= 0)
);

CREATE TABLE orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id INT NOT NULL
        REFERENCES customers(customer_id),
    order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE order_items (
    order_id INT NOT NULL REFERENCES orders(order_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10, 2) NOT NULL CHECK (unit_price > 0),

    PRIMARY KEY (order_id, product_id)
);



INSERT INTO customers (full_name, email, city)
VALUES
    ('Aarav Sharma', 'aarav@example.com', 'Bengaluru'),
    ('Priya Nair', 'priya@example.com', 'Chennai'),
    ('Rahul Verma', 'rahul@example.com', 'Hyderabad'),
    ('Sneha Rao', 'sneha@example.com', 'Bengaluru'),
    ('Vikram Patel', 'vikram@example.com', 'Mumbai');

INSERT INTO products (product_name, category, price, stock_quantity)
VALUES
    ('Laptop', 'Electronics', 65000.00, 10),
    ('Keyboard', 'Electronics', 2500.00, 40),
    ('Office Chair', 'Furniture', 8500.00, 15),
    ('Monitor', 'Electronics', 18000.00, 20),
    ('Desk', 'Furniture', 12000.00, 8);

INSERT INTO orders (customer_id, order_date, status)
VALUES
    (1, '2026-09-01 10:00:00+05:30', 'Delivered'),
    (1, '2026-09-05 14:30:00+05:30', 'Shipped'),
    (2, '2026-09-06 11:00:00+05:30', 'Delivered'),
    (3, '2026-09-10 16:00:00+05:30', 'Pending'),
    (4, '2026-09-12 09:15:00+05:30', 'Cancelled');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES
    (1, 1, 1, 65000.00),
    (1, 2, 2, 2500.00),
    (2, 4, 1, 18000.00),
    (2, 2, 1, 2500.00),
    (3, 3, 2, 8500.00),
    (4, 5, 1, 12000.00),
    (4, 2, 2, 2500.00),
    (5, 3, 1, 8500.00);
