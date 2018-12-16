--nr1
DROP TRIGGER IF EXISTS ex1
GO
CREATE TRIGGER ex1 ON plan_studii.orarul
	AFTER UPDATE
	AS SET NOCOUNT ON 
	IF UPDATE (Auditoriu)
	SELECT	'Lectia la disciplina ' + UPPER(Disciplina)+ ' de la ora '+ CAST(inserted.Ora AS VARCHAR(5))+
	               ', pentru Cod grupa '+ Cod_Grupa+' din ziua de '+ inserted.Zi +
                    ', blocul '+inserted.Bloc+' din auditoriul vechi: '+ CAST(del.Auditoriu AS CHAR(10))+
					'se modifica in auditoriul nou '+ CAST(inserted.Auditoriu AS CHAR(10))
	FROM inserted JOIN grupe g ON inserted.Id_Grupa=g.Id_Grupa
						  JOIN plan_studii.discipline d ON inserted.Id_Disciplina = d.Id_Disciplina 
						  JOIN deleted del ON del.Id_Grupa=g.Id_Grupa

UPDATE plan_studii.orarul SET Auditoriu =512 WHERE Zi='Lu'

--nr2

USE universitatea;
GO
IF OBJECT_ID('Ex2', 'TR') IS NOT NULL
DROP TRIGGER Ex2;
GO
CREATE TRIGGER Ex2 ON studenti.studenti
INSTEAD OF INSERT
AS
SET NOCOUNT ON
DECLARE @Id_Student int
SELECT @Id_Student = Id_Student FROM inserted
INSERT INTO studenti.studenti_reusita(Id_Disciplina, Id_Grupa,Id_Student,Id_Profesor,Data_Evaluare,Tip_Evaluare,Nota) 
	VALUES (101,2,@Id_Student,105,'2018-12-01','Testul 3',8.00);
INSERT INTO studenti.studenti
SELECT * FROM inserted
GO
select * from studenti.studenti
INSERT INTO studenti.studenti VALUES(189,'Caba','Vasile','1998-11-18','mun. Chisinau, str. Orheiului, 4')


--nr3
CREATE TRIGGER ex_3 ON studenti.studenti_reusita
AFTER UPDATE
AS
SET NOCOUNT ON
 IF UPDATE(NOTA)
DECLARE @ID_GRUPA INT = (select Id_Grupa from grupe where Cod_Grupa='CIB171')
IF (SELECT AVG(NOTA) FROM deleted WHERE Id_Grupa=@ID_GRUPA AND NOTA IS NOT NULL)>(SELECT AVG(NOTA) FROM inserted WHERE Id_Grupa=@ID_GRUPA AND NOTA IS NOT NULL)
BEGIN
PRINT('Interzisa micsorarea notelor in valori nenule in CIB171')
ROLLBACK TRANSACTION
END
IF UPDATE(DATA_EVALUARE) 
BEGIN
PRINT 'Interzisa modificarea datelor din Data_Evaluare'
ROLLBACK TRANSACTION
end


UPDATE studenti_reusita SET Nota=nota-1 WHERE Id_Grupa= (select Id_Grupa from grupe where Cod_Grupa='CIB171'


--nr4
GO 
CREATE TRIGGER ex4 on database
FOR Alter_Table
AS 
SET NOCOUNT ON
DECLARE @data_nastere varchar(50)
SELECT @data_nastere=EVENTDATA().value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]', 'nvarchar(100)') 
	IF @data_nastere='Data_Nastere_Student'
	BEGIN 
	PRINT ('Interzisa modificarea coloanei Data_Nastere_Student')
	rollback;
	END

ALTER TABLE studenti.studenti ALTER COLUMN Data_Nastere_Student date

--nr5
CREATE TRIGGER ex5 ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
DECLARE @time DATETIME  
DECLARE @start DATETIME  
DECLARE @end DATETIME  
DECLARE @flag FLOAT  
DECLARE @flag1 FLOAT  

SELECT @time = GETDATE() 
SELECT @start = '2011-12-22 9:00:00.000'  
SELECT @end = '2011-12-22 18:00:00.000' 
SELECT @flag =(cast(@time as float) - 
			floor(cast(@time as float)))- 
			(cast(@start as float) - floor(cast(@start as FLOAT))), 
			
			               
       @flag1 = (cast(@time as float) - 
	   floor(cast(@time as float))) -
	   (cast(@end as float) - floor(cast(@end as FLOAT))) 
 
 IF @flag<0 OR @flag1>0   
 BEGIN   
 Print ('Interzisa modificarea schemei bazei in afara orelor de lucru ')  
  ROLLBACK   
  END

ALTER TABLE plan_studii.discipline ADD incercare int


--nr6
IF EXISTS (SELECT * FROM sys.triggers WHERE parent_class=0 AND name='Ex_6')
DROP TRIGGER Ex_6 ON DATABASE;
GO
CREATE TRIGGER Ex_6 ON DATABASE
FOR ALTER_TABLE
AS
SET NOCOUNT ON
DECLARE @nume varchar(50)
DECLARE @int_I varchar(500)
DECLARE @int_M varchar(500)
DECLARE @den_T varchar(50)
SELECT @nume=EVENTDATA().
value('(/EVENT_INSTANCE/AlterTableActionList/*/Columns/Name)[1]','nvarchar(max)')
IF @nume = 'Nume_Profesor'
BEGIN
SELECT @int_I = EVENTDATA().value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)')
SELECT @den_T = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]','nvarchar(max)')
SELECT @int_M = REPLACE(@int_I, @den_T, 'profesori');EXECUTE (@int_M)
PRINT 'Datele au fost modificate'
END
go