

-- foreign keys
ALTER TABLE Adaptacja
    DROP CONSTRAINT Adaptacja_Typ_adaptacji;

ALTER TABLE Artefakt
    DROP CONSTRAINT Artefakt_Postac;

ALTER TABLE Artefakt
    DROP CONSTRAINT Artefakt_Typ_przedmiotu;

ALTER TABLE Ksiazka
    DROP CONSTRAINT Ksiazka_Planeta;

ALTER TABLE Ksiazka
    DROP CONSTRAINT Ksiazka_Seria;

ALTER TABLE Ksiazka_adaptacja
    DROP CONSTRAINT Ksiazka_adaptacja_Adaptacja;

ALTER TABLE Ksiazka_adaptacja
    DROP CONSTRAINT Ksiazka_adaptacja_Ksiazka;

ALTER TABLE Moc
    DROP CONSTRAINT Moc_Typ_mocy;

ALTER TABLE Moce_postaci
    DROP CONSTRAINT Moce_postaci_Moc;

ALTER TABLE Moce_postaci
    DROP CONSTRAINT Moce_postaci_Postac;

ALTER TABLE Postac
    DROP CONSTRAINT Postac_Planeta;

ALTER TABLE Postacie_ksiazek
    DROP CONSTRAINT Postacie_ksiazek_Ksiazka;

ALTER TABLE Postacie_ksiazek
    DROP CONSTRAINT Postacie_ksiazek_Postac;

ALTER TABLE Zwiazki_postaci
    DROP CONSTRAINT Zwiazki_postaci_Postac;

ALTER TABLE Zwiazki_postaci
    DROP CONSTRAINT Zwiazki_postaci_Postac2;

-- tables
DROP TABLE Adaptacja;

DROP TABLE Artefakt;

DROP TABLE Ksiazka;

DROP TABLE Ksiazka_adaptacja;

DROP TABLE Moc;

DROP TABLE Moce_postaci;

DROP TABLE Planeta;

DROP TABLE Postac;

DROP TABLE Postacie_ksiazek;

DROP TABLE Seria;

DROP TABLE Typ_przedmiotu;

DROP TABLE Typ_adaptacji;

DROP TABLE Typ_mocy;

DROP TABLE Zwiazki_postaci;

-- End of file.


-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-04-22 00:49:25.995

-- tables
-- Table: Adaptacja
CREATE TABLE Adaptacja (
    Adaptacja_ID integer  NOT NULL,
    Tytul varchar(100)  NOT NULL,
    Dlugosc integer  NOT NULL,
    Liczba_odcinkow integer  NULL,
    Data_premiery date  NOT NULL,
    Typ_adaptacji_Typ_adaptacji_ID integer  NOT NULL,
    CONSTRAINT Adaptacja_pk PRIMARY KEY (Adaptacja_ID)
) ;

-- Table: Artefakt
CREATE TABLE Artefakt (
    Artefakt_ID integer  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    Postac_Postac_ID integer  NOT NULL,
    Typ_przedmiotu_Typ_ID integer  NOT NULL,
    CONSTRAINT Artefakt_pk PRIMARY KEY (Artefakt_ID)
) ;

-- Table: Ksiazka
CREATE TABLE Ksiazka (
    Ksiazka_ID integer  NOT NULL,
    Tytul varchar(100)  NOT NULL,
    Liczba_stron integer  NOT NULL,
    Seria_Seria_ID integer  NULL,
    Planeta_Planeta_ID integer  NOT NULL,
    CONSTRAINT Ksiazka_pk PRIMARY KEY (Ksiazka_ID)
) ;

-- Table: Ksiazka_adaptacja
CREATE TABLE Ksiazka_adaptacja (
    Ksiazka_Ksiazka_ID integer  NOT NULL,
    Adaptacja_Adaptacja_ID integer  NOT NULL,
    CONSTRAINT Ksiazka_adaptacja_pk PRIMARY KEY (Ksiazka_Ksiazka_ID,Adaptacja_Adaptacja_ID)
) ;

-- Table: Moc
CREATE TABLE Moc (
    Moc_ID integer  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    Przynaleznosc varchar(50)  NOT NULL,
    Typ_mocy_Typ_mocy_ID integer  NOT NULL,
    CONSTRAINT Moc_pk PRIMARY KEY (Moc_ID)
) ;

-- Table: Moce_postaci
CREATE TABLE Moce_postaci (
    Postac_Postac_ID integer  NOT NULL,
    Moc_Moc_ID integer  NOT NULL,
    CONSTRAINT Moce_postaci_pk PRIMARY KEY (Postac_Postac_ID,Moc_Moc_ID)
) ;

-- Table: Planeta
CREATE TABLE Planeta (
    Planeta_ID integer  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    Galaktyka varchar(50)  NOT NULL,
    Dlugosc_dnia integer  NOT NULL,
    Rok_zniszczenia date  NULL,
    CONSTRAINT Planeta_pk PRIMARY KEY (Planeta_ID)
) ;

-- Table: Postac
CREATE TABLE Postac (
    Postac_ID integer  NOT NULL,
    Imie varchar(50)  NOT NULL,
    Data_urodzin date  NOT NULL,
    Data_smierci date  NULL,
    Planeta_Planeta_ID integer  NOT NULL,
    CONSTRAINT Postac_pk PRIMARY KEY (Postac_ID)
) ;

-- Table: Postacie_ksiazek
CREATE TABLE Postacie_ksiazek (
    Ksiazka_Ksiazka_ID integer  NOT NULL,
    Postac_Postac_ID integer  NOT NULL,
    CONSTRAINT Postacie_ksiazek_pk PRIMARY KEY (Ksiazka_Ksiazka_ID,Postac_Postac_ID)
) ;

-- Table: Seria
CREATE TABLE Seria (
    Seria_ID integer  NOT NULL,
    Nazwa_serii varchar(100)  NOT NULL,
    Liczba_ksiazek smallint  NOT NULL,
    CONSTRAINT Seria_pk PRIMARY KEY (Seria_ID)
) ;

-- Table: Typ_adaptacji
CREATE TABLE Typ_adaptacji (
    Typ_adaptacji_ID integer  NOT NULL,
    Nazwa varchar(100)  NOT NULL,
    CONSTRAINT Typ_adaptacji_pk PRIMARY KEY (Typ_adaptacji_ID)
) ;

-- Table: Typ_mocy
CREATE TABLE Typ_mocy (
    Typ_mocy_ID integer  NOT NULL,
    Nazwa_zywiolu varchar(50)  NOT NULL,
    Nazwa_drugorzednego_zywiolu varchar(50)  NULL,
    CONSTRAINT Typ_mocy_pk PRIMARY KEY (Typ_mocy_ID)
) ;

-- Table: Typ_przedmiotu
CREATE TABLE Typ_przedmiotu (
    Typ_ID integer  NOT NULL,
    Nazwa varchar(50)  NOT NULL,
    CONSTRAINT Typ_przedmiotu_pk PRIMARY KEY (Typ_ID)
) ;

-- Table: Zwiazki_postaci
CREATE TABLE Zwiazki_postaci (
    Postac_Postac_ID integer  NOT NULL,
    Postac_2_Postac_ID integer  NOT NULL,
    CONSTRAINT Zwiazki_postaci_pk PRIMARY KEY (Postac_Postac_ID,Postac_2_Postac_ID)
) ;

-- foreign keys
-- Reference: Adaptacja_Typ_adaptacji (table: Adaptacja)
ALTER TABLE Adaptacja ADD CONSTRAINT Adaptacja_Typ_adaptacji
    FOREIGN KEY (Typ_adaptacji_Typ_adaptacji_ID)
    REFERENCES Typ_adaptacji (Typ_adaptacji_ID);

-- Reference: Artefakt_Postac (table: Artefakt)
ALTER TABLE Artefakt ADD CONSTRAINT Artefakt_Postac
    FOREIGN KEY (Postac_Postac_ID)
    REFERENCES Postac (Postac_ID);

-- Reference: Artefakt_Typ_przedmiotu (table: Artefakt)
ALTER TABLE Artefakt ADD CONSTRAINT Artefakt_Typ_przedmiotu
    FOREIGN KEY (Typ_przedmiotu_Typ_ID)
    REFERENCES Typ_przedmiotu (Typ_ID);

-- Reference: Ksiazka_Planeta (table: Ksiazka)
ALTER TABLE Ksiazka ADD CONSTRAINT Ksiazka_Planeta
    FOREIGN KEY (Planeta_Planeta_ID)
    REFERENCES Planeta (Planeta_ID);

-- Reference: Ksiazka_Seria (table: Ksiazka)
ALTER TABLE Ksiazka ADD CONSTRAINT Ksiazka_Seria
    FOREIGN KEY (Seria_Seria_ID)
    REFERENCES Seria (Seria_ID);

-- Reference: Ksiazka_adaptacja_Adaptacja (table: Ksiazka_adaptacja)
ALTER TABLE Ksiazka_adaptacja ADD CONSTRAINT Ksiazka_adaptacja_Adaptacja
    FOREIGN KEY (Adaptacja_Adaptacja_ID)
    REFERENCES Adaptacja (Adaptacja_ID);

-- Reference: Ksiazka_adaptacja_Ksiazka (table: Ksiazka_adaptacja)
ALTER TABLE Ksiazka_adaptacja ADD CONSTRAINT Ksiazka_adaptacja_Ksiazka
    FOREIGN KEY (Ksiazka_Ksiazka_ID)
    REFERENCES Ksiazka (Ksiazka_ID);

-- Reference: Moc_Typ_mocy (table: Moc)
ALTER TABLE Moc ADD CONSTRAINT Moc_Typ_mocy
    FOREIGN KEY (Typ_mocy_Typ_mocy_ID)
    REFERENCES Typ_mocy (Typ_mocy_ID);

-- Reference: Moce_postaci_Moc (table: Moce_postaci)
ALTER TABLE Moce_postaci ADD CONSTRAINT Moce_postaci_Moc
    FOREIGN KEY (Moc_Moc_ID)
    REFERENCES Moc (Moc_ID);

-- Reference: Moce_postaci_Postac (table: Moce_postaci)
ALTER TABLE Moce_postaci ADD CONSTRAINT Moce_postaci_Postac
    FOREIGN KEY (Postac_Postac_ID)
    REFERENCES Postac (Postac_ID);

-- Reference: Postac_Planeta (table: Postac)
ALTER TABLE Postac ADD CONSTRAINT Postac_Planeta
    FOREIGN KEY (Planeta_Planeta_ID)
    REFERENCES Planeta (Planeta_ID);

-- Reference: Postacie_ksiazek_Ksiazka (table: Postacie_ksiazek)
ALTER TABLE Postacie_ksiazek ADD CONSTRAINT Postacie_ksiazek_Ksiazka
    FOREIGN KEY (Ksiazka_Ksiazka_ID)
    REFERENCES Ksiazka (Ksiazka_ID);

-- Reference: Postacie_ksiazek_Postac (table: Postacie_ksiazek)
ALTER TABLE Postacie_ksiazek ADD CONSTRAINT Postacie_ksiazek_Postac
    FOREIGN KEY (Postac_Postac_ID)
    REFERENCES Postac (Postac_ID);

-- Reference: Zwiazki_postaci_Postac (table: Zwiazki_postaci)
ALTER TABLE Zwiazki_postaci ADD CONSTRAINT Zwiazki_postaci_Postac
    FOREIGN KEY (Postac_2_Postac_ID)
    REFERENCES Postac (Postac_ID);

-- Reference: Zwiazki_postaci_Postac2 (table: Zwiazki_postaci)
ALTER TABLE Zwiazki_postaci ADD CONSTRAINT Zwiazki_postaci_Postac2
    FOREIGN KEY (Postac_Postac_ID)
    REFERENCES Postac (Postac_ID);

-- End of file.




INSERT INTO Typ_adaptacji VALUES
(1, 'film');
INSERT INTO Typ_adaptacji VALUES
(2, 'serial');
INSERT INTO Typ_adaptacji VALUES
(3, 'gra komputerowa');
INSERT INTO Typ_adaptacji VALUES
(4, 'sztuka teatralna');
INSERT INTO Typ_adaptacji VALUES
(5, 'anime');

INSERT INTO Seria VALUES
(1, 'Lowcy Yaergana',3);
INSERT INTO Seria VALUES
(2, 'Kultowy Kult',2);
INSERT INTO Seria VALUES
(3, 'Epopeja Ferrhanzy',5);
INSERT INTO Seria VALUES
(4, 'Dzieje Viol',6);
INSERT INTO Seria VALUES
(5, 'Krysztaly Czasu',13);

INSERT into Planeta VALUES
(1, 'Yenor', 'Yennu', 31, '1234-06-01');
INSERT into Planeta VALUES
(2, 'Astraea', 'Aenor', 20, '0123-06-01');
INSERT into Planeta VALUES
(3, 'Armageddona', 'Arma', 69, NULL);
INSERT into Planeta VALUES
(4, 'Veranis', 'Zalarax', 19, NULL);
INSERT into Planeta VALUES
(5, 'Spherus Magna', 'Zalarax', 25, Null);

INSERT INTO Typ_mocy Values
(1, 'Ogien', Null);
INSERT INTO Typ_mocy Values
(2, 'Woda', 'Ziemia');
INSERT INTO Typ_mocy Values
(3, 'Serce', null);
INSERT INTO Typ_mocy Values
(4, 'Necro', null);
INSERT INTO Typ_mocy Values
(5, 'Vita', 'Ziemia');

INSERT INTO Moc VALUES
(1,'Kula ognia','neutralna',1);
INSERT INTO Moc VALUES
(2, 'Wypalenie duszy', 'zla', 1);
INSERT INTO Moc VALUES
(3, 'lawina blotna', 'neutralna',2);
INSERT INTO Moc VALUES
(4, 'Porost', 'dobra', 5);
INSERT INTO Moc VALUES
(5, 'Palec smierci', 'zla', 4);



 INSERT INTO Postac VALUES
(1, 'Armageddon', '0666-06-01', NULL, 2);
INSERT INTO Postac VALUES
(2, 'Magh', '0001-03-03', '1341-04-05', 5 );
INSERT INTO Postac VALUES
(3, 'Vin', '1111-06-06', '1134-12-30', 2);
INSERT INTO Postac VALUES
(4, 'Vivian', '1869-04-13', NULL, 1);
INSERT INTO Postac VALUES
(5, 'Certus', '1795-02-17', null, 1);
INSERT INTO Postac VALUES
(6, 'Orvan', '1845-08-16', null, 1);
INSERT INTO Postac VALUES
(7, 'Erian', '1801-08-01', null, 1);


INSERT INTO Zwiazki_postaci VALUES
(1, 2);
INSERT INTO Zwiazki_postaci VALUES
(4,5);
INSERT INTO Zwiazki_postaci VALUES
(4,6);
INSERT INTO Zwiazki_postaci VALUES
(4,7);
INSERT INTO Zwiazki_postaci VALUES
(6, 7);


INSERT INTO Moce_postaci VALUES
(1, 2);
INSERT INTO Moce_postaci VALUES
(1, 1);
INSERT INTO Moce_postaci VALUES
(1, 3);
INSERT INTO Moce_postaci VALUES
(1, 5);
INSERT INTO Moce_postaci VALUES
(3, 3);
INSERT INTO Moce_postaci VALUES
(4, 4);

INSERT INTO Ksiazka VALUES
(1, 'Mglak', 645, 1, 1 );
INSERT INTO Ksiazka VALUES
(2, 'Czaszka', 333, 1, 1);
INSERT INTO Ksiazka VALUES
(3, 'Uriel Odrodzony', 468, 1,1 );
INSERT INTO Ksiazka VALUES
(4, 'Pomnij zycie', 599, 4, 5 );
INSERT INTO Ksiazka VALUES
(5, 'Dziedzictwo Azgara', 321, 4,5 );
INSERT INTO Ksiazka VALUES
(6, 'Caitha nie byla nigdy', 177, 3, 5 );
INSERT INTO Ksiazka VALUES
(7, 'Milosc Very', 500, 4, 3);
INSERT INTO Ksiazka VALUES
(8, 'Szmaragdowy plomien', 864, NULL, 3);


INSERT INTO Postacie_ksiazek VALUES
(1, 5);
INSERT INTO Postacie_ksiazek VALUES
(3, 6);
INSERT INTO Postacie_ksiazek VALUES
(1, 7);
INSERT INTO Postacie_ksiazek VALUES
(8, 1);
INSERT INTO Postacie_ksiazek VALUES
(7, 1);

INSERT INTO Adaptacja VALUES
(1,'Ferrhanza', 7000, 13, '2023-01-23', 2 );
INSERT INTO Adaptacja VALUES
(2, 'Ferrhanza unlimited', 1390, 48, '2030-01-23', 5);
INSERT INTO Adaptacja VALUES
(3, 'Yaergan', 125, null, '2020-09-07', 1);
INSERT INTO Adaptacja VALUES
(4, 'Huntah Combat', 5000, null, '2018-11-06', 3);
INSERT INTO Adaptacja VALUES
(5,'Jak zabic bestie i miec faceta', 4080, 169, '2017-04-04', 5);


INSERT INTO Ksiazka_adaptacja VALUES
(5,1);
INSERT INTO Ksiazka_adaptacja VALUES
(6, 2);
INSERT INTO Ksiazka_adaptacja VALUES
(2, 3);
INSERT INTO Ksiazka_adaptacja VALUES
(1, 4);
INSERT INTO Ksiazka_adaptacja VALUES
(3, 5);

insert into TYP_PRZEDMIOTU values
(5,'Miecz');
insert into TYP_PRZEDMIOTU values
(1,'Kostur');
insert into TYP_PRZEDMIOTU values
(2,'Bransoleta');
insert into TYP_PRZEDMIOTU values
(3,'Tarcza');
insert into TYP_PRZEDMIOTU values
(4,'Księga');

INSERT INTO Artefakt VALUES
(1, 'Necronomicon',7,4);

INSERT INTO Artefakt VALUES
(2, 'Puklerz Łowcy',5,3);
INSERT INTO Artefakt VALUES
(3, 'Panarcanis Ars Goetia',4,1);
INSERT INTO Artefakt VALUES
(4, 'Leo Fastus',6,5);
INSERT INTO Artefakt VALUES
(5, 'Predickium',1,1);

DELETE From Artefakt
where ARTEFAKT_ID =1;
UPDATE KSIAZKA
set TYTUL = 'Uriel Martwy'
where TYTUL='Uriel Odrodzony';
