1.Sa se scrie o intructiune T-SQL, care ar popula coloana Adresa_Postala_Profesor din tabelul profesori cu valoarea 'mun.Chisinau', unde adresa este necunoscuta.

![image](https://user-images.githubusercontent.com/43127951/50053997-bf938c80-0145-11e9-90f8-a1b69b68dafe.png)

![image](https://user-images.githubusercontent.com/43127951/50054007-d639e380-0145-11e9-86cd-03820e7fd0c4.png)


2. Sa se modifice schema tabelului grupe, ca sa corespunda urmatoarele cerinte: a) Campul Cod_Grupa sa accepte numai valorile unice si sa nu accepte valori necunoscute. b) Sa se tina cont ca cheia primara, deja, este definita asupra coloanei Id_Grupa

![image](https://user-images.githubusercontent.com/43127951/50054018-eb167700-0145-11e9-80fb-bed2005fae64.png)

![image](https://user-images.githubusercontent.com/43127951/50054024-f79acf80-0145-11e9-9ef1-bd7f588d2f6b.png)

3. La tabelul grupe, sa se adauge 2 coloane noi Sef_grupa si Prof_Indrumator, ambele de tip Int. Sa se populeze campurile nou-create cu cele mai potrivite candidaturi in baza criteriilor de mai jos.
a) Seful grupei trebuie sa aiba cea mai buna reusita (media) din grupa la toate formele de evaluare si la toate disciplinile. Un student nu poate fi sef de grupa la mai multe grupe.

b) Profesorul indrumator trebuie sa predea un numar maximal posibil de disciplina la grupa data. Daca nu exista o singura candidatura, care corespunde primei cerinte, atunci este ales din grupul de candidati acel cu identificatorul (Id_Profesor) minimal. Un profesor nu poate fi indrumator la mai multe grupe.

c) Sa se scire instructiuile ALTER, SELECT, UPDATE necesare pentru crearea coloanelor in tabelul grupe, pentru selectarea candidatilor si inserarea datelor. 

![image](https://user-images.githubusercontent.com/43127951/50054035-29139b00-0146-11e9-95d3-19b3bd613883.png)

![image](https://user-images.githubusercontent.com/43127951/50054038-392b7a80-0146-11e9-95fa-ead7ee418785.png)

4. Sa se scrie o instructiune T-SQL, care ar mari toate notele de evaluare sefilor de grupe cu un punct Nota maximala (10) nu poate fi marita.

![image](https://user-images.githubusercontent.com/43127951/50054048-709a2700-0146-11e9-866a-214e7e50c284.png)


5. Sa se creeze un tabel profesori_new, care include urmatoarele coloane: Id_Profesor, Nume_Profesor, Prenume_Profesor, Localitate, Adresa_1, Adresa_2.
a) Coloana Id_Profesor trebuie sa fie definita drept cheie primara si, in baza ei, sa fie constuit un index CLUSTERED. b) Cimpul localitate treebuie sa posede proprietatea DEFAULT='mun.Chisinau'. c) Sa se insereze toate datele din tabelul profesori in tabelul profesori_new. Sa se scrie cu acest scop un numar potrivit de instructiuni T-SQL. Datele trebuie sa fie transferate in felul urmator

In coloana Localitate sa fie inserata doar informatia despre denumirea localitatii din coloana-sursa Adresa_Postala_Profesor. In coloana Adresa_1, doar denumirea strazii. In coloana Adresa_2, sa se pastreze numarul casei si (posibil) a apartamentului. 

![image](https://user-images.githubusercontent.com/43127951/50054086-f1f1b980-0146-11e9-880d-a068e6b3cfbb.png)

![image](https://user-images.githubusercontent.com/43127951/50054088-003fd580-0147-11e9-83d3-444607eb9bbd.png)



6. Sa se insereze datele in tabelul orarul pentru Grupa= 'CIBJ 71' (Id_ Grupa= 1) pentru ziua de luni. Toate lectiile vor avea loc in blocul de studii 'B'.
Mai jos, sunt prezentate detaliile de inserare: (ld_Disciplina = 107, Id_Profesor= 101, Ora ='08:00', Auditoriu = 202); (Id_Disciplina = 108, Id_Profesor= 101, Ora ='11:30', Auditoriu = 501); (ld_Disciplina = 119, Id_Profesor= 117, Ora ='13:00', Auditoriu = 501); 

![image](https://user-images.githubusercontent.com/43127951/50054097-1e0d3a80-0147-11e9-964c-0826c11fa38c.png)


7. Sa se scrie expresiile T-SQL necesare pentru a popula tabelul orarul pentru grupa INF 171, ziua de luni. Datele necesare pentru inserare trebuie sa fie colectate cu ajutorul instructiunii/instructiunilor SELECT si introduse in tabelul-destinatie, stiind ca: lectie #1 (Ora ='08:00', Disciplina = 'Structuri de date si algoritmi', Profesor ='Bivol Ion') lectie #2 (Ora ='11 :30', Disciplina = 'Programe aplicative', Profesor ='Mircea Sorin') lectie #3 (Ora ='13:00', Disciplina ='Baze de date', Profesor = 'Micu Elena')

![image](https://user-images.githubusercontent.com/43127951/50054105-4f860600-0147-11e9-9dbd-e5d519493a52.png)


8. Sa se scrie interogarile de creare a indecsilor asupra tabelelor din baza de date universitatea pentru a asigura o performanta sporita la executarea interogarilor SELECT din Lucrarea practica 4. Rezultatele optimizarii sa fie analizate in baza planurilor de executie, pana la si dupa crearea indecsilor. Indecsii nou-creati sa fie plasati fizic in grupul de fisiere userdatafgroupl (Crearea si intrefinerea bazei de date - sectiunea 2.2.2)

![image](https://user-images.githubusercontent.com/43127951/50054117-66c4f380-0147-11e9-9e12-dc23a6470d05.png)

#Before
![image](https://user-images.githubusercontent.com/43127951/50054132-aa1f6200-0147-11e9-8600-cd2b41bbaec8.png)

#After
![image](https://user-images.githubusercontent.com/43127951/50054140-c4f1d680-0147-11e9-9045-fc186eb88bbd.png)
