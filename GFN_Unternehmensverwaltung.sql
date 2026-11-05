CREATE DATABASE gfn_schulprojekt;
USE gfn_schulprojekt;

CREATE TABLE standorte (
    standort_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    stadt VARCHAR(80) NOT NULL
);

CREATE TABLE abteilungen (
    abteilung_id INT AUTO_INCREMENT PRIMARY KEY,
    standort_id INT NOT NULL,
    name VARCHAR(80) NOT NULL,
    FOREIGN KEY (standort_id) REFERENCES standorte(standort_id)
);

CREATE TABLE mitarbeiter (
    mitarbeiter_id INT AUTO_INCREMENT PRIMARY KEY,
    abteilung_id INT NOT NULL,
    vorname VARCHAR(50) NOT NULL,
    nachname VARCHAR(50) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    eintrittsdatum DATE NOT NULL,
    FOREIGN KEY (abteilung_id) REFERENCES abteilungen(abteilung_id)
);

CREATE TABLE kunden (
    kunde_id INT AUTO_INCREMENT PRIMARY KEY,
    firma VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    stadt VARCHAR(80) NOT NULL
);

CREATE TABLE lieferanten (
    lieferant_id INT AUTO_INCREMENT PRIMARY KEY,
    firma VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE produkte (
    produkt_id INT AUTO_INCREMENT PRIMARY KEY,
    lieferant_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    preis DECIMAL(10,2) NOT NULL CHECK (preis > 0),
    FOREIGN KEY (lieferant_id) REFERENCES lieferanten(lieferant_id)
);

CREATE TABLE lager (
    produkt_id INT PRIMARY KEY,
    bestand INT NOT NULL CHECK (bestand >= 0),
    mindestbestand INT NOT NULL CHECK (mindestbestand >= 0),
    FOREIGN KEY (produkt_id) REFERENCES produkte(produkt_id)
);

CREATE TABLE bestellungen (
    bestellung_id INT AUTO_INCREMENT PRIMARY KEY,
    kunde_id INT NOT NULL,
    mitarbeiter_id INT NOT NULL,
    bestelldatum DATE NOT NULL,
    FOREIGN KEY (kunde_id) REFERENCES kunden(kunde_id),
    FOREIGN KEY (mitarbeiter_id) REFERENCES mitarbeiter(mitarbeiter_id)
);

CREATE TABLE bestellpositionen (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    bestellung_id INT NOT NULL,
    produkt_id INT NOT NULL,
    menge INT NOT NULL CHECK (menge > 0),
    einzelpreis DECIMAL(10,2) NOT NULL CHECK (einzelpreis > 0),
    UNIQUE (bestellung_id, produkt_id),
    FOREIGN KEY (bestellung_id) REFERENCES bestellungen(bestellung_id),
    FOREIGN KEY (produkt_id) REFERENCES produkte(produkt_id)
);

CREATE TABLE rechnungen (
    rechnung_id INT AUTO_INCREMENT PRIMARY KEY,
    bestellung_id INT NOT NULL UNIQUE,
    rechnungsdatum DATE NOT NULL,
    faellig_am DATE NOT NULL,
    CHECK (faellig_am >= rechnungsdatum),
    FOREIGN KEY (bestellung_id) REFERENCES bestellungen(bestellung_id)
);

CREATE TABLE zahlungen (
    zahlung_id INT AUTO_INCREMENT PRIMARY KEY,
    rechnung_id INT NOT NULL,
    zahlungsdatum DATE NOT NULL,
    betrag DECIMAL(10,2) NOT NULL CHECK (betrag > 0),
    zahlungsart VARCHAR(30) NOT NULL,
    FOREIGN KEY (rechnung_id) REFERENCES rechnungen(rechnung_id)
);



INSERT INTO standorte (name, stadt) VALUES
('GFN Beispielstandort 1', 'Stuttgart'),
('GFN Beispielstandort 2', 'Berlin'),
('GFN Beispielstandort 3', 'Hamburg'),
('GFN Beispielstandort 4', 'Muenchen'),
('GFN Beispielstandort 5', 'Koeln'),
('GFN Beispielstandort 6', 'Leipzig'),
('GFN Beispielstandort 7', 'Dresden'),
('GFN Beispielstandort 8', 'Bremen'),
('GFN Beispielstandort 9', 'Hannover'),
('GFN Beispielstandort 10', 'Essen');

INSERT INTO abteilungen (standort_id, name) VALUES
(1, 'Verwaltung'),
(2, 'IT'),
(3, 'Vertrieb'),
(1, 'Buchhaltung'),
(2, 'Personal'),
(3, 'Einkauf'),
(1, 'Lager'),
(2, 'Kundenservice'),
(3, 'Schulungsplanung'),
(1, 'Marketing');

INSERT INTO mitarbeiter (abteilung_id, vorname, nachname, email, eintrittsdatum) VALUES
(1, 'Anna', 'Weber', 'mitarbeiter1@gfn.example', '2025-01-01'),
(2, 'Ben', 'Fischer', 'mitarbeiter2@gfn.example', '2025-02-01'),
(3, 'Clara', 'Wagner', 'mitarbeiter3@gfn.example', '2025-03-01'),
(4, 'David', 'Becker', 'mitarbeiter4@gfn.example', '2025-04-01'),
(5, 'Elena', 'Hoffmann', 'mitarbeiter5@gfn.example', '2025-05-01'),
(6, 'Finn', 'Schulz', 'mitarbeiter6@gfn.example', '2025-06-01'),
(7, 'Greta', 'Koch', 'mitarbeiter7@gfn.example', '2025-07-01'),
(8, 'Henry', 'Richter', 'mitarbeiter8@gfn.example', '2025-08-01'),
(9, 'Ida', 'Wolf', 'mitarbeiter9@gfn.example', '2025-09-01'),
(10, 'Jonas', 'Klein', 'mitarbeiter10@gfn.example', '2025-10-01');

INSERT INTO kunden (firma, email, stadt) VALUES
('Beispielfirma 1', 'kontakt@kunde1.example', 'Stuttgart'),
('Beispielfirma 2', 'kontakt@kunde2.example', 'Berlin'),
('Beispielfirma 3', 'kontakt@kunde3.example', 'Hamburg'),
('Beispielfirma 4', 'kontakt@kunde4.example', 'Muenchen'),
('Beispielfirma 5', 'kontakt@kunde5.example', 'Koeln'),
('Beispielfirma 6', 'kontakt@kunde6.example', 'Leipzig'),
('Beispielfirma 7', 'kontakt@kunde7.example', 'Dresden'),
('Beispielfirma 8', 'kontakt@kunde8.example', 'Bremen'),
('Beispielfirma 9', 'kontakt@kunde9.example', 'Hannover'),
('Beispielfirma 10', 'kontakt@kunde10.example', 'Essen');

INSERT INTO lieferanten (firma, email) VALUES
('Lehrmittel Beispiel 1', 'kontakt@lieferant1.example'),
('Lehrmittel Beispiel 2', 'kontakt@lieferant2.example'),
('Lehrmittel Beispiel 3', 'kontakt@lieferant3.example'),
('Lehrmittel Beispiel 4', 'kontakt@lieferant4.example'),
('Lehrmittel Beispiel 5', 'kontakt@lieferant5.example'),
('Lehrmittel Beispiel 6', 'kontakt@lieferant6.example'),
('Lehrmittel Beispiel 7', 'kontakt@lieferant7.example'),
('Lehrmittel Beispiel 8', 'kontakt@lieferant8.example'),
('Lehrmittel Beispiel 9', 'kontakt@lieferant9.example'),
('Lehrmittel Beispiel 10', 'kontakt@lieferant10.example');

INSERT INTO produkte (lieferant_id, name, preis) VALUES
(1, 'SQL Lernheft', 20),
(2, 'Java Lernheft', 25),
(3, 'Python Lernheft', 25),
(4, 'Netzwerk Lernheft', 30),
(5, 'Linux Lernheft', 20),
(6, 'Windows Lernheft', 20),
(7, 'Projektmappe', 5),
(8, 'Notizblock', 3),
(9, 'Uebungsbuch Datenbanken', 15),
(10, 'Pruefungsvorbereitung', 40);

INSERT INTO lager (produkt_id, bestand, mindestbestand) VALUES
(1, 5, 10),
(2, 20, 10),
(3, 8, 10),
(4, 30, 10),
(5, 10, 10),
(6, 4, 10),
(7, 50, 10),
(8, 60, 10),
(9, 2, 10),
(10, 15, 10);

INSERT INTO bestellungen (kunde_id, mitarbeiter_id, bestelldatum) VALUES
(1, 1, '2026-09-02'),
(2, 2, '2026-09-03'),
(3, 3, '2026-09-04'),
(4, 1, '2026-09-05'),
(5, 2, '2026-09-06'),
(6, 3, '2026-10-07'),
(7, 1, '2026-10-08'),
(8, 2, '2026-10-09'),
(1, 3, '2026-10-10'),
(2, 1, '2026-10-11');

INSERT INTO bestellpositionen (bestellung_id, produkt_id, menge, einzelpreis) VALUES
(1, 1, 2, 20),
(1, 2, 1, 25),
(2, 2, 3, 25),
(2, 3, 1, 25),
(3, 3, 1, 25),
(3, 4, 1, 30),
(4, 4, 2, 30),
(4, 5, 1, 20),
(5, 5, 3, 20),
(5, 6, 1, 20),
(6, 6, 1, 20),
(6, 7, 1, 5),
(7, 7, 2, 5),
(7, 8, 1, 3),
(8, 8, 3, 3),
(8, 9, 1, 15),
(9, 9, 1, 15),
(9, 10, 1, 40),
(10, 10, 2, 40),
(10, 1, 1, 20);

INSERT INTO rechnungen (bestellung_id, rechnungsdatum, faellig_am) VALUES
(1, '2026-09-03', '2026-09-17'),
(2, '2026-09-04', '2026-09-18'),
(3, '2026-09-05', '2026-09-19'),
(4, '2026-09-06', '2026-09-20'),
(5, '2026-09-07', '2026-09-21'),
(6, '2026-10-08', '2026-10-22'),
(7, '2026-10-09', '2026-10-23'),
(8, '2026-10-10', '2026-10-24'),
(9, '2026-10-11', '2026-10-25'),
(10, '2026-10-12', '2026-10-26');

INSERT INTO zahlungen (rechnung_id, zahlungsdatum, betrag, zahlungsart) VALUES
(1, '2026-09-06', 65, 'Ueberweisung'),
(2, '2026-09-07', 100, 'Ueberweisung'),
(3, '2026-09-08', 55, 'Ueberweisung'),
(4, '2026-09-09', 80, 'Ueberweisung'),
(5, '2026-09-10', 10, 'Ueberweisung'),
(5, '2026-09-10', 5, 'Ueberweisung'),
(6, '2026-10-11', 10, 'Ueberweisung'),
(6, '2026-10-11', 5, 'Ueberweisung'),
(7, '2026-10-12', 2, 'Ueberweisung'),
(7, '2026-10-12', 1, 'Ueberweisung');



CREATE VIEW rechnungsuebersicht AS
SELECT r.rechnung_id, r.bestellung_id, b.kunde_id, r.rechnungsdatum, r.faellig_am,
       s.rechnungsbetrag,
       COALESCE(z.gezahlt, 0) AS bezahlt,
       s.rechnungsbetrag - COALESCE(z.gezahlt, 0) AS offen
FROM rechnungen r
JOIN bestellungen b ON b.bestellung_id = r.bestellung_id
JOIN (
    SELECT bestellung_id, SUM(menge * einzelpreis) AS rechnungsbetrag
    FROM bestellpositionen
    GROUP BY bestellung_id
) s ON s.bestellung_id = r.bestellung_id
LEFT JOIN (
    SELECT rechnung_id, SUM(betrag) AS gezahlt
    FROM zahlungen
    GROUP BY rechnung_id
) z ON z.rechnung_id = r.rechnung_id;



SELECT * FROM standorte ORDER BY standort_id;

SELECT * FROM standorte WHERE stadt = 'Stuttgart';

SELECT COUNT(*) AS anzahl FROM standorte;

SELECT s.name, COUNT(a.abteilung_id) AS abteilungen FROM standorte s LEFT JOIN abteilungen a ON a.standort_id = s.standort_id GROUP BY s.standort_id, s.name;

SELECT s.name FROM standorte s LEFT JOIN abteilungen a ON a.standort_id = s.standort_id WHERE a.abteilung_id IS NULL;


SELECT * FROM mitarbeiter ORDER BY nachname;

SELECT m.vorname, m.nachname, a.name AS abteilung FROM mitarbeiter m JOIN abteilungen a ON a.abteilung_id = m.abteilung_id;

SELECT m.vorname, m.nachname FROM mitarbeiter m JOIN abteilungen a ON a.abteilung_id = m.abteilung_id WHERE a.name = 'IT';

SELECT * FROM mitarbeiter WHERE eintrittsdatum >= '2025-07-01';

SELECT m.vorname, m.nachname, COUNT(b.bestellung_id) AS bestellungen FROM mitarbeiter m LEFT JOIN bestellungen b ON b.mitarbeiter_id = m.mitarbeiter_id GROUP BY m.mitarbeiter_id, m.vorname, m.nachname;


SELECT * FROM abteilungen ORDER BY name;

SELECT COUNT(*) AS anzahl FROM abteilungen;

SELECT a.name, s.stadt FROM abteilungen a JOIN standorte s ON s.standort_id = a.standort_id;

SELECT a.name, COUNT(m.mitarbeiter_id) AS mitarbeiter FROM abteilungen a LEFT JOIN mitarbeiter m ON m.abteilung_id = a.abteilung_id GROUP BY a.abteilung_id, a.name;

SELECT a.name FROM abteilungen a JOIN standorte s ON s.standort_id = a.standort_id WHERE s.stadt = 'Stuttgart';


SELECT * FROM kunden ORDER BY firma;

SELECT * FROM kunden WHERE stadt = 'Berlin';

SELECT DISTINCT k.kunde_id, k.firma FROM kunden k JOIN bestellungen b ON b.kunde_id = k.kunde_id;

SELECT k.firma, COUNT(b.bestellung_id) AS bestellungen FROM kunden k LEFT JOIN bestellungen b ON b.kunde_id = k.kunde_id GROUP BY k.kunde_id, k.firma;

SELECT k.firma FROM kunden k LEFT JOIN bestellungen b ON b.kunde_id = k.kunde_id WHERE b.bestellung_id IS NULL;


SELECT * FROM produkte ORDER BY name;

SELECT name, preis FROM produkte WHERE preis <= 20;

SELECT p.name, l.firma FROM produkte p JOIN lieferanten l ON l.lieferant_id = p.lieferant_id;

SELECT p.name, SUM(bp.menge) AS bestellte_menge FROM produkte p JOIN bestellpositionen bp ON bp.produkt_id = p.produkt_id GROUP BY p.produkt_id, p.name ORDER BY bestellte_menge DESC, p.name;

SELECT ROUND(AVG(preis), 2) AS durchschnittspreis FROM produkte;


SELECT * FROM bestellungen ORDER BY bestelldatum;

SELECT b.bestellung_id, k.firma, b.bestelldatum FROM bestellungen b JOIN kunden k ON k.kunde_id = b.kunde_id;

SELECT p.name, bp.menge, bp.einzelpreis FROM bestellpositionen bp JOIN produkte p ON p.produkt_id = bp.produkt_id WHERE bp.bestellung_id = 1;

SELECT bestellung_id, SUM(menge * einzelpreis) AS gesamtbetrag FROM bestellpositionen GROUP BY bestellung_id;

SELECT * FROM bestellungen WHERE bestelldatum >= '2026-10-01' AND bestelldatum < '2026-11-01';


SELECT * FROM rechnungsuebersicht ORDER BY rechnung_id;

SELECT rechnung_id, rechnungsbetrag, bezahlt, offen FROM rechnungsuebersicht WHERE offen > 0;

SELECT rechnung_id, rechnungsbetrag FROM rechnungsuebersicht WHERE offen = 0;

SELECT DATE_FORMAT(rechnungsdatum, '%Y-%m') AS monat, SUM(rechnungsbetrag) AS umsatz FROM rechnungsuebersicht GROUP BY DATE_FORMAT(rechnungsdatum, '%Y-%m') ORDER BY monat;

SELECT rechnung_id, faellig_am, offen FROM rechnungsuebersicht WHERE offen > 0 AND faellig_am < '2026-11-03';


SELECT * FROM lieferanten ORDER BY firma;

SELECT p.name, l.bestand, l.mindestbestand FROM lager l JOIN produkte p ON p.produkt_id = l.produkt_id;

SELECT p.name, l.bestand, l.mindestbestand FROM lager l JOIN produkte p ON p.produkt_id = l.produkt_id WHERE l.bestand < l.mindestbestand;

SELECT p.name, f.firma, f.email FROM lager l JOIN produkte p ON p.produkt_id = l.produkt_id JOIN lieferanten f ON f.lieferant_id = p.lieferant_id WHERE l.bestand < l.mindestbestand;

SELECT SUM(l.bestand * p.preis) AS lagerwert_verkaufspreis FROM lager l JOIN produkte p ON p.produkt_id = l.produkt_id;


SELECT * FROM zahlungen ORDER BY zahlungsdatum;

SELECT SUM(betrag) AS gesamt FROM zahlungen;

SELECT rechnung_id, SUM(betrag) AS bezahlt FROM zahlungen GROUP BY rechnung_id;

SELECT rechnung_id, rechnungsbetrag, bezahlt, offen FROM rechnungsuebersicht WHERE bezahlt > 0 AND offen > 0;

SELECT rechnung_id, rechnungsbetrag FROM rechnungsuebersicht WHERE bezahlt = 0;
