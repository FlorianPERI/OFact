-- Revert ofact:07.packed_invoice from pg

BEGIN;

DROP FUNCTION IF EXISTS packed_invoice(INTEGER);
DROP TYPE IF EXISTS packed;
COMMIT;
