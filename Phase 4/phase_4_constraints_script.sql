-- Set primary keys for each table according to E-R Diagram:
ALTER TABLE categories ADD PRIMARY KEY (categoryID);
ALTER TABLE companydata ADD PRIMARY KEY (orderID, productID);
ALTER TABLE customers ADD PRIMARY KEY (customerID);
ALTER TABLE employees ADD PRIMARY KEY (employeeID);
ALTER TABLE suppliers ADD PRIMARY KEY (supplierID);
ALTER TABLE orders ADD PRIMARY KEY (orderID);
ALTER TABLE products ADD PRIMARY KEY (productID);

-- `unitPrice.1` from phase 1 should be double to match 'unitPrice' column from phase 1
ALTER TABLE products MODIFY COLUMN unitPrice DOUBLE;

-- All columns now have an appropriate datatype for our constraints:
-- ID's except customer, Quantities except perUnit: int
-- Titles, names, contact, dates: varchar(255)
-- Discounts, prices: Double

-- Set foreign key constraints for Products, then Orders 
-- (ALTER TABLE commands could have been merged but I left them separated)
ALTER TABLE products 
ADD CONSTRAINT fk_supplierID FOREIGN KEY products (supplierID) 
REFERENCES suppliers (supplierID);

ALTER TABLE products 
ADD CONSTRAINT fk_categoryID FOREIGN KEY products (categoryID) 
REFERENCES categories (categoryID);

ALTER TABLE orders
ADD CONSTRAINT fk_customerID FOREIGN KEY products (customerID) 
REFERENCES customers (customerID);

ALTER TABLE orders
ADD CONSTRAINT fk_employeeID FOREIGN KEY products (employeeID) 
REFERENCES employees (employeeID);