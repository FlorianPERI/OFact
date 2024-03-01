-- Verify ofact:03.crud_functions on pg

BEGIN;

SELECT * FROM insert_visitor('{
    "email": "utilisateur@example.com",
    "password": "$2b$10$Btz1P5F51",
    "name": "Nico",
    "address": "Au mileu de la grande anse",
    "zip_code": "17370",
    "city": "Grand-Village plage"
}');

SELECT * FROM update_invoice_line('{
    "quantity": 3,
    "invoice_id": 1,
    "product_id": 1,
    "id": 1
}');

SELECT * FROM update_invoice('{
    "visitor_id": 2,
    "paid_at": "2022-04-13 10:00:00+02",
    "id": 3
}');

ROLLBACK;