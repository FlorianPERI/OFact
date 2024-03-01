-- Revert ofact:06.sales from pg

BEGIN;

DROP FUNCTION IF EXISTS sales_by_date (start_date DATE, end_date DATE);

DROP TYPE IF EXISTS sales CASCADE;
COMMIT;
