-- Deploy ofact:03.crud_functions to pg
BEGIN;

CREATE OR REPLACE FUNCTION insert_visitor(d json) RETURNS 
visitor AS 
$$ 
    INSERT INTO visitor (email, password, name, address, zip_code, city)
    VALUES (
        d->>'email',
        d->>'password',
        d->>'name',
        d->>'address',
        d->>'zip_code',
        d->>'city'
    )
    RETURNING *;
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION update_invoice_line(d json
) RETURNS invoice_line AS 
$$
	UPDATE invoice_line
	SET
        quantity = (d->>'quantity')::int,
        invoice_id = (d->>'invoice_id')::int,
        product_id = (d->>'product_id')::int
	WHERE id = (d->>'id')::int
  RETURNING *;
$$
LANGUAGE sql; 

CREATE OR REPLACE FUNCTION update_invoice(d json
) RETURNS invoice AS 
$$
	UPDATE invoice
	SET
        visitor_id = (d->>'visitor_id')::int,
        paid_at = COALESCE((d->>'paid_at')::timestamptz, NOW())
	WHERE id = (d->>'id')::int
  RETURNING *;
$$
LANGUAGE sql; 

COMMIT;