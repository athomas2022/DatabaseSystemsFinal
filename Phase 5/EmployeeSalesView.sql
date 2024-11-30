USE constrained_companydata; -- From phase 4
SHOW TABLES;


-- Creating the view to show quantity sold and revenue gen by each employee
CREATE VIEW EmployeeSales AS
SELECT
	e.employeeID, -- employeeID for identification
    CONCAT(e.firstName, ' ', e.lastName) AS EmployeeName, -- Combination for readability
    SUM(cd.quantity) AS TotalQuantitySold, 
    SUM(cd.quantity * cd.unitPrice) AS TotalRevenue
FROM
	employees e
JOIN 
	orders o ON e.employeeID = o.employeeID
JOIN 
	companydata cd ON o.orderID = cd.orderID
GROUP BY
	e.employeeID, EmployeeName;

-- Testing View
SELECT * FROM EmployeeSales;
    
