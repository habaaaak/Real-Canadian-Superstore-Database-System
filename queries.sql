-- =========================================
-- Real Canadian Superstore Database System
-- Schema Definition
-- =========================================

-- =====================
-- Store Table
-- =====================

CREATE TABLE Store (
    Store_ID LONG PRIMARY KEY,
    Location TEXT(100) NOT NULL,
    ManagerName TEXT(100) NOT NULL
);

-- =====================
-- Customer Table
-- =====================

CREATE TABLE Customer (
    Customer_ID LONG PRIMARY KEY,
    Name TEXT(100) NOT NULL,
    Email TEXT(100) NOT NULL,
    Phone TEXT(15),

    CONSTRAINT UQ_Email UNIQUE (Email)
);

-- =====================
-- Product Table
-- =====================

CREATE TABLE Product (
    Product_ID LONG PRIMARY KEY,
    Name TEXT(100) NOT NULL,
    Price CURRENCY NOT NULL,
    StockQuantity LONG NOT NULL
);

-- =====================
-- Employee Table
-- =====================

CREATE TABLE Employee (
    Employee_ID LONG PRIMARY KEY,
    Name TEXT(100) NOT NULL,
    Position TEXT(50) NOT NULL,
    Store_ID LONG NOT NULL,

    FOREIGN KEY (Store_ID)
    REFERENCES Store(Store_ID)
);

-- =====================
-- Orders Table
-- =====================

CREATE TABLE Orders (
    Order_ID LONG PRIMARY KEY,
    Order_Date DATETIME NOT NULL,
    Customer_ID LONG NOT NULL,
    Store_ID LONG NOT NULL,

    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID),

    FOREIGN KEY (Store_ID)
    REFERENCES Store(Store_ID)
);

-- =====================
-- Order_Item Table
-- =====================

CREATE TABLE Order_Item (
    Order_ID LONG NOT NULL,
    Product_ID LONG NOT NULL,
    Quantity LONG NOT NULL,

    PRIMARY KEY (Order_ID, Product_ID),

    FOREIGN KEY (Order_ID)
    REFERENCES Orders(Order_ID),

    FOREIGN KEY (Product_ID)
    REFERENCES Product(Product_ID)
);