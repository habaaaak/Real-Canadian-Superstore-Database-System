-- =========================================
-- Real Canadian Superstore Database System
-- Business Analytics Queries
-- =========================================

-- ====================================================
-- 1. Show all customer orders with store location
-- ====================================================

SELECT 
    Orders.Order_ID,
    Customer.Name AS CustomerName,
    Store.Location AS StoreLocation,
    Orders.Order_Date

FROM 
    (Customer 
    INNER JOIN Orders 
    ON Customer.Customer_ID = Orders.Customer_ID)

    INNER JOIN Store 
    ON Store.Store_ID = Orders.Store_ID;

-- ====================================================
-- 2. Find all employees working at each store
-- ====================================================

SELECT 
    Employee.Name AS EmployeeName,
    Employee.Position,
    Store.Location

FROM 
    Store 
    INNER JOIN Employee 
    ON Store.Store_ID = Employee.Store_ID;

-- ====================================================
-- 3. Calculate total sales revenue by store
-- ====================================================

SELECT 
    Store.Location,
    SUM(Order_Item.Quantity * Product.Price) AS TotalSales

FROM 
    ((Store
    INNER JOIN Orders 
    ON Store.Store_ID = Orders.Store_ID)

    INNER JOIN Order_Item 
    ON Orders.Order_ID = Order_Item.Order_ID)

    INNER JOIN Product 
    ON Order_Item.Product_ID = Product.Product_ID

GROUP BY 
    Store.Location

ORDER BY 
    SUM(Order_Item.Quantity * Product.Price) DESC;

-- ====================================================
-- 4. Identify top-selling products
-- ====================================================

SELECT 
    Product.Name,
    SUM(Order_Item.Quantity) AS UnitsSold

FROM 
    Product
    INNER JOIN Order_Item 
    ON Product.Product_ID = Order_Item.Product_ID

GROUP BY 
    Product.Name

ORDER BY 
    SUM(Order_Item.Quantity) DESC;

-- ====================================================
-- 5. Find products with low inventory stock
-- ====================================================

SELECT 
    Name,
    StockQuantity

FROM 
    Product

WHERE 
    StockQuantity < 100;

-- ====================================================
-- 6. Find customers who purchased multiple products
-- ====================================================

SELECT 
    Customer.Name,
    COUNT(Order_Item.Product_ID) AS NumberOfProducts

FROM 
    ((Customer
    INNER JOIN Orders 
    ON Customer.Customer_ID = Orders.Customer_ID)

    INNER JOIN Order_Item 
    ON Orders.Order_ID = Order_Item.Order_ID)

GROUP BY 
    Customer.Name

HAVING 
    COUNT(Order_Item.Product_ID) > 1;

-- ====================================================
-- 7. Identify products included in multiple orders
-- ====================================================

SELECT 
    Product.Name,
    COUNT(Order_Item.Order_ID) AS OrderCount

FROM 
    Product
    INNER JOIN Order_Item 
    ON Product.Product_ID = Order_Item.Product_ID

GROUP BY 
    Product.Name

HAVING 
    COUNT(Order_Item.Order_ID) > 1;