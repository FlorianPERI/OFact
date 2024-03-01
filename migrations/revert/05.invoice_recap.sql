-- Revert ofact:05.invoice_recap from pg

BEGIN;

DROP VIEW IF EXISTS invoice_recap;

COMMIT;
