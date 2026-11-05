use ecomm;

-- bussiness problems
-- 1.What is the total revenue generated?
SELECT
    SUM(Total_Amount) AS Total_Revenue
FROM Orders;


-- 2.What is the total number of orders?
SELECT
    COUNT(Order_ID) AS Total_Orders
FROM Orders;


-- 3.What is the Average Order Value (AOV)?
SELECT
    ROUND(AVG(Total_Amount), 2) AS Average_Order_Value
FROM Orders;


-- 4.Which product generates the highest revenue?
SELECT
    Product_Name,
    SUM(Total_Amount) AS Total_Revenue
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Revenue DESC
LIMIT 1;


-- 5.Which category generates the highest revenue?
SELECT
    Category,
    SUM(Total_Amount) AS Total_Revenue
FROM Orders
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- 6.Which region generates the highest revenue?
SELECT
    Region,
    SUM(Total_Amount) AS Total_Revenue
FROM Orders
GROUP BY Region
ORDER BY Total_Revenue DESC;


-- 7.What are the top 5 best-selling products?
SELECT
    Product_Name,
    SUM(Quantity) AS Total_Quantity_Sold
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Quantity_Sold DESC
LIMIT 5;


-- 8.What is the monthly revenue trend?
SELECT
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    SUM(Total_Amount) AS Monthly_Revenue
FROM Orders
GROUP BY Month
ORDER BY Month;


-- 9.Which time of the day receives the most orders?
SELECT
    CASE
        WHEN HOUR(Time) BETWEEN 6 AND 11 THEN 'Morning'
        WHEN HOUR(Time) BETWEEN 12 AND 16 THEN 'Afternoon'
        WHEN HOUR(Time) BETWEEN 17 AND 20 THEN 'Evening'
        ELSE 'Night'
    END AS Time_Slot,
    COUNT(Order_ID) AS Total_Orders
FROM Orders
GROUP BY Time_Slot
ORDER BY Total_Orders DESC;


-- 10.What is the month-over-month revenue growth?
WITH Monthly_Sales AS (
    SELECT
        DATE_FORMAT(Date, '%Y-%m') AS Month,
        SUM(Total_Amount) AS Revenue
    FROM Orders
    GROUP BY DATE_FORMAT(Date, '%Y-%m')
),
Sales_Growth AS (
    SELECT
        Month,
        Revenue,
        LAG(Revenue) OVER (ORDER BY Month) AS Previous_Month_Revenue
    FROM Monthly_Sales
)
SELECT
    Month,
    Revenue,
    Previous_Month_Revenue,
    ROUND(
        (Revenue - Previous_Month_Revenue)
        / NULLIF(Previous_Month_Revenue, 0) * 100,
        2
    ) AS Growth_Percentage
FROM Sales_Growth;