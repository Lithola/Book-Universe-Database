
--select * from  Artefakt;
--select * from KSIAZKA;

--Wypisz wszystkie tytuły książek odbywających się w galaktyce Zalarax:

SELECT Tytul
    from Ksiazka k
inner join PLANETA p on k.PLANETA_PLANETA_ID=p.Planeta_ID
Where  p.GALAKTYKA = 'Zalarax';
------------------------------------------
------------------------------------------PROSTE ZAPYTANIA---------------------------------------
--Wypisz wszystkie moce które mają drugorzędny żywioł:

SELECT Nazwa
from Moc m
inner join Typ_mocy t on m.Typ_mocy_Typ_mocy_ID=t.TYP_MOCY_ID
where t.NAZWA_DRUGORZEDNEGO_ZYWIOLU is not null;

--Wypisz wszystkie tytuły adaptacji i książek, które były adaptowane na anime:

SELECT k.Tytul, a2.Tytul
from Ksiazka k
inner join Ksiazka_adaptacja ka on k.KSIAZKA_ID=ka.Ksiazka_Ksiazka_ID
inner join Adaptacja A2 on ka.ADAPTACJA_ADAPTACJA_ID=a2.ADAPTACJA_ID
inner join Typ_adaptacji typ on A2.TYP_ADAPTACJI_TYP_ADAPTACJI_ID=typ.TYP_ADAPTACJI_ID
where typ.Nazwa='anime';
------------------------------------------PODZAPYTANIA-------------------------------------------------
--Wypisz wszystkie imiona postaci które mieszkają na tej samej planecie co Vivian

SELECT Imie
from POSTAC
where Imie!='Vivian' and Planeta_Planeta_ID =(Select Planeta_Planeta_ID
from Postac
where Imie = 'Vivian');

--dla każdej planety wypisz tytuł książki rozgrywającej się na danej planecie z największą liczbą stron

SELECT k.Tytul
from Ksiazka k
where k.Liczba_stron = (SELECT MAX(Liczba_stron)
from KSIAZKA k2
where k.Planeta_Planeta_ID=k2.Planeta_Planeta_ID);
------------------------------------------AGREGACJE-------------------------------------------------------


--oblicz średnią liczbę stron z książek, które są częściami serii
select avg(Liczba_stron)
from KSIAZKA
where Seria_Seria_ID is not null;

--wypisz sumę stron każdej serii która posiada adaptację
select Nazwa_serii,Sum(LICZBA_STRON)
from SERIA inner join KSIAZKA K on SERIA.SERIA_ID = K.SERIA_SERIA_ID
where SERIA_ID in (select SERIA_ID from SERIA
    inner join KSIAZKA on SERIA.SERIA_ID = KSIAZKA.SERIA_SERIA_ID
    INNER JOIN KSIAZKA_ADAPTACJA
        on KSIAZKA.KSIAZKA_ID = KSIAZKA_ADAPTACJA.KSIAZKA_KSIAZKA_ID)
group by Nazwa_serii;
