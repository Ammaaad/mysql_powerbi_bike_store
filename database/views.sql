CREATE VIEW sales_summary AS
SELECT o.order_id, c.first_name, c.last_name, s.store_name, 
       SUM(oi.quantity * oi.list_price * (1 - oi.discount/100)) AS total_order_value
FROM orders o
JOIN customer c ON o.customer_id = c.customer_id
JOIN store s ON o.store_id = s.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.order_id;

SELECT * FROM sales_summary;

SELECT * 
FROM sales_summary
WHERE total_order_value > 5000
ORDER BY total_order_value DESC;