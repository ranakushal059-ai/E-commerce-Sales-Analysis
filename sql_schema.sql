use ecomm;

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Region VARCHAR(50),
    Date DATE,
    Time TIME,
    Total_Amount DECIMAL(10,2)
);

