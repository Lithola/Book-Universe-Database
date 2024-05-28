--    Napisz blok PL/SQL z kursorem, który wyświetli imię i datę urodzenia wszystkich postaci z tabeli Postac.

DECLARE
   CURSOR c_Postacie IS
      SELECT Imie, Data_urodzin
      FROM Postac;
   v_Imie VARCHAR2(50);
   v_DataUrodzin DATE;
BEGIN
   OPEN c_Postacie;
   LOOP
      FETCH c_Postacie INTO v_Imie, v_DataUrodzin;
      EXIT WHEN c_Postacie%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Postać: ' || v_Imie || ', Data urodzenia: ' || TO_CHAR(v_DataUrodzin, 'DD-MM-YYYY'));
   END LOOP;
   CLOSE c_Postacie;
END;


--Napisz procedurę o nazwie GetHeroesCount,
-- która przyjmuje identyfikator serii jako parametr wejściowy.
-- Procedura powinna zwrócić liczbę postaci związanych z tą serią za pomocą parametru wyjściowego.
CREATE OR REPLACE PROCEDURE GetHeroesCount(p_SeriaID IN INTEGER, p_Count OUT INTEGER) IS
BEGIN
   SELECT COUNT(*)
   INTO p_Count
   FROM Ksiazka K
   JOIN Postacie_ksiazek PK ON K.Ksiazka_ID = PK.Ksiazka_Ksiazka_ID
   WHERE K.Seria_Seria_ID = p_SeriaID;
END;
/



-- Napisz wyzwalacz o nazwie UpdateDeathDate, który zostanie aktywowany przed aktualizacją kolumny "Data_smierci"
-- w tabeli Postac. Wyzwalacz powinien sprawdzić, czy wcześniej data śmierci była pusta i jeśli nowa wartość daty śmierci
-- jest niepusta, wyświetlić komunikat o aktualizacji daty śmierci dla danej postaci.

CREATE OR REPLACE TRIGGER UpdateDeathDate
BEFORE UPDATE OF Data_smierci ON Postac
FOR EACH ROW
BEGIN
   IF :OLD.Data_smierci IS NULL AND :NEW.Data_smierci IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE('Zaktualizowano datę śmierci dla postaci ' || :NEW.Imie);
   END IF;
END;
/

UPDATE Postac
SET Data_smierci = SYSDATE
WHERE Postac_ID = 1;


-- Napisz funkcję o nazwie GetPlanetName,
-- która przyjmuje identyfikator postaci jako parametr wejściowy. Funkcja powinna zwrócić nazwę planety, na której znajduje się ta postać.
CREATE OR REPLACE FUNCTION GetPlanetName(p_PostacID IN INTEGER)
 RETURN VARCHAR2
    AS
   v_PlanetaName VARCHAR2(50);
BEGIN
   SELECT Nazwa
   INTO v_PlanetaName
   FROM Postac P
   JOIN Planeta PL ON P.Planeta_Planeta_ID = PL.Planeta_ID
   WHERE P.Postac_ID = p_PostacID;

   RETURN v_PlanetaName;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN NULL;
END;
/

DECLARE
   v_PlanetaName VARCHAR2(50);
BEGIN
   v_PlanetaName := GetPlanetName(1);
   IF v_PlanetaName IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('Nie znaleziono planety dla podanej postaci.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Planeta dla postaci: ' || v_PlanetaName);
   END IF;
END;
/