-- Revert ofact:03.crud_functions from pg

BEGIN;

DROP FUNCTION IF EXISTS insert_visitor (d json);

DROP FUNCTION IF EXISTS update_invoice_line (d json);

DROP FUNCTION IF EXISTS update_invoice (d json);

COMMIT;