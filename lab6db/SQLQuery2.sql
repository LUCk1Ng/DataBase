USE universitatea
go

--nr.1
update profesori
set Adresa_Postala_Profesor = 'mun.Chisinau'
where Adresa_Postala_Profesor is null;

--nr.2
create unique index idx_cod_grupa
on grupe (cod_grupa)
exec sp_helpindex grupe;
/*
nu putem crea un indice cluster unic
pentru că această tabelă a avut
un index cluster - cheie primară
*/

--nr.3

alter table grupe add sef_grupa int,prof_indrumator int ;

declare @nr_grupe int = (select COUNT(Id_Grupa)
from grupe)
declare @init int =1;


while(@init<=@nr_grupe)
	begin

			update grupe
			--selectarea sefului de grupa dupa media cea mai mare
			set sef_grupa = (select top 1 x.Id_Student
			from(
			select  Id_Student,avg(cast(Nota as float)) as Media
			from studenti_reusita 
			where Id_Grupa=@init
			group by Id_Student
			) x
			order by x.Media desc),
			--pentru selectare profesorul indrumator dupa nr de discipline maxim
			prof_indrumator = (select y.Id_Profesor
			from(
			select top 1 Id_Profesor ,count(distinct Id_Disciplina) as nr_disc
			from studenti_reusita
			where Id_Grupa=@init
			GROUP BY Id_Profesor 
			order by nr_disc desc) y)
			
			where Id_Grupa=	@init
			set @init = @init+1;
	end
--adaugare indexului unique pentru cimpurile noi create
alter table grupe add constraint prof_stud unique(sef_grupa,prof_indrumator);

--nr.4

update studenti_reusita
set Nota =  Nota +1
where Tip_Evaluare='Examen' 
		and Id_Student = any(select sef_grupa from grupe) 
		and Nota !=10

--nr.5
CREATE TABLE new_profesori
(
	Id_Profesor int primary key,
	Nume_Profesor char (50),
	Prenume_Profesor char (50),
	Localitate char (60) DEFAULT ('mun. Chisinau'),
	Adresa_1 char (60),
	Adresa_2 char (60)
	)
INSERT INTO new_profesori (Id_Profesor,Nume_Profesor, Prenume_Profesor, Localitate,Adresa_1, Adresa_2)
(SELECT Id_Profesor, Nume_Profesor, Prenume_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor, Adresa_Postala_Profesor
from profesori)

  -- Drop the function if it already exists
  IF OBJECT_ID('INSTR', 'FN') IS NOT NULL
	DROP FUNCTION INSTR
  GO

  CREATE FUNCTION INSTR (@str VARCHAR(8000), @substr VARCHAR(255), @start INT, @occurrence INT)
  RETURNS INT
  AS
  BEGIN
	DECLARE @found INT = @occurrence,
			@pos INT = @start;
 
	WHILE 1=1 
	BEGIN
		-- Find the next occurrence
		SET @pos = CHARINDEX(@substr, @str, @pos);
 
		-- Nothing found
		IF @pos IS NULL OR @pos = 0
			RETURN @pos;
 
		-- The required occurrence found
		IF @found = 1
			BREAK;
 
		-- Prepare to find another one occurrence
		SET @found = @found - 1;
		SET @pos = @pos + 1;
	END
 
	RETURN @pos;
  END
  GO

INSERT INTO new_profesori(Id_Profesor, Nume_Profesor, Prenume_Profesor, Localitate, Adresa_1, Adresa_2)
 SELECT Id_Profesor
        , Nume_Profesor
		, Prenume_Profesor
		, CASE 
		WHEN LEN(Adresa_Postala_Profesor)-LEN(REPLACE(Adresa_Postala_Profesor, ',', ''))=3 then  Substring(Adresa_Postala_Profesor,1, dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 2)-1)
		WHEN LEN(Adresa_Postala_Profesor)-LEN(REPLACE(Adresa_Postala_Profesor, ',', '')) =2 THEN Substring(Adresa_Postala_Profesor,1, charindex(',',Adresa_Postala_Profesor)-1)
		ELSE Adresa_Postala_Profesor
		END as  localitate
		, CASE 
		WHEN LEN(Adresa_Postala_Profesor)-LEN(REPLACE(Adresa_Postala_Profesor, ',', ''))=3 then  Substring(Adresa_Postala_Profesor,dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 2)+1, (dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 3))-(dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 2))-1)
		WHEN LEN(Adresa_Postala_Profesor)-LEN(REPLACE(Adresa_Postala_Profesor, ',', '')) =2 THEN Substring(Adresa_Postala_Profesor,dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 1)+1,(dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 2))-(dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 1))-1)
		ELSE NULL
		END as  Adresa_1
		, CASE 
		WHEN LEN(Adresa_Postala_Profesor)-LEN(REPLACE(Adresa_Postala_Profesor, ',', ''))=3 then  Substring(Adresa_Postala_Profesor,dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 3)+1, 5)
		WHEN LEN(Adresa_Postala_Profesor)-LEN(REPLACE(Adresa_Postala_Profesor, ',', '')) =2 THEN Substring(Adresa_Postala_Profesor,dbo.INSTR(Adresa_Postala_Profesor, ',', 1, 2)+1, 5)
		ELSE NULL
		END as  Adresa_2
		 FROM profesori
		 select * from new_profesori
select * from new_profesori


--nr.6
create table orarul 
( 
	Id_Disciplina int,
	Id_Profesor int,
	Id_Grupa smallint default(1),
	Zi char(10),
	Ora Time,
    Auditoriu int,
	Bloc char(1) default('B') );
	
	
	Insert into orarul (Id_Disciplina , Id_Profesor, Zi, Ora, Auditoriu)
	values ( 107, 101, 'Luni','08:00', 202 ),
			( 108, 101, 'Luni','11:30', 501 ),
			( 109, 117, 'Luni','13:00', 501 );

			select * from orarul

--nr.7
INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values (
	        (select Id_Disciplina from discipline where Disciplina = 'Structuri de date si algoritmi'),
	        (select Id_Profesor from profesori where Nume_Profesor = 'Bivol' and Prenume_Profesor = 'Ion'),
		    (select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 
		    'Luni', 
		    '08:00')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values (
	        (select Id_Disciplina from discipline where Disciplina = 'Programe aplicative'),
		    (select Id_Profesor from profesori where Nume_Profesor = 'Mircea' and Prenume_Profesor = 'Sorin'),
		    (select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 
		    'Luni', 
		    '11:30')

INSERT INTO orarul (Id_Disciplina, Id_Profesor, Id_Grupa, Zi, Ora)
values (
	        (select Id_Disciplina from discipline where Disciplina = 'Baze de date'),
		    (select Id_Profesor from profesori where Nume_Profesor = 'Micu' and Prenume_Profesor = 'Elena'),
		    (select Id_Grupa from grupe where Cod_Grupa = 'INF171'), 
		    'Luni', 
		    '13:00')

		select * from orarul

--nr 8
create nonclustered index test1
on plan_studii.discipline(Disciplina);
create nonclustered index test2
on studenti.studenti_reusita(Tip_Evaluare,Data_Evaluare,Nota);
set statistics io on
set statistics time on
select  p.Nume_Student,p.Prenume_Student
from studenti as p inner join studenti.studenti_reusita as r
on p.Id_Student = r.Id_Student 
inner join plan_studii.discipline as k on k.Id_Disciplina=r.Id_Disciplina
and  r.Tip_Evaluare='Examen' and k.Disciplina='Baze de date' and r.Data_Evaluare like'2018%'
where r.Nota between 4 and 8
set statistics time on
