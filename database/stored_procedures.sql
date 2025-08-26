DELIMITER //
CREATE PROCEDURE get_order_total(IN orderId INT)
BEGIN
    SELECT SUM(quantity * list_price * (1 - discount/100)) AS total
    FROM order_items
    WHERE order_id = orderId;
END //
DELIMITER ;

CALL get_order_total(101);  