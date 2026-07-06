📌 Despre Proiect
Acest proiect vizează explorarea și vizualizarea datelor privind pandemia COVID-19. Obiectivul principal a fost transformarea unor date brute, adesea inconsistente, într-un dashboard interactiv care să ofere insight-uri clare despre rata de infectare și impactul mortalității la nivel global.

🛠 Instrumente și Tehnologii
SQL (SQLite/DataGrip): Utilizat pentru curățarea datelor, gestionarea tipurilor de date și crearea de View-uri optimizate.

Tableau: Utilizat pentru vizualizarea datelor, crearea dashboard-urilor interactive și analiza trendurilor temporale.


🔍 Provocări Tehnice Rezolvate
Curățarea Datelor: Datele sursă conțineau coloane numerice importate ca TEXT, ceea ce împiedica efectuarea calculelor în Tableau. Am rezolvat această problemă folosind funcția CAST(coloană AS REAL) în SQL.

Optimizarea Performanței: Am creat View-uri în SQL pentru a calcula indicatori complecși (precum Rolling Sum pentru vaccinări), permițând Tableau-ului să se concentreze doar pe afișare, nu pe calcule intense.

Vizualizare: Am structurat dashboard-ul pentru a include:

Indicatori globali (Total cazuri/decese).

Analiză geografică (Harta infecțiilor).

Evoluție temporală (Line chart pentru tendințe).