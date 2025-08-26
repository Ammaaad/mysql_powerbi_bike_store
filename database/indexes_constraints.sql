-- Add indexes:
CREATE INDEX idx_product_brand ON product(brand_id);
CREATE INDEX idx_product_category ON product(category_id);
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_order_store ON orders(store_id);

SELECT * FROM product WHERE brand_id = 9;

-- Add constraint:
ALTER TABLE inventory
ADD CONSTRAINT chk_quantity CHECK (quantity >= 0);