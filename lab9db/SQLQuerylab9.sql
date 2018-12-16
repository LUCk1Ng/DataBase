 --nr1-1
 create procedure ex1_1
					@nume varchar(20)='Florea',
					@prenume varchar (20)='Ioan'

as 
select distinct d.Disciplina
from discipline d join studenti.studenti_reusita r
on d.Id_Disciplina=r.Id_Disciplina
join studenti s
on r.Id_Student=s.Id_Student
where s.Nume_Student=@nume and s.Prenume_Student=@prenume;

exec ex1_1

--nr1-2
create procedure ex1_2
				@tip_evaluare varchar(20)='Examen',
				@average_grade int=7
as
select distinct d.Disciplina 
from discipline as d join studenti.studenti_reusita as r
on d.Id_Disciplina=r.Id_Disciplina
join
(select Id_Student, avg(nota) as average_grade from studenti.studenti_reusita where Tip_Evaluare=@tip_evaluare group by id_student) as t
on r.Id_student=t.Id_Student
where t.average_grade>@average_grade
order by d.disciplina desc;

exec ex1_2


--nr2
CREATE PROCEDURE ex2
   @count_students INT = NULL OUTPUT
AS
SELECT @count_students =  COUNT(DISTINCT id_student) 
FROM studenti.studenti_reusita
WHERE Nota < 5 or Nota is NULL



DECLARE @count_students INT --Afisarea rezultatului
EXEC ex2 @count_students OUTPUT
PRINT 'Nr de studenti ce nu au sustinut cel putin o forma de evaluare = ' + cast(@count_students as VARCHAR(3))


--nr3
CREATE PROCEDURE ex3 
@nume VARCHAR(50),
@prenume VARCHAR(50),
@data DATE,
@adresa VARCHAR(500),
@cod_grupa CHAR(6)

AS
INSERT INTO studenti 
VALUES (175, @nume, @prenume, @data, @adresa)
INSERT INTO studenti.studenti_reusita
VALUES (175, 100, 100 , (SELECT Id_Grupa FROM grupe WHERE Cod_Grupa = @cod_grupa), 'Testul 1', NULL, '2018-12-05')

Exec ex3 @nume='Botnaru', @prenume='Victor', @data='1999-12-08', @adresa= 'mun. Chsinau, str. Orheiului, 8/2', @cod_grupa='TI171';

Select * from studenti;

Select * from studenti.studenti_reusita where Id_Profesor=102;

Select * from discipline;

Select * from profesori_new;




--nr4
CREATE PROCEDURE ex4_1
         @nume_prof_new varchar(25) 
		,@prenum_prof_new varchar(25)
		,@nume_prof_old varchar(25) ='Bivol'
		,@prenum_prof_old varchar(25) ='Ion' 
		,@disciplina varchar(50)= 'Baze de date' 
AS
IF @disciplina IN
(SELECT DISTINCT discipline.Disciplina
FROM plan_studii.discipline, studenti.studenti_reusita, cadre_didactice.profesori
WHERE discipline.Id_Disciplina=studenti_reusita.Id_Disciplina
AND studenti_reusita.Id_Profesor=profesori.Id_Profesor
AND Nume_Profesor = @nume_prof_old
AND Prenume_Profesor = @prenum_prof_old)
BEGIN 
	UPDATE cadre_didactice.profesori
	SET  Nume_Profesor = @nume_prof_new, Prenume_Profesor = @prenum_prof_new
	WHERE Id_Profesor = (SELECT Id_Profesor 
					FROM cadre_didactice.profesori
					WHERE Nume_Profesor = @nume_prof_old
					AND Prenume_Profesor = @prenum_prof_old)
	PRINT @disciplina+' este predata de de profesorul nou: '+@nume_prof_new+' '+@prenum_prof_new
END
	ELSE
BEGIN
	PRINT 'Disciplina data nu este predata de '+@nume_prof_old+' '+@prenum_prof_old
END

EXECUTE ex4_1 @nume_prof_new='Caba', @prenum_prof_new='Ion'



--nr5
CREATE PROCEDURE ex5
@discipline VARCHAR(50)
AS
DECLARE @best TABLE (Id_Student int, Media float)
INSERT INTO @best
	SELECT TOP (3) studenti.studenti_reusita.Id_Student, AVG(cast (Nota as float)) as Media
	FROM studenti.studenti_reusita, discipline
	WHERE discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina
	AND discipline.Disciplina = @discipline
	GROUP BY studenti.studenti_reusita.Id_Student
	ORDER BY Media desc		

SELECT cod_grupa, nume_student+' '+Prenume_Student as Nume, disciplina, nota AS Nota_Veche, iif(nota > 9, 10, nota + 1) AS Nota_Noua 
    FROM studenti.studenti_reusita, discipline, grupe, studenti
	WHERE discipline.id_disciplina = studenti.studenti_reusita.id_disciplina
	AND grupe.Id_Grupa = studenti.studenti_reusita.Id_Grupa
	AND  studenti.Id_Student = studenti.studenti_reusita.Id_Student
	AND studenti.Id_Student in (select Id_Student from @best)
	AND Disciplina = @discipline
	AND Tip_Evaluare = 'Examen'

UPDATE studenti.studenti_reusita
SET studenti.studenti_reusita.Nota = (CASE WHEN nota >= 9 THEN 10 ELSE nota + 1 END)
WHERE Tip_Evaluare = 'Examen'
AND Id_Disciplina = (Select Id_Disciplina from discipline where disciplina=@discipline)
AND Id_Student in (select Id_Student from @best)

EXEC ex5 @discipline = 'Baze de date'



--nr6-1
CREATE FUNCTION ex6__1 (@disciplina VARCHAR(20), @nota SMALLINT)
RETURNS TABLE
AS
RETURN
(SELECT distinct cadre_didactice.profesori.Nume_Profesor , cadre_didactice.profesori.Prenume_Profesor
FROM studenti.studenti_reusita join cadre_didactice.profesori
on studenti.studenti_reusita.Id_Profesor=cadre_didactice.profesori.Id_Profesor join discipline
on studenti.studenti_reusita.Id_Disciplina=discipline.Id_Disciplina
where discipline.Disciplina=@disciplina 
	 and studenti.studenti_reusita.Nota<@nota)


SELECT *
FROM  ex6__1('Baze de date', 7)




--nr6-2

reate function ex6_2 (@disciplina varchar(20), @tip_evaluare varchar(20))
returns table
as
return
(select count(t.Id_Student) "No of students", avg(t.reusita_curenta) "Media curenta totala"
from
(select distinct r.Id_Student, t.reusita_curenta
from studenti.studenti_reusita r join discipline d
on r.Id_Disciplina=d.Id_Disciplina
join (select r.id_student, avg(r.nota) as reusita_curenta
	  from studenti.studenti_reusita r
	  where r.Tip_Evaluare=@tip_evaluare
	  group by r.Id_Student) as t
on r.Id_Student=t.Id_Student
where d.Disciplina=@disciplina) as t)

select *
from ex6_2('Baze de date','Examen')



--nr7
create function e7(@Data_Nastere date)
returns int
as
begin
	DECLARE @Now datetime,@age int;
	SET @Now=GETDATE();      
	SELECT @age=(CONVERT(int,CONVERT(char(8),@Now,112))-CONVERT(char(8),@Data_Nastere,112))/10000;
	return @age;
end;

select *
From dbo.e7('2000-11-18')



--nr8
CREATE FUNCTION ex8 (@nume_prenume_s VARCHAR(50))
RETURNS TABLE 
AS
RETURN
(SELECT Nume_Student + ' ' + Prenume_Student as Student, Disciplina, Nota, Data_Evaluare
 FROM studenti, discipline, studenti.studenti_reusita
 WHERE studenti.Id_Student = studenti.studenti_reusita.Id_Student
 AND discipline.Id_Disciplina = studenti.studenti_reusita.Id_Disciplina 
 AND Nume_Student + ' ' + Prenume_Student = @nume_prenume_s )


 SELECT * 
 FROM ex8('Ene Mihai')


 --nr9
 CREATE FUNCTION lab9_ex9 (@cod_grupa VARCHAR(10), @is_good VARCHAR(20))
RETURNS @Test Table (Cod_Grupa varchar(10), Student varchar (100), Media decimal(4,2), Reusita varchar(20))
AS
begin

if @is_good = 'sirguincios'
begin
insert into @Test

SELECT top (1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student as Student,
		 CAST(AVG( Nota * 1.0) as decimal (4,2)) as Media, @is_good
 FROM grupe,studenti, studenti.studenti_reusita
 WHERE grupe.Id_Grupa = studenti.studenti_reusita.Id_Grupa
 AND studenti.Id_Student = studenti.studenti_reusita.Id_Student
 AND Cod_Grupa = @cod_grupa
 GROUP BY Cod_Grupa, Nume_Student, Prenume_Student
 Order by Media desc
 end

 else

 begin 
 insert into @Test
SELECT top (1) Cod_Grupa, Nume_Student + ' ' + Prenume_Student as Student,
		 CAST(AVG( Nota * 1.0) as decimal (4,2)) as Media, @is_good
 FROM grupe,studenti, studenti.studenti_reusita
 WHERE grupe.Id_Grupa = studenti.studenti_reusita.Id_Grupa
 AND studenti.Id_Student = studenti.studenti_reusita.Id_Student
 AND Cod_Grupa = @cod_grupa
 GROUP BY Cod_Grupa, Nume_Student, Prenume_Student
 Order by Media 
 end

 RETURN 
 end


 Select *
 From dbo.lab9_ex9('INF171','sirguincios')
