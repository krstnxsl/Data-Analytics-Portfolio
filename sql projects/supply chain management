-- Drop tables if they already exist
DROP TABLE IF EXISTS Logistics;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Warehouse;

-- Create Warehouse table
CREATE TABLE IF NOT EXISTS Warehouse (
    warehouse_id INT PRIMARY KEY,
    warehouse_name VARCHAR(100),
    location VARCHAR(100)
);

-- Create Inventory table
CREATE TABLE IF NOT EXISTS Inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    stock_level INT,
    warehouse_id INT,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);

-- Create Logistics table
CREATE TABLE IF NOT EXISTS Logistics (
    shipment_id INT PRIMARY KEY,
    item_id INT,
    quantity INT,
    shipment_date DATE,
    destination VARCHAR(100),
    FOREIGN KEY (item_id) REFERENCES Inventory(item_id)
);

-- Insert sample data
INSERT INTO Warehouse VALUES (1, 'Main Warehouse', 'Manila');
INSERT INTO Warehouse VALUES (2, 'Regional Warehouse', 'Cebu');

INSERT INTO Inventory VALUES (101, 'Laptop', 120, 1);
INSERT INTO Inventory VALUES (102, 'Mouse', 500, 1);
INSERT INTO Inventory VALUES (103, 'Keyboard', 300, 2);

INSERT INTO Logistics VALUES (1001, 101, 20, '2026-07-01', 'Davao');
INSERT INTO Logistics VALUES (1002, 102, 50, '2026-07-02', 'Iloilo');
INSERT INTO Logistics VALUES (1003, 103, 30, '2026-07-03', 'Manila');

-- Queries

-- Check stock levels by warehouse
SELECT w.warehouse_name, i.item_name, i.stock_level
FROM Inventory i
JOIN Warehouse w ON i.warehouse_id = w.warehouse_id;

-- Identify low stock items (threshold = 100)
SELECT item_name, stock_level
FROM Inventory
WHERE stock_level < 100;

-- Track shipments by destination
SELECT l.shipment_id, i.item_name, l.quantity, l.destination
FROM Logistics l
JOIN Inventory i ON l.item_id = i.item_id;

-- Find total items shipped per warehouse
SELECT w.warehouse_name, SUM(l.quantity) AS total_shipped
FROM Logistics l
JOIN Inventory i ON l.item_id = i.item_id
JOIN Warehouse w ON i.warehouse_id = w.warehouse_id
GROUP BY w.warehouse_name;
