-- init/init.sql

-- Creating a users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserting data into the users table
INSERT INTO users (username, email)
SELECT
    concat('user_', generate_series(1, 1000000)),
    concat('user_', generate_series(1, 1000000), '@example.com');

-- Create a product table
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data into the products table
INSERT INTO products (name, description, price)
SELECT
    concat('Product_', generate_series(1, 1000000)),
    'Description for Product ' || generate_series(1, 1000000),
    round((random() * 100)::numeric, 2);

-- Create a orders table
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert data into the orders table
INSERT INTO orders (user_id, product_id, quantity, total_price)
SELECT
    (SELECT id FROM users ORDER BY random() LIMIT 1),
    (SELECT id FROM products ORDER BY random() LIMIT 1),
    (random() * 10 + 1)::INT,
    round((random() * 500 + 50)::numeric, 2)
FROM generate_series(1, 500000);