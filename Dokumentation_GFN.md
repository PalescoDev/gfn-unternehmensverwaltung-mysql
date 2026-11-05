Dokumentation – GFN Unternehmensverwaltung

Version 1.0.9

Für das Projekt haben wir eine einfache MySQL-Datenbank erstellt. Als Beispiel dient GFN. Alle Namen und Abläufe sind ausgedacht. In unserem Beispiel bestellen Firmen Lernhefte und Schulungsunterlagen.

Aufbau der Datenbank

Es gibt 11 Tabellen. Ein Standort hat mehrere Abteilungen. Jeder Mitarbeiter gehört zu einer Abteilung und kann Bestellungen bearbeiten. Jede Bestellung ist einem Kunden zugeordnet.

In den Bestellpositionen stehen die Produkte, Mengen und Preise einer Bestellung. Der Preis beim Kauf wird extra gespeichert, damit spätere Preisänderungen alte Bestellungen nicht verändern.

Jedes Produkt hat einen Lieferanten und einen Lagerbestand. Liegt der Bestand unter dem Mindestbestand, wird es in der Abfrage zum Nachbestellen angezeigt.

Zu einer Bestellung kann es eine Rechnung geben. Zahlungen werden der Rechnung zugeordnet. Auch mehrere Teilzahlungen sind möglich. Die Rechnungsübersicht berechnet, wie viel schon bezahlt wurde und was noch offen ist.

Die Tabellen sind über Primärschlüssel und Fremdschlüssel verbunden. IDs und Mengen sind ganze Zahlen, Namen sind Textfelder und Geldbeträge haben zwei Nachkommastellen. NOT NULL bedeutet, dass ein Wert vorhanden sein muss. CHECK verhindert zum Beispiel negative Bestände.

Daten und Abfragen

Insgesamt sind 120 Beispieldatensätze enthalten. Jede Tabelle hat zehn Einträge, die Bestellpositionen haben zwanzig. Für die neun Aufgabenbereiche gibt es jeweils fünf Abfragen, also insgesamt 45.

Damit lassen sich zum Beispiel Mitarbeiter mit ihren Abteilungen, Kundenbestellungen, beliebte Produkte, offene Rechnungen und der monatliche Umsatz anzeigen.

Mit den Beispieldaten beträgt der Umsatz im September 380 Euro und im Oktober 217 Euro. Insgesamt sind 333 Euro bezahlt und 264 Euro offen. Vier Produkte müssen nachbestellt werden. Der Umsatz wird nach Rechnungsdatum berechnet.
