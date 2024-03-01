-- Deploy ofact:04.invoice_details to pg
BEGIN;

CREATE OR REPLACE VIEW invoice_details AS
SELECT
    v.name AS visitor_name,
    v.city AS visitor_city,
    i.id AS invoice_ref,
    i.issued_at AS invoice_issued_at,
    i.paid_at AS invoice_paid_at,
    il.quantity AS quantity_ordered,
    p.label AS product_description,
    p.price AS product_price,
    ((pt.price_with_taxes - p.price) * 100 / p.price)::float AS tax_rate,
    il.quantity * pt.price_with_taxes AS total_line
FROM
    invoice i
JOIN
    visitor v ON i.visitor_id = v.id
JOIN
    invoice_line il ON i.id = il.invoice_id
JOIN
    product p ON il.product_id = p.id
JOIN
    price_with_taxes pt ON p.id = pt.product_id;

COMMIT;