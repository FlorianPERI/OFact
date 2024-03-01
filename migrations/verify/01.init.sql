-- Verify ofact:init on pg

BEGIN;

SELECT
    email,
    password,
    name,
    address,
    zip_code,
    city
FROM visitor;

SELECT label, price FROM product;

SELECT visitor_id, issued_at, paid_at FROM invoice;

SELECT quantity, invoice_id, product_id FROM invoice_line;

ROLLBACK;