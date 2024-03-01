-- Verify ofact:02.3nf on pg

BEGIN;

SELECT
    product_id,
    price_with_taxes
FROM price_with_taxes;


ROLLBACK;