-- Revert ofact:06.sales from pg

BEGIN;

DROP TYPE IF EXISTS sales CASCADE;
DROP FUNCTION IF EXISTS sales_by_date (start_date DATE, end_date DATE);

COMMIT;
