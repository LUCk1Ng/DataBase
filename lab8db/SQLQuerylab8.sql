--nr1
CREATE VIEW task1 AS
SELECT Disciplina, Nr_ore_plan_disciplina
FROM discipline
WHERE Nr_ore_plan_disciplina>60

SELECT * FROM task1

--nr2
CREATE VIEW task3 AS
SELECT Id_Disciplina, Disciplina, Nr_ore_plan_disciplina
FROM discipline
WHERE Nr_ore_plan_disciplina>60 

--Insert intro view
INSERT INTO task3( Id_Disciplina,Disciplina, Nr_ore_plan_disciplina) VALUES(200,'Grafica pe calculator',66)

--Update the view
UPDATE task3 SET Disciplina='Proiectare' WHERE Nr_ore_plan_disciplina=66;

--Delete the view
DELETE FROM task3 WHERE Nr_ore_plan_disciplina=66;

SELECT * FROM task3

--nr5
WITH mediaNotelorperDisciplina(Id_Disciplina,Media_notelor) AS
	(SELECT Id_Disciplina, AVG(Nota)
	FROM studenti.studenti_reusita
	GROUP BY Id_Disciplina)

SELECT DISTINCT d.Disciplina, m.Media_notelor FROM studenti.studenti_reusita AS s
	inner join mediaNotelorperDisciplina AS m
	ON m.Id_Disciplina=s.Id_Disciplina
	and m.Media_notelor>5
	inner join plan_studii.discipline AS d
	ON d.Id_Disciplina=m.Id_Disciplina

--nr5-2
WITH lungimeDisciplina(Id_Disciplina, Nume_Disciplina) AS
	(SELECT Id_Disciplina,Disciplina 
     FROM plan_studii.discipline)
SELECT l.Id_Disciplina,l.Nume_Disciplina FROM lungimeDisciplina AS l
WHERE DATALENGTH(l.Nume_Disciplina)>20

--nr6
DECLARE @Graph_tab table
(ID INT,
prev_ID INT)
INSERT @Graph_tab
select 5, null union all
select 4, null union all
select 3, null union all
select 0, 5 union all
select 2, 4 union all
select 2, 3 union all
select 1, 2 union all
select 0, 1;

with mygraph
as
(SELECT *, prev_ID as pred_Nod,0 as generation from @Graph_tab where prev_ID IS NULL and ID=3
	UNION ALL
		SELECT graph.*,mygraph.ID as pred_Nod, generation+1
			from @Graph_tab as graph
			inner join mygraph
			on graph.prev_ID=mygraph.ID)

SELECT * FROM mygraph;

