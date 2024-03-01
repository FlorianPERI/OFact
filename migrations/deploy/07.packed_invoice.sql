-- Deploy ofact:07.packed_invoice to pg

BEGIN;
CREATE TYPE packed AS (
    visitor_name TEXT,
    visitor_city TEXT,
    invoice_ref INT,
    invoice_issued_at TIMESTAMPTZ,
    invoice_paid_at TIMESTAMPTZ,
    lines JSON,
    total FLOAT
);


CREATE OR REPLACE FUNCTION packed_invoice(invoice_id INT) RETURNS SETOF packed AS
$$
    SELECT
        v.name AS visitor_name,
        v.city AS visitor_city,
        i.id AS invoice_ref,
        i.issued_at AS invoice_issued_at,
        i.paid_at AS invoice_paid_at,
        (
            SELECT json_agg(json_build_object(
                'product', p.label,
                'quantity', il.quantity,
                'price', pwt.price_with_taxes * il.quantity
            ))
            FROM invoice_line il
            JOIN product p ON il.product_id = p.id
			JOIN price_with_taxes pwt ON il.product_id = pwt.product_id
            WHERE il.invoice_id = i.id
        ) AS lines,
    (
        SELECT COALESCE(SUM(( 
          SELECT price_with_taxes
          FROM price_with_taxes 
          WHERE product_id = il.product_id) * quantity
          ), 0)
        FROM invoice_line il
        WHERE invoice_id = i.id
    ) AS total
    FROM invoice i
    JOIN visitor v ON i.visitor_id = v.id
    WHERE i.id = invoice_id;

$$ LANGUAGE sql;


COMMIT;
