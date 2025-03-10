-- CREATE DATABASE ecommerce_db;

-- SELECT * FROM e_commerce_sales

-- Remove Duplicates
-- SET sql_safe_updates=0
-- DELETE FROM e_commerce_sales
-- WHERE `Customer ID` IN (
--     SELECT `Customer ID` FROM (
--         SELECT `Customer ID`, ROW_NUMBER() OVER (PARTITION BY `Customer ID`, `Order Date` ORDER BY `Customer ID`) AS row_num
--         FROM e_commerce_sales
--     ) AS temp
--     WHERE row_num > 1
-- );

-- Handle Missing Values
-- SET @mode_region = (
--     SELECT region 
--     FROM (
--         SELECT region, COUNT(region) AS count 
--         FROM e_commerce_sales 
--         GROUP BY region 
--         ORDER BY count DESC 
--         LIMIT 1
--     ) AS subquery
-- );
-- SET sql_safe_updates=0
-- UPDATE e_commerce_sales
-- SET region = @mode_region
-- WHERE region='';


-- SET @mode_shipping = (
--     SELECT `Shipping Status`
--     FROM (
--         SELECT `Shipping Status`, COUNT(`Shipping Status`) AS count 
--         FROM e_commerce_sales 
--         GROUP BY `Shipping Status` 
--         ORDER BY count DESC 
--         LIMIT 1
--     ) AS subquery
-- );
-- UPDATE e_commerce_sales
-- SET `Shipping Status` = @mode_shipping
-- WHERE `Shipping Status`='';

-- SET @avg_age = (
--     SELECT AVG(age) 
--     FROM e_commerce_sales 
--     WHERE age IS NOT NULL
-- );
-- UPDATE e_commerce_sales
-- SET age = @avg_age
-- WHERE age ='';

-- add new column
-- ALTER TABLE e_commerce_sales 
-- ADD COLUMN repeat_buyer BOOLEAN;
-- UPDATE e_commerce_sales
-- SET repeat_buyer = 
--     CASE 
--         WHEN `Customer ID` IN (
--             SELECT `Customer ID` FROM (
--                 SELECT `Customer ID` FROM e_commerce_sales GROUP BY `Customer ID` HAVING COUNT(*) > 1
--             ) AS subquery
--         ) 
--         THEN 1 ELSE 0
--     END;

-- Create New Table for Cleaned Data
-- CREATE TABLE cleaned_ecommerce_sales AS 
-- SELECT * FROM e_commerce_sales;

-- SELECT * FROM cleaned_ecommerce_sales
-- INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/cleaned_ecommerce_sales.csv'
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"' 
-- LINES TERMINATED BY '\n';




   