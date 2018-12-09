USE universitatea
SELECT Nr_ore_plan_disciplina, Disciplina FROM discipline
ORDER BY Nr_ore_plan_disciplina desc

select count(*)
from studenti_reusita s, discipline d
where s.Tip_Evaluare = 'Testul 2' and year(s.Data_Evaluare) = 2017 and s.Nota > 4 
and d.Disciplina = 'Baze de date' and s.Id_Disciplina = d.Id_Disciplina

select s.Nume_Student as Nume, s.Prenume_Student as Prenume, s.Adresa_Postala_Student as Adresa
from studenti s
where s.Adresa_Postala_Student like '%31 August%'
union
select p.Nume_Profesor, p.Prenume_Profesor, p.Adresa_Postala_Profesor
from profesori p
where p.Adresa_Postala_Profesor like '%31 August%'

select top(1) d.Disciplina, AVG(r.Nota) as Media
from studenti_reusita r, discipline d
where r.Tip_Evaluare = 'Examen' and r.Id_Disciplina = d.Id_Disciplina
group by d.Disciplina
order by 2 desc
