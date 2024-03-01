-- Verify ofact:07.packed_invoice on pg

BEGIN;

SELECT * FROM packed_invoice(1);

ROLLBACK;
