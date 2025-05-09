-- Scripts/CreateOrdersTable.sql

CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Number INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
