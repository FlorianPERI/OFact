-- Verify ofact:05.invoice_recap on pg

BEGIN;

SELECT * FROM invoice_recap;
ROLLBACK;
