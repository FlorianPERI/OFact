-- Deploy ofact:init to pg

BEGIN;

CREATE DOMAIN pcode AS text CHECK (
    value ~ '^0[1-9]\d{3}|[1-8]\d{4}|9[0-6]\d{3}|9[78][12478]\d{2}$'
);

CREATE DOMAIN mail AS text CHECK (
    value ~ '^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$'
);

CREATE DOMAIN pass AS text CHECK (value ~ '^\$2b\$10\$.+');

CREATE TABLE visitor (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, email mail UNIQUE NOT NULL, password pass NOT NULL, name TEXT NOT NULL, address TEXT NOT NULL, zip_code pcode NOT NULL, city TEXT NOT NULL
);

CREATE TABLE product (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, label TEXT NOT NULL, price INT NOT NULL, price_with_taxes INT NOT NULL
);

CREATE TABLE invoice (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, visitor_id INTEGER REFERENCES visitor (id) NOT NULL, issued_at TIMESTAMPTZ NOT NULL, paid_at TIMESTAMPTZ
);

CREATE TABLE invoice_line (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, quantity INT NOT NULL, invoice_id INT REFERENCES invoice (id) NOT NULL, product_id INT REFERENCES product (id) NOT NULL
);

CREATE INDEX idx_invoice_line_invoice_id ON invoice_line (invoice_id);

CREATE INDEX ON invoice (visitor_id);

CREATE INDEX ON product (label);

CREATE INDEX ON visitor (email);

CREATE INDEX ON visitor (zip_code);

COMMIT;