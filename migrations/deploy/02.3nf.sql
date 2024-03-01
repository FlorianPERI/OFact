BEGIN;

CREATE TABLE price_with_taxes (
    product_id INT PRIMARY KEY REFERENCES product (id), price_with_taxes INT NOT NULL
);

INSERT INTO
    price_with_taxes (product_id, price_with_taxes)
SELECT id, price_with_taxes
FROM product;

ALTER TABLE product DROP COLUMN IF EXISTS price_with_taxes;

COMMIT;