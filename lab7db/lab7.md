1. Creati o diagrama a bazei de date, folosind forma de vizualizare standard, structura careia este descrisa la inceputul sarcinilor practice din capitolul 4.

![image](https://user-images.githubusercontent.com/43127951/50054225-73961700-0148-11e9-9acb-bdd28b729024.png)


2. Sa se adauge constrangeri referentiale (legate cu tabelele studenti si profesori) necesare coloanelor Sef_grupa si Prof_Indrumator (sarcina3, capitolul 6) din tabelul grupe.

![image](https://user-images.githubusercontent.com/43127951/50054233-7f81d900-0148-11e9-867f-cc091f7bc76f.png)


3. La diagrama construită, să se adauge și tabelul orarul definit în capitolul 6 al acestei lucrari:tabelul orarul conține identificatorul disciplinei (ld_Disciplina), identificatorul profesorului(Id_Profesor) și blocul de studii (Bloc). Cheia tabelului este constituită din trei cîmpuri: identificatorul grupei (Id_ Grupa), ziua lectiei (Z1), ora de inceput a lectiei (Ora), sala unde are loc lectia (Auditoriu).

![image](https://user-images.githubusercontent.com/43127951/50054241-8ad50480-0148-11e9-8827-17e7663b365f.png)


4. Tabelul orarul trebuie să conțină și 2 chei secundare: (Zi, Ora, Id_ Grupa, Id_ Profesor) și (Zi, Ora, ld_Grupa, ld_Disciplina).

![image](https://user-images.githubusercontent.com/43127951/50054248-9f190180-0148-11e9-90ed-1235b97416f1.png)


5. În diagrama, de asemenea, trebuie sa se defineasca constrangerile referentiale (FK-PK) ale atributelor ld_Disciplina, ld_Profesor, Id_ Grupa din tabelului orarul cu atributele tabelelor respective.

![image](https://user-images.githubusercontent.com/43127951/50054255-adffb400-0148-11e9-94ae-0b42de17862d.png)

6. Creați, în baza de date universitatea, trei scheme noi: cadre_didactice, plan_studii și studenti. Transferați tabelul profesori din schema dbo in schema cadre didactice, ținînd cont de dependentele definite asupra tabelului menționat. În același mod să se trateze tabelele orarul,discipline care aparțin schemei plan_studii și tabelele studenți, studenti_reusita, care apartin schemei studenti. Se scrie instructiunile SQL respective.

![image](https://user-images.githubusercontent.com/43127951/50054264-c7086500-0148-11e9-9e37-2ec616f7c3f5.png)

7. Modificati 2-3 interogari asupra bazei de date universitatea prezentate in capitolul 4 astfel ca numele tabelelor accesate sa fie descrise in mod explicit, ținînd cont de faptul ca tabelele au fost mutate in scheme noi. Interogarare:

7-1

![image](https://user-images.githubusercontent.com/43127951/50054280-f323e600-0148-11e9-8276-c77d6ab80ee2.png)

7-2

![image](https://user-images.githubusercontent.com/43127951/50054302-19e21c80-0149-11e9-8c9a-f94448362c14.png)

8. Creați sinonimele respective pentru a simplifica interogările construite în exercițiul precedent și reformulați interogările, folosind sinonimele create.

![image](https://user-images.githubusercontent.com/43127951/50054308-35e5be00-0149-11e9-91a5-3dd10f8f62c7.png)

