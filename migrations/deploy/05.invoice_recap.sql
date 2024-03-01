-- Deploy ofact:05.invoice_recap to pg
BEGIN;

CREATE OR REPLACE VIEW invoice_recap AS
SELECT id, 
      issued_at, 
      paid_at,
      (
        SELECT name
        FROM visitor
        WHERE id = invoice.visitor_id
    ) AS visitor_name,
    (
        SELECT COALESCE(SUM(( 
          SELECT price_with_taxes 
          FROM price_with_taxes 
          WHERE product_id = invoice_line.product_id) * quantity
          ), 0)
        FROM invoice_line
        WHERE invoice_id = invoice.id
    ) AS total

FROM invoice;

COMMIT;
