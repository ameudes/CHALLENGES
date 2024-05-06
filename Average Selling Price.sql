-- Given Tables:
-- Table: Prices
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | start_date    | date    |
-- | end_date      | date    |
-- | price         | int     |
-- +---------------+---------+
-- (product_id, start_date, end_date) is the primary key for this table.
-- Each row indicates the price of a product in the period from start_date to end_date.

-- Table: UnitsSold
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | purchase_date | date    |
-- | units         | int     |
-- +---------------+---------+
-- Each row indicates the date, units, and product_id of each product sold.

-- Approach:
-- 1. We use a common table expression (CTE) to calculate the total revenue generated by each product.
-- 2. We join the Prices table with the UnitsSold table using the product_id, and check if the purchase_date falls within the range of start_date and end_date.
-- 3. We calculate the total revenue for each product by multiplying the price with the units sold, and then summing it up.
-- 4. We also calculate the total number of units sold for each product.
-- 5. Finally, we calculate the average selling price for each product by dividing the total revenue by the total units sold, rounded to 2 decimal places.

-- SQL Solution:
WITH CTE AS (
    SELECT 
        p.product_id,
        COALESCE(ROUND(SUM(p.price * u.units) / NULLIF(SUM(u.units), 0), 2), 0) AS average_price
    FROM Prices p
    LEFT JOIN UnitsSold u ON p.product_id = u.product_id AND u.purchase_date BETWEEN p.start_date AND p.end_date
    GROUP BY p.product_id
)
SELECT * FROM CTE;