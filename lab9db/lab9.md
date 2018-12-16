1. Sa se creeze proceduri stocate in baza exercitiilor (2 exercitii) din capitolul 4. Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.

1-1

![image](https://user-images.githubusercontent.com/43127951/50055472-2e79e100-0158-11e9-868f-a236899a8e59.png)

1-2

![image](https://user-images.githubusercontent.com/43127951/50055484-4f423680-0158-11e9-8e6e-40dc8a71ca30.png)


2. Sa se creeze o procedura stocata, care nu are niciun parametru de intrare si poseda un parametru de iesire. Parametrul de iesire trebuie sa returneze numarul de studenti, care nu au sustinut cel putin o forma de evaluare (nota mai mica de 5 sau valoare NULL).

![image](https://user-images.githubusercontent.com/43127951/50055491-6123d980-0158-11e9-87e8-32adf1348c00.png)


3. Sa se creeze o procedura stocata, care ar insera in baza de date informatii despre un student nou. in calitate de parametri de intrare sa serveasca datele personale ale studentului nou si Cod_ Grupa. Sa se genereze toate intrarile-cheie necesare in tabelul studenti_reusita. Notele de evaluare sa fie inserate ca NULL.

![image](https://user-images.githubusercontent.com/43127951/50055492-7436a980-0158-11e9-96d4-b854c09b2287.png)


4. Fie ca un profesor se elibereaza din functie la mijlocul semestrului. Sa se creeze o procedura stocata care ar reatribui inregistrarile din tabelul studenti_reusita unui alt profesor. Parametri de intrare: numele si prenumele profesorului vechi, numele si prenumele profesorului nou, disciplina. in cazul in care datele inserate sunt incorecte sau incomplete, sa se afiseze un mesaj de avertizare.

![image](https://user-images.githubusercontent.com/43127951/50055494-8284c580-0158-11e9-9fea-779b90cb9493.png)

5. Sa se creeze o procedura stocata care ar forma o lista cu primii 3 cei mai buni studenti la o disciplina, si acestor studenti sa le fie marita nota la examenul final cu un punct (nota maximala posibila este 10). in calitate de parametru de intrare, va servi denumirea disciplinei. Procedura sa returneze urmatoarele campuri: Cod_ Grupa, Nume_Prenume_Student, Disciplina, Nota _ Veche, Nota _ Noua

![image](https://user-images.githubusercontent.com/43127951/50055497-90d2e180-0158-11e9-9433-a05bfb36f791.png)


6. Sa se creeze functii definite de utilizator in baza exercitiilor (2 exercitii) din capitolul 4. Parametrii de intrare trebuie sa corespunda criteriilor din clauzele WHERE ale exercitiilor respective.

6-1

![image](https://user-images.githubusercontent.com/43127951/50055526-f6bf6900-0158-11e9-8beb-357d07bb8327.png)

6-2

![image](https://user-images.githubusercontent.com/43127951/50055532-0dfe5680-0159-11e9-9bca-83d8077a7a57.png)


7. Sa se scrie functia care ar calcula varsta studentului. Sa se defineasca urmatorul format al functiei: ().

![image](https://user-images.githubusercontent.com/43127951/50055535-1a82af00-0159-11e9-931e-ef781c45fdf3.png)


8. Sa se creeze o functie definita de utilizator, care ar returna datele referitoare la reusita unui student. Se defineste urmatorul format al functiei: (<Nume_Prenume_Student>). Sa fie afisat tabelul cu urmatoarele campuri: Nume_Prenume_Student, Disticplina, Nota, Data_Evaluare.

![image](https://user-images.githubusercontent.com/43127951/50055539-279f9e00-0159-11e9-8e97-84be2bf03727.png)


9. Se cere realizarea unei functii definite de utilizator, care ar gasi cel mai sarguincios sau cel mai slab student dintr-o grupa. Se defineste urmatorul format al functiei: (<Cod_ Grupa>, <is_good>). Parametrul <is_good> poate accepta valorile "sarguincios" sau "slab", respectiv. Functia sa returneze un tabel cu urmatoarele campuri Grupa, Nume_Prenume_Student, Nota Medie , is_good. Nota Medie sa fie cu precizie de 2 zecimale.

![image](https://user-images.githubusercontent.com/43127951/50055546-35552380-0159-11e9-9d00-418290518a91.png)


