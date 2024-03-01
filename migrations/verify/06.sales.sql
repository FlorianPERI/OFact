-- Verify ofact:06.sales on pg

BEGIN;

SELECT * FROM sales_by_date('2024-02-25', '2024-04-20');

ROLLBACK;
