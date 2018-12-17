
![image](https://user-images.githubusercontent.com/43127951/50071932-219ed100-01dc-11e9-9477-396e69663259.png)


1. Query 2 : Sa se obtina lista disciplinelor in ordine descrescatoare a numarului de ore.

USE universitatea 
SELECT Nr_ore_plan_disciplina, Disciplina FROM discipline 
ORDER BY Nr_ore_plan_disciplina desc

![image](https://user-images.githubusercontent.com/43127951/50071985-527f0600-01dc-11e9-97f6-f3e2e89526ce.png)

2. Query 20: Afisati numarul de studenti care au sustinut testul (Testul 2) la disciplina Baze de date in 2018.

select count(*) 
from studenti_reusita s, discipline d 
where s.Tip_Evaluare = 'Testul 2' and year(s.Data_Evaluare) = 2017 and s.Nota > 4 
and d.Disciplina = 'Baze de date' and s.Id_Disciplina = d.Id_Disciplina

![image](https://user-images.githubusercontent.com/43127951/50072012-6cb8e400-01dc-11e9-863a-9c101b0b855f.png)

3. Query 26: Gasiti numele, prenumele ~i adresele studentilor ~i ale profesorilor care locuiesc pe strada 31 August.

select s.Nume_Student as Nume, s.Prenume_Student as Prenume, s.Adresa_Postala_Student as Adresa 
from studenti s 
where s.Adresa_Postala_Student like '%31 August%' 
union 
select p.Nume_Profesor, p.Prenume_Profesor, p.Adresa_Postala_Profesor 
from profesori p 
where p.Adresa_Postala_Profesor like '%31 August%'

![image](https://user-images.githubusercontent.com/43127951/50072043-878b5880-01dc-11e9-9617-91f668d76881.png)

4. Query 37: Gasiti disciplina sustinuta de studenti cu nota medie (la examen) cea main inalta.

select top(1) d.Disciplina, AVG(r.Nota) as Media 
from studenti_reusita r, discipline d 
where r.Tip_Evaluare = 'Examen' and r.Id_Disciplina = d.Id_Disciplina 
group by d.Disciplina 
order by 2 desc


![image](https://user-images.githubusercontent.com/43127951/50072103-b0abe900-01dc-11e9-9839-dedfec99f891.png)
