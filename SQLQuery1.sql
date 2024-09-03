-- Create the database
DROP DATABASE CafeManagementSystem
GO

CREATE DATABASE CafeManagementSystem;
GO

USE CafeManagementSystem;
GO

-- Create the Inventory table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ItemName NVARCHAR(100) NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18, 2) NOT NULL,
    TotalValue AS (Quantity * UnitPrice) -- Computed column
);
GO

-- Create the MenuItem table
CREATE TABLE MenuItem (
    MenuItemID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL
);
GO

-- Create the User table
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(256) NOT NULL,
    LastOrderPrice DECIMAL(18, 2) NULL
);
GO

-- Create the Order table with foreign key reference to User with cascade delete
CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2) NOT NULL,
    UserID INT NULL,
    FOREIGN KEY (UserID) REFERENCES [User](UserID) ON DELETE CASCADE
);
GO

-- Create the OrderItem table with foreign key references to Order and MenuItem
CREATE TABLE OrderItem (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    MenuItemID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID) ON DELETE CASCADE,
    FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID)
);
GO

-- Create the Transaction table with foreign key reference to Order with cascade delete
CREATE TABLE [Transaction] (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    TransactionDate DATETIME NOT NULL DEFAULT GETDATE(),
    Amount DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES [Order](OrderID) ON DELETE CASCADE
);
GO

-- Insert sample data into MenuItem
INSERT INTO MenuItem (Name, Price) VALUES
('Espresso', 3.0),
('Latte', 3.5),
('Cappuccino', 4.0),
('Americano', 2.5),
('Mocha', 4.5),
('Green Tea', 2.0),
('Black Tea', 1.8);
GO

-- Insert sample data into Inventory
INSERT INTO Inventory (ItemName, Quantity, UnitPrice) VALUES
('Coffee Beans', 50, 10.0),
('Milk', 20, 1.5),
('Sugar', 15, 0.5),
('Tea Leaves', 30, 8.0),
('Chocolate Syrup', 10, 5.0);
GO

-- Insert sample data into [User]
INSERT INTO [User] (UserName, Email, PasswordHash, LastOrderPrice) VALUES
('AliceSmith', 'alice.smith@example.com', 'hashedpassword123', 0),
('BobJohnson', 'bob.johnson@example.com', 'hashedpassword456', 0),
('CarolWilliams', 'carol.williams@example.com', 'hashedpassword789', 0);
GO

-- Insert sample data into [Order]
INSERT INTO [Order] (OrderDate, TotalAmount, UserID) VALUES
('2024-08-30 10:30:00', 7.5, 1),
('2024-08-30 11:00:00', 9.0, 2),
('2024-08-30 12:00:00', 5.5, 3);
GO

-- Insert sample data into OrderItem
INSERT INTO OrderItem (OrderID, MenuItemID, Quantity, Price) VALUES
(1, 1, 1, 3.0),
(1, 3, 1, 4.0),
(2, 2, 2, 7.0),
(2, 4, 1, 2.5),
(3, 5, 1, 4.5),
(3, 7, 1, 2.0);
GO

-- Insert sample data into Transaction
INSERT INTO [Transaction] (OrderID, Amount) VALUES
(1, 7.5),
(2, 9.0),
(3, 5.5);
GO

-- Select all users to verify data
SELECT * FROM [User];
GO

SELECT * FROM OrderItem
GO