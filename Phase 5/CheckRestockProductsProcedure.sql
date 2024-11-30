DELIMITER $$

-- Create a procedure to find products needing restocking
CREATE PROCEDURE CheckRestockProducts()
BEGIN
    -- Select products where stock is less than or equal to the reorder level
    SELECT 
        p.productID,          -- Product ID
        p.productName,        -- Product Name
        p.unitsInStock,       -- Current Stock
        c.reorderLevel        -- Reorder Level from companydata
    FROM 
        products p
    JOIN 
        companydata c ON p.productID = c.productID -- Match products to their reorder levels
    WHERE 
        p.unitsInStock <= c.reorderLevel; -- Identify products that need restocking
END$$

DELIMITER ;


-- Returns a list of products along with their current stock and reorder levels.
CALL CheckRestockProducts();

