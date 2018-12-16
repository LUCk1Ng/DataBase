1.Creati o baza de date plasata fizic m mapa MyDocuments\Data, fixand o crestere a fisierului primar a bazei de 16MB cu limita de crestere de 128 MB si a log-ului de 64 MB cu limita de crestere de 1024 MB. Pentru fisierele secundare sa se defineasca un Filegroup nou implicit, setand cresterea fisierelor secundare de 64 MB cu limita de 1024 MB. 

![image](https://user-images.githubusercontent.com/43127951/50056322-38eda800-0163-11e9-9713-87cee9854f9c.png)

2.Creati o baza de date, unde fisierul log sa fie fizic plasat in mapa MyDocuments\Log, numele fisierului log in mediul sistemului de operare trebuie sa se deosebeasca de cel logic definit in schema fizica. Este important ca baza de date creata sa fie compatibila cu sistemul MS SQL Server 2017 si ea sa fie accesibila numai unui singur utilizator intr-un moment de timp. 

![image](https://user-images.githubusercontent.com/43127951/50056329-5458b300-0163-11e9-8940-3fcb0a9d6168.png)

3.Creati planul de intretinere a bazei de date, construita in sarcina 1. Spatiul neutilizat de fisierele bazei de date trebuie indepartat atunci cand el atinge marimea 2000Mb. Spatiul eliberat trebuie sa fie returnat sistemului de operare. Aceasta operatiune trebuie sa ruleze in fiecare vineri, la ora 00:00. Raportul executarii planului de intretinere trebuie salvat in dosarul MyDocuments\SQL_event_logs. lnitializati executarea planului. Dupa executare, verificati rezultatele m fisierul log. 

![image](https://user-images.githubusercontent.com/43127951/50056346-8ff37d00-0163-11e9-9750-87cc6f53a931.png)

4.Creati planul de intretinere a bazei de date, construite in exercitiul 2. Numele planului va fi: ,,Reconstruire index". In cadrul acestui plan, sistemul trebuie sa realizeze reconstruirea indecsilor numai asupra tabelelor de baza (exclusiv viziunilor) din toate schemele care exista in baza de date in cauza. Spatiul liber pe pagina trebuie sa fie 10%. Sortarea indecsilor trebuie sa se realizeze in tempdb. Dupa reconstruire, trebuie sa urmeze colectarea statisticilor complete despre indecsii reconstruiti. Al treilea pas al planului trebuie sa constituie sarcina de stergere a istoriei despre operatiile de Backup-Restore ce au avut loc pe SQL Server. Trebuie sters istoricul care este mai vechi de 6 saptamani. Acest plan trebuie sa fie executat in fiecare prima duminica a lunii. Creati dosarul MyDocuments\SQL_reports. Raportul de executare a planului trebuie sa fie adaugat in acest fisier. Procesul de mentenanta - sa fie logat in mod extended. lnitializati executarea planului. Dupa executare, verificati rezultatele m fisierul log generat. 

![image](https://user-images.githubusercontent.com/43127951/50056349-9aae1200-0163-11e9-9d67-cd45e2df89a7.png)

