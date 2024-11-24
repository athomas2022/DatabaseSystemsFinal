-- 1NF already satisfied: If (OrderID, ProductID) appear together more than once, display them. (Returns empty because this is primary key)
SELECT OrderID, ProductID, COUNT(*) 
FROM CompanyData 
GROUP BY OrderID, ProductID 
HAVING COUNT(*) > 1;

-- 2NF: Split prime attributes into their own tables where corresponding non-prime attributes depend on only each one, and keep the rest
-- Create Tables:
-- Orders: OrderID -> (customerID, employeeID, orderDate, requiredDate, shippedDate, shipVia, Freight)
CREATE TABLE Orders
AS SELECT DISTINCT orderID, customerID, employeeID, orderDate, requiredDate, shippedDate, shipVia, Freight
FROM CompanyData;

-- Products: ProductID -> (productName, supplierID, categoryID, unitPrice.1, unitsInStock, discontinued, categoryName)
CREATE TABLE Products
AS SELECT DISTINCT productID, productName, supplierID, categoryID, `unitPrice.1`, unitsInStock, discontinued, categoryName
FROM CompanyData;

-- New tables for Employee and Supplier:
-- Employees: EmployeeID -> (employees.lastName, employees.firstName, employees.title)
CREATE TABLE Employees
AS SELECT DISTINCT employeeID, `employees.lastName` AS lastName, `employees.firstName` AS firstName, `employees.title` AS title
FROM CompanyData;

-- Suppliers: SupplierID -> (suppliers.companyName, suppliers.contactName, suppliers.contactTitle)
CREATE TABLE Suppliers
AS SELECT DISTINCT supplierID, `suppliers.companyName` as companyName, `suppliers.contactName` AS contactName, `suppliers.contactTitle` AS contactTitle
FROM CompanyData;

-- Customers: CustomerID -> (companyName, contactName, contactTitle)
CREATE TABLE Customers
AS SELECT DISTINCT  customerID, companyName, contactName, contactTitle
FROM CompanyData;

-- Drop reallocated attributes in 'CompanyData': (OrderID, ProductID) -> (unitPrice, discount, quantity, quantityPerUnit, unitsOnOrder, reorderLevel)
-- Create new temporary table, drop the old one, and rename it to match
CREATE TABLE CompanyDataTemp
AS SELECT orderID, productID, unitPrice, discount, quantity, quantityPerUnit, unitsOnOrder, reorderLevel
FROM CompanyData;

DROP TABLE CompanyData;

RENAME TABLE CompanyDataTemp to CompanyData;

-- 3NF (all attributes must depend solely on the primary key, not transitively/indirectly):
-- Tables in 3NF already: Orders, Employees, Suppliers, and CompanyData
-- 'Products' is not in 3NF because you transitive property: ProductID -> CategoryID -> CategoryName
-- New table 'Categories': CategoryID -> CategoryName
CREATE TABLE Categories
AS SELECT DISTINCT categoryID, categoryName
FROM Products;

-- Remove 'CategoryName' from Products to get (same way as removing attributes from 'CompanyData':
-- 'Products': ProductID -> (productName, supplierID, categoryID, unitPrice.1, unitsInStock, discontinued)
CREATE TABLE ProductsTemp
AS SELECT productID, productName, supplierID, categoryID, `unitPrice.1` as unitPrice, unitsInStock, discontinued
FROM Products;

DROP TABLE Products;

RENAME TABLE ProductsTemp to Products;
