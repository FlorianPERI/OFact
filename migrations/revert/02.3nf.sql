-- Revert ofact:02.3nf from pg

BEGIN;

ALTER TABLE product ADD COLUMN price_with_taxes INT;

UPDATE product
SET
    price_with_taxes = price_with_taxes.price_with_taxes
FROM price_with_taxes
WHERE
    product.id = price_with_taxes.product_id;

DROP TABLE IF EXISTS price_with_taxes;

COMMIT;