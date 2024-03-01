-- Revert ofact:04.invoice_details from pg

BEGIN;

DROP VIEW IF EXISTS invoice_details;

COMMIT;
