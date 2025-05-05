CREATE TABLE inventory_data (
    product_id TEXT,
    product_name TEXT,
    category TEXT,
    unit_price NUMERIC,
    stock_quantity INT,
    stock_level TEXT,
    reorder_point INT,
    lead_time_days INT,
    last_restock_date DATE,
    supplier_id TEXT,
    warehouse_location TEXT,
    min_order_quantity INT,
    status TEXT,
    entry_date DATE,
    country TEXT,
    latitude NUMERIC,
    longitude NUMERIC
);

-- DATA CLEANING
-- Remove rows with missing essential values
DELETE FROM inventory_data
WHERE product_id IS NULL
   OR product_name IS NULL
   OR unit_price IS NULL;

-- Check for duplicates: each row is an unique SKU
SELECT product_id, COUNT(*)
FROM inventory_data
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Validate Data Ranges (e.g. Negative Prices)
SELECT *
FROM inventory_data
WHERE unit_price < 0 OR stock_quantity < 0;

-- Filter records with restock before April 2025 to avoid incorrect data
SELECT *
FROM inventory_data
WHERE last_restock_date < '2025-04-01';