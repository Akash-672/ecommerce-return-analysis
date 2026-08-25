use ecommerce_return_analysis;

select count(*) from raw_orders;
select count(*) from cleaned_orders;

/*
create table cleaned_orders as 
select * from raw_orders

The purpose is to keep the raw data untouched so we created the new table
*/ 

select * from cleaned_orders
limit 100;

select * from raw_orders
limit 500;

describe cleaned_orders; -- this will check the datatype

# check the duplicates

select order_id, count(*) as duplicate
from cleaned_orders
group by order_id
having count(*) > 1;

-- OR using window function and CTE's

with duplicate_check as(

select order_id, row_number() over(partition by order_id order by order_id) as row_num
from cleaned_orders
)
select *
from duplicate_check
where row_num > 1;

-- Results no duplicates in the order_id


-- Checking the null values in each columns

select 
sum(order_id is null) as missing_order_id,
sum(customer_id is null) as missing_customer_id,
sum(product_id is null) as missing_product_id,
sum(category is null) as missing_category,
sum(price is null) as missing_price,
sum(discount is null) as missing_discount,
sum(quantity is null) as missing_quantity,
sum(payment_method is null) as missing_payment_method,
sum(order_date is null) as missing_order_date,
sum(delivered_date is null) as missing_delivered_date,
sum(region is null) as missing_region,
sum(returned is null) as missing_returned,
sum(request_date is null) as missing_request_date,
sum(return_reason is null) as missing_return_reason,
sum(total_amount is null) as missing_total_amount,
sum(shipping_cost is null) as missing_shipping_cost,
sum(profit_margin is null) as missing_profit_margin,
sum(customer_age is null) as missing_customer_age,
sum(customer_gender is null) as missing_customer_gender
from cleaned_orders;

# Results no null values found

-- check the blank values and text values

select 
sum(trim(order_id)='') as blank_order_id,
sum(trim(customer_id)='') as blank_customer_id,
sum(trim(product_id)='') as blank_product_id,
sum(trim(category)='') as blank_category,
sum(trim(price)='') as blank_price,
sum(trim(discount)='')as blank_discount,
sum(trim(quantity)='')as blank_quantity,
sum(trim(payment_method)='')as blank_payment_method,
sum(trim(order_date)='')as blank_order_date,
sum(trim(delivered_date)='')as blank_delivered_date,
sum(trim(region)='')as blank_region,
sum(trim(returned)='')as blank_returned,
sum(trim(request_date)='')as blank_request_date,
sum(trim(return_reason)='')as blank_return_reason,
sum(trim(total_amount)='')as blank_total_amount,
sum(trim(shipping_cost)='')as blank_shipping_cost,
sum(trim(profit_margin)='')as blank_profit_margin,
sum(trim(customer_age)='')as blank_customer_age,
sum(trim(customer_gender)='')as blank_customer_gender
from cleaned_orders;

select * from cleaned_orders;


-- Below query tell us how many orders where returned and how many non-returned. count of both.
SELECT returned, COUNT(*) AS order_count
FROM cleaned_orders
GROUP BY returned;

DESCRIBE cleaned_orders; -- This will tell the data types of every columns.

SELECT order_date, delivered_date, request_date
FROM cleaned_orders
LIMIT 10;
-- The above query is to check the date type. how they are.

SELECT
    order_date,
    STR_TO_DATE(order_date, '%d/%m/%Y') AS converted_order_date
FROM cleaned_orders
LIMIT 10;


SELECT
    order_date,
    STR_TO_DATE(order_date, '%d/%m/%Y') AS converted_order_date,
    delivered_date,
    STR_TO_DATE(delivered_date, '%d/%m/%Y') AS converted_delivered_date,
    request_date,
    STR_TO_DATE(request_date, '%d/%m/%Y') AS converted_request_date
FROM cleaned_orders
LIMIT 10;

-- The two queries above test whether the date columns can be converted to a standard date format

SET SQL_SAFE_UPDATES = 0; -- MySQL's safe update mode was ON by default; disabled here to allow the UPDATE statements below.

UPDATE cleaned_orders
SET order_date = DATE_FORMAT(
    STR_TO_DATE(order_date, '%d/%m/%Y'),
    '%Y-%m-%d'
)
WHERE order_date IS NOT NULL;


ALTER TABLE cleaned_orders
MODIFY COLUMN order_date DATE;

-- The above query updated the order_date column.


SELECT
    delivered_date,
    STR_TO_DATE(delivered_date, '%d/%m/%Y') AS converted_delivered_date
FROM cleaned_orders
LIMIT 10;

UPDATE cleaned_orders
SET delivered_date = DATE_FORMAT(
    STR_TO_DATE(delivered_date, '%d/%m/%Y'),
    '%Y-%m-%d'
)
WHERE delivered_date IS NOT NULL;

ALTER TABLE cleaned_orders
MODIFY COLUMN delivered_date DATE;

-- The above query changed the datatype from text to date of delivered_date column

SELECT
    request_date,
    STR_TO_DATE(request_date, '%d/%m/%Y') AS converted_request_date
FROM cleaned_orders
WHERE request_date IS NOT NULL
LIMIT 10;



SELECT
    request_date,
    STR_TO_DATE(request_date, '%d/%m/%Y') AS converted_request_date
FROM cleaned_orders
WHERE TRIM(request_date) <> ''
LIMIT 10;

UPDATE cleaned_orders
SET request_date = DATE_FORMAT(
    STR_TO_DATE(request_date, '%d/%m/%Y'),
    '%Y-%m-%d'
)
WHERE TRIM(request_date) <> '';

UPDATE cleaned_orders
SET request_date = NULL
WHERE TRIM(request_date) = '';

ALTER TABLE cleaned_orders
MODIFY COLUMN request_date DATE;

-- The above query changed the data type from text to date of request_date

select * from cleaned_orders;

-- The below next steps are the data-quality check

-- Date logic
SELECT
    order_id,
    order_date,
    delivered_date
FROM cleaned_orders
WHERE delivered_date < order_date;

-- checking negative numeric values

SELECT *
FROM cleaned_orders
WHERE price < 0
   OR discount < 0
   OR quantity < 0
   OR total_amount < 0
   OR shipping_cost < 0
   OR profit_margin < 0;
   
SELECT
    SUM(price < 0) AS negative_price,
    SUM(discount < 0) AS negative_discount,
    SUM(quantity < 0) AS negative_quantity,
    SUM(total_amount < 0) AS negative_total_amount,
    SUM(shipping_cost < 0) AS negative_shipping_cost,
    SUM(profit_margin < 0) AS negative_profit_margin
FROM cleaned_orders;


SELECT
    MIN(profit_margin) AS minimum_profit_margin,
    MAX(profit_margin) AS maximum_profit_margin,
    AVG(profit_margin) AS average_profit_margin
FROM cleaned_orders;


SELECT
    order_id,
    price,
    discount,
    quantity,
    total_amount,
    shipping_cost,
    profit_margin
FROM cleaned_orders
WHERE profit_margin > 100
ORDER BY profit_margin DESC;


SELECT
    MIN(profit_margin) AS min_profit,
    MAX(profit_margin) AS max_profit,
    AVG(profit_margin) AS avg_profit,
    MIN(total_amount) AS min_total,
    MAX(total_amount) AS max_total,
    AVG(total_amount) AS avg_total
FROM cleaned_orders;

SELECT
    order_id,
    total_amount,
    profit_margin,
    ROUND((profit_margin / total_amount) * 100, 2) AS profit_percentage
FROM cleaned_orders
WHERE total_amount > 0
ORDER BY profit_margin DESC
LIMIT 10;


-- Profit margin contains negative values, representing loss-making orders.
-- High values are valid profit amounts, not percentage values.


-- checking the returned columns values

SELECT returned, COUNT(*) AS order_count
FROM cleaned_orders
GROUP BY returned;

-- Now we want to make sure that every returned order actually has a request_date and return_reason

SELECT *
FROM cleaned_orders
WHERE returned = 'Yes'
  AND (request_date IS NULL OR return_reason IS NULL);

-- We should also verify that non-returned orders don't have a return reason or request date.

SELECT *
FROM cleaned_orders
WHERE returned = 'No'
  AND (request_date IS NOT NULL OR return_reason IS NOT NULL);
  
  
UPDATE cleaned_orders
SET return_reason = NULL
WHERE TRIM(return_reason) = '';

-- checking the payment method like 'UPI' or 'upi' or 'Upi'

SELECT
    payment_method,
    COUNT(*) AS order_count
FROM cleaned_orders
GROUP BY payment_method
ORDER BY order_count DESC;


-- Region wise consistency

SELECT
    region,
    COUNT(*) AS order_count
FROM cleaned_orders
GROUP BY region
ORDER BY order_count DESC;

-- Customer Gender

SELECT
    customer_gender,
    COUNT(*) AS customer_count
FROM cleaned_orders
GROUP BY customer_gender
ORDER BY customer_count DESC;

SELECT
    MIN(customer_age) AS min_age,
    MAX(customer_age) AS max_age,
    AVG(customer_age) AS avg_age
FROM cleaned_orders;

-- check the category wise

SELECT
    category,
    COUNT(*) AS order_count
FROM cleaned_orders
GROUP BY category
ORDER BY order_count DESC;

-- checking the discount

SELECT
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity
FROM cleaned_orders;

-- checking the total amount

SELECT
    order_id,
    price,
    quantity,
    discount,
    total_amount,
    ROUND(price * quantity * (1 - discount), 2) AS calculated_total
FROM cleaned_orders
LIMIT 10;

SELECT COUNT(*) AS inconsistent_orders
FROM cleaned_orders
WHERE ABS(
    total_amount - (price * quantity * (1 - discount))
) > 0.01;

select * from cleaned_orders;

-- The below is answered the business questions


-- 1. what is the overall return rate
select count(order_id)
from cleaned_orders;

select count(*)
from cleaned_orders
where returned = 'Yes';


SELECT 
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) 
        * 100.0 / COUNT(*),
        2
    ) AS overall_return_rate
FROM cleaned_orders;

# The overall return rate is 5.52

-- 2.which product category has the highest return rate

SELECT
    category,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS return_rate
FROM cleaned_orders
GROUP BY category
ORDER BY return_rate DESC
LIMIT 1;

# The fashion category has the highest return rate i.e 8.28

select * from cleaned_orders;

-- 3. what are the top reasons customer return products

SELECT
    return_reason,
    COUNT(*) AS return_count
FROM cleaned_orders
WHERE return_reason IS NOT NULL
GROUP BY return_reason
ORDER BY return_count DESC;

/* Not as described    490
   no longer needed    481
   Defective           465
   Missing/wrong item  439
   Slow delivery       28
*/

-- 4. which region show the highest return rate

SELECT
    region,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS return_rate
FROM cleaned_orders
GROUP BY region
ORDER BY return_rate DESC;

/* east    5.91
   south   5.68
   west    5.45
   north   5.36
   central 5.10
*/

-- 5. which payment method have the highest return rate

SELECT
    payment_method,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS return_rate
FROM cleaned_orders
GROUP BY payment_method
ORDER BY return_rate DESC;

/* Paypal      5.78
   Debit card  5.67
   Credit card 5.55
   UPI.        5.39
   wallet      5.38
   COD         5.10
*/

-- 6. how much revenue is lost due to return

SELECT
    ROUND(SUM(
        CASE
            WHEN returned = 'Yes' THEN total_amount
            ELSE 0
        END
    ), 2) AS lost_revenue
FROM cleaned_orders;

# Revenue lost is 388755.97

-- 7. how much profit is affected

SELECT
    ROUND(SUM(CASE
        WHEN returned = 'Yes' THEN profit_margin
        ELSE 0
    END), 2) AS affected_profit
FROM cleaned_orders;

# The affected profit is 61805.46

-- 8. are discounted products return most often

SELECT
    CASE
        WHEN discount > 0 THEN 'Discounted'
        ELSE 'Non-Discounted'
    END AS discount_status,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS return_rate
FROM cleaned_orders
GROUP BY discount_status
ORDER BY return_rate DESC;

/* Discounted     5.64
   Non-Discount.  5.41
*/

-- 9. Does delivery time affect the return rate?
SELECT
    CASE
        WHEN DATEDIFF(delivered_date, order_date) <= 2 THEN '1-2 Days'
        WHEN DATEDIFF(delivered_date, order_date) <= 5 THEN '3-5 Days'
        WHEN DATEDIFF(delivered_date, order_date) <= 7 THEN '6-7 Days'
        ELSE '8+ Days'
    END AS delivery_time,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS return_rate
FROM cleaned_orders
GROUP BY delivery_time
ORDER BY return_rate DESC;

/* 8+ days have 6.06
   6-7 days have 5.60
   3-5 days have 5.47
*/

-- 10. which return reason cause the highest financial loss?
SELECT
    return_reason,
    COUNT(*) AS return_count,
    ROUND(SUM(total_amount), 2) AS revenue_lost
FROM cleaned_orders
WHERE returned = 'Yes'
  AND return_reason IS NOT NULL
GROUP BY return_reason
ORDER BY revenue_lost DESC;

/* "Not as described" 
causes the highest revenue loss, 
followed by\n   "Defective" and "Missing/Wrong item". 
Run the query above for exact figures.\n*/

-- 11.Which product category has the highest revenue loss from returns?

SELECT
    category,
    COUNT(*) AS returned_orders,
    ROUND(SUM(total_amount), 2) AS revenue_lost
FROM cleaned_orders
WHERE returned = 'Yes'
GROUP BY category
ORDER BY revenue_lost DESC;

/* Electronics, Home, and Fashion have the highest revenue loss from returns.\n   
Run the query above for the full ranking by category.\n*/

-- 12.Does return rate increase with discount level?

SELECT
    CASE
        WHEN discount = 0 THEN '0%'
        WHEN discount > 0 AND discount <= 0.10 THEN '1-10%'
        WHEN discount > 0.10 AND discount <= 0.20 THEN '11-20%'
        ELSE '21-30%'
    END AS discount_band,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returned_orders,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS return_rate
FROM cleaned_orders
GROUP BY discount_band
ORDER BY return_rate DESC;

/* The 1-10% discount band has the highest return rate,\n   
followed by 11-20%, 0%, and 21-30%.\n*/

-- 13.Which region has the highest financial loss from returns?

SELECT
    region,
    COUNT(*) AS returned_orders,
    ROUND(SUM(total_amount), 2) AS revenue_lost
FROM cleaned_orders
WHERE returned = 'Yes'
GROUP BY region
ORDER BY revenue_lost DESC;

-- The South region has the highest revenue lost from returns, followed by East and West. Run the query above for exact figures.

-- 14. Which return reason is most common within each category?

SELECT
    category,
    return_reason,
    COUNT(*) AS return_count
FROM cleaned_orders
WHERE returned = 'Yes'
  AND return_reason IS NOT NULL
GROUP BY category, return_reason
ORDER BY category, return_count DESC;

-- 15. Which category has the highest return rate in each region?

SELECT
    region,
    category,
    ROUND(
        SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS return_rate,
    COUNT(*) AS total_orders
FROM cleaned_orders
GROUP BY region, category
ORDER BY region, return_rate DESC;

select * from cleaned_orders;

