-- Deploy ofact:06.sales to pg

BEGIN;

CREATE TYPE sales AS (sale_date DATE, nb_invoices INT, total NUMERIC);

CREATE OR REPLACE FUNCTION sales_by_date(start_date DATE, end_date DATE) RETURNS 
SETOF sales AS 
$$
    SELECT
        date_series::DATE AS sale_date,
        (
            SELECT COUNT(*)
            FROM invoice
            WHERE DATE(issued_at) = date_series::DATE
        ) AS nb_invoices,
        COALESCE(
            (
                SELECT SUM(
                    (
                        SELECT price_with_taxes
                        FROM price_with_taxes
                        WHERE product_id = il.product_id
                    ) * il.quantity
                )
                FROM invoice_line il
                JOIN invoice i ON il.invoice_id = i.id
                WHERE DATE(i.issued_at) = date_series::DATE
            ),
            0
        ) AS total
    FROM generate_series(start_date, end_date, '1 day'::interval) AS date_series;
$$
LANGUAGE SQL;

COMMIT;
