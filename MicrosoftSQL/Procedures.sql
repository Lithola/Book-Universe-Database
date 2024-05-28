--Napisz procedurę, która przyjmuje nazwę typu artefaktu i dla każdej postaci posiadającej dany typ artefaktu
-- zmienia datę śmierci na 2000-02-20. Następnie wyświetli w konsoli wszystkie te postacie w formie
-- "Ala posiadająca Magiczną Tarczę zmarła 2000-02-20". Procedura poprzez parametr OUTPUT zwróci również
-- liczbę tych postaci.
ALTER PROCEDURE UpdateCharacterByArtifactType
    @TypArtefaktu varchar(50),
    @LiczbaPostaci int OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Postac_ID int;
    DECLARE @Informacja nvarchar(1000);

    UPDATE Postac
    SET Data_smierci = '2000-02-20'
    WHERE Postac_ID IN (
        SELECT p.Postac_ID
        FROM Postac p
        INNER JOIN Artefakt a ON p.Postac_ID = a.Postac_Postac_ID
        INNER JOIN Typ_przedmiotu tp ON a.Typ_przedmiotu_Typ_ID = tp.Typ_ID
        WHERE tp.Nazwa = @TypArtefaktu
    );

    SET @LiczbaPostaci = 0;

    DECLARE cursorPostacie CURSOR FOR
        SELECT p.Postac_ID, CONCAT('Postac ', p.Imie, ' posiadająca ', tp.Nazwa, ' zmarła 2000-02-20') AS Informacja
        FROM Postac p
        INNER JOIN Artefakt a ON p.Postac_ID = a.Postac_Postac_ID
        INNER JOIN Typ_przedmiotu tp ON a.Typ_przedmiotu_Typ_ID = tp.Typ_ID
        WHERE tp.Nazwa = @TypArtefaktu;

    OPEN cursorPostacie;




    FETCH NEXT FROM cursorPostacie INTO @Postac_ID, @Informacja;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @Informacja;

        FETCH NEXT FROM cursorPostacie INTO @Postac_ID, @Informacja;
        SET @LiczbaPostaci = @LiczbaPostaci +1;
    END;

    CLOSE cursorPostacie;
    DEALLOCATE cursorPostacie;
END;

--wywołanie
DECLARE @LiczbaPostaci int;

EXEC UpdateCharacterByArtifactType 'Kostur', @LiczbaPostaci OUTPUT;

PRINT 'Liczba postaci: ' + CAST(@LiczbaPostaci AS varchar(100));



-- Utwórz wyzwalacz, który nie pozwoli przypisać postaci imienia zaczynającego się na literę W.

CREATE TRIGGER PreventNameStartingWithW
ON Postac
FOR INSERT
AS
BEGIN

    IF EXISTS (
        SELECT *
        FROM inserted
        WHERE Imie LIKE 'W%'
    )
    BEGIN

        RAISERROR('Nie można przypisać postaci imienia zaczynającego się na literę W.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;


    INSERT INTO Postac (Postac_ID, Imie, Data_urodzin, Data_smierci, Planeta_Planeta_ID)
    SELECT Postac_ID, Imie, Data_urodzin, Data_smierci, Planeta_Planeta_ID
    FROM inserted;
END;

INSERT INTO Postac VALUES
    (9, 'William','2000-02-20','2000-02-20', 1 );

    select *
    from postac;


--Napisz funkcję przyjmującą nazwę serii jako paramter. Funkcja musi zwrócić postacie występujące w tej serii.

CREATE FUNCTION GetCharactersBySeriesName(@Nazwa_serii VARCHAR(100))
RETURNS TABLE
AS
RETURN (
    SELECT P.Postac_ID, P.Imie, P.Data_urodzin, P.Data_smierci
    FROM Postac P
    INNER JOIN Postacie_ksiazek PK ON P.Postac_ID = PK.Postac_Postac_ID
    INNER JOIN Ksiazka K ON PK.Ksiazka_Ksiazka_ID = K.Ksiazka_ID
    INNER JOIN Seria S ON K.Seria_Seria_ID = S.Seria_ID
    WHERE S.Nazwa_serii = @Nazwa_serii
);
SELECT *
FROM GetCharactersBySeriesName('Lowcy Yaergana');