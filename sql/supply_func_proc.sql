
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_groc_to_certain_supply`(
	sup_id INT, 
    g_id INT, 
    g_count INT
)
BEGIN
	INSERT INTO list_supplys(supply_id, groc_id, groc_count) 
    VALUES (sup_id, g_id, g_count);
    UPDATE groceries SET ava_count = ava_count + g_count;
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_supply`(sup_id INT)
BEGIN
	INSERT INTO supplys(supply_date, supplier_id) VALUES (DATE(NOW()), sup_id);
END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_supply`(supl_id INT)
BEGIN 
	DELETE FROM supplys
    WHERE supply_id = supl_id;
END$$
DELIMITER ;

CREATE VIEW supply_view AS 
SELECT supplys.supply_id, 
	supplys.supply_date, 
    supplys.supplier_id, 
    suppliers.supplier_name, 
    SUM(sup_gr.sup_groc_price * lsup.groc_count) AS summ
FROM list_supplys lsup
	JOIN supplys supplys USING(supply_id)
	JOIN suppliers suppliers USING(supplier_id)
    JOIN suppliers_groc sup_gr ON sup_gr.supplier_id = supplys.supplier_id 
								AND sup_gr.groc_id = lsup.groc_id
GROUP BY supplys.supply_id;


CREATE VIEW supply_groceries_view AS 
SELECT supply_id, groc_id, groc_count
FROM list_supplys















