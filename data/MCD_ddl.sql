-- Generated by Mocodo 4.2.3

CREATE TABLE FACTURE (
  PRIMARY KEY (ref_facture),
  ref_facture   VARCHAR(42) NOT NULL,
  date_emission VARCHAR(42),
  email         VARCHAR(42) NOT NULL,
  date_paiement VARCHAR(42)
);

CREATE TABLE LIGNE_FACTURE (
  PRIMARY KEY (ref_ligne),
  ref_ligne   VARCHAR(42) NOT NULL,
  quantite    VARCHAR(42),
  ref_facture VARCHAR(42) NOT NULL,
  description VARCHAR(42) NOT NULL
);

CREATE TABLE PRODUIT (
  PRIMARY KEY (description),
  description VARCHAR(42) NOT NULL,
  prix_HT     VARCHAR(42),
  prix_TTC    VARCHAR(42)
);

CREATE TABLE VISITEUR (
  PRIMARY KEY (email),
  email        VARCHAR(42) NOT NULL,
  mot_de_passe VARCHAR(42),
  nom          VARCHAR(42),
  adresse      VARCHAR(42),
  code_postal  VARCHAR(42),
  ville        VARCHAR(42)
);

ALTER TABLE FACTURE ADD FOREIGN KEY (email) REFERENCES VISITEUR (email);

ALTER TABLE LIGNE_FACTURE ADD FOREIGN KEY (description) REFERENCES PRODUIT (description);
ALTER TABLE LIGNE_FACTURE ADD FOREIGN KEY (ref_facture) REFERENCES FACTURE (ref_facture);