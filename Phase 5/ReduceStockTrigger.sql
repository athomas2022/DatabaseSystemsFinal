DELIMITER $$

-- Creating trigger to update product stock after an order is placed
CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON companydata -- Fires after new row is added to the companydata table
FOR EACH ROW
BEGIN
	-- Updating the products table to reduce stock quantity
    UPDATE products
    SET unitsInStock = unitsInStock - NEW.quantity
    WHERE productID = NEW.productID; -- Match ID from the order with the product in the table
END$$

DELIMITER ;

-- Test that returns Chai with 39 units in stock
SELECT productID, productName, unitsInStock
FROM products
WHERE productID = 1;
-- New order
INSERT INTO companydata (orderID, productID, unitPrice, discount, quantity, quantityPerUnit, unitsOnOrder, reorderLevel)
VALUES (1002, 1, 18.00, 0.00, 5, '1 kg pkg.', 0, 10);
-- Verify execution. unitsInStock for productID =1 should be 34
SELECT productID, productName, unitsInStock 
FROM products 
WHERE productID = 1;

-- It does. Now check the order to ensure it was inserted into the companydata table
SELECT * 
FROM companydata 
WHERE orderID = 1002;
