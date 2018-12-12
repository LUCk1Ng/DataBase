--nr6
CREATE SCHEMA cadre_didactice ;

CREATE SCHEMA plan_studii;

CREATE SCHEMA studenti;

ALTER SCHEMA cadre_didactice
TRANSFER dbo.profesori;

ALTER SCHEMA dbo
TRANSFER cadre_didactice.profesori;

ALTER SCHEMA plan_studii
TRANSFER dbo.discipline;

ALTER SCHEMA plan_studii
TRANSFER dbo.orarul;

ALTER SCHEMA studenti
TRANSFER dbo.studenti;

ALTER SCHEMA studenti
TRANSFER dbo.studenti_reusita;


--nr7-1
SELECT  DISTINCT discipline.Disciplina
FROM plan_studii.discipline
WHERE Nr_ore_plan_disciplina=80 OR Nr_ore_plan_disciplina=60

--nr7-2

SELECT  DISTINCT studenti.Nume_Student ,studenti.Prenume_Student,
                 studenti_reusita.Tip_Evaluare
                ,studenti_reusita.Nota
FROM studenti.studenti, studenti.studenti_reusita, plan_studii.discipline
WHERE studenti.studenti.Id_Student=studenti.studenti_reusita.Id_Student
AND studenti_reusita.Id_Disciplina=discipline.Id_Disciplina
AND studenti_reusita.Nota=10

--nr8
CREATE SYNONYM studenti FOR studenti.studenti
CREATE SYNONYM reusita FOR studenti.studenti_reusita
CREATE SYNONYM discipline FOR plan_studii.discipline

SELECT studenti.Nume_Student, studenti.Prenume_Student, reusita.Tip_Evaluare, reusita.Nota
FROM studenti, reusita
Where studenti.Id_Student=reusita.Id_Student
AND reusita.Nota=10;