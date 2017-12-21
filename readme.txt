.___________. _______ .___  ___.      ___          __ 
|           ||   ____||   \/   |     /   \        /_ |
`---|  |----`|  |__   |  \  /  |    /  ^  \        | |
    |  |     |   __|  |  |\/|  |   /  /_\  \       | |
    |  |     |  |____ |  |  |  |  /  _____  \      | |
    |__|     |_______||__|  |__| /__/     \__\     |_|

===Task 1===
---rgbHistogram()---

	In aceasta functie se returneaza o lista cu 3*count_bins elemente, rezultata
din concatenarea histogramelor imaginii in functie de culorile rosu(R), verde(G) si
albastru(B). 
	Pentru aceasta functie am initializat 3 liste (r_count, g_count, b_count) in
functie de cele 3 culori, avand fiecare count_bins elemente. Apoi am citit in variabila
ColorMatrix matricea tridimensionala de pixeli colorati. Din ea am extras matricile r,
g, b specifice celor 3 culori. Am setat lungimea intervalelor ca fiind d = 256 / count_bins,
dupa care insumam elementele din fiecare matrice r, g, b care se aflau in intervalul
corespunzator. Aceasta suma se punea iterativ pe fiecare pozitie din cele 3 liste (histograme).

===Task 2===
---hsvHistogram()---

	In aceasta functie se returneaza o lista cu 3*count_bins elemente, rezultata
din concatenarea histogramelor imaginii in functie de proprietatile Hue(H), Saturation(S)
si Value(V).
	Pentru aceasta functie am initializat 3 liste (r_count, g_count, b_count) in
functie de cele 3 proprietati, avand fiecare count_bins elemente. Apoi am citit in variabila
ColorMatrix matricea tridimensionala de pixeli colorati. Din ea am extras matricile r,
g, b specifice celor 3 culori. Am convertit elementele la double pentru a avea precizie
la numerele subunitare.
	Dupa ce elementele matricilor r, g, b au fost toate impartite la 255, am aplicat
algoritmul pentru transformare din RGB in HSV. Am initializat matricile h, s, v in functie
de proprietati, apoi am aflat Cmax si Cmin (ca matrici). Dupa calculul lui delta am creat
3 matrici r_max, g_max, b_max care pun un indicator (numarul 1) pe pozitia elementelor maxime
din matrice, iar in rest 0. Am facut transformarile din RGB necesare si am pus elementele
calculate in Cmax_r, Cmax_g, Cmax_b, in functie de formula folosita. Am selectat din aceste
matrici doar acele elemente care corespund cu conditia de calcul a formulei si le-am pus
pe aceleasi pozitii in h. Pentru elementele in care delta era 0 am creat o matrice delta_0
si am pus pe aceleasi pozitii in h tot valoarea 0. Apoi am normat h.
	Pentru s am creat o matrice Cmax_0 in care retin pozitiile un Cmax este 0 si calculez
s dupa formula. In pozitiile un Cmax e 0 pun 0, cu ajutorul lui Cmax_0. v este aceeasi matrice
cu Cmax.
	De aceasta data am luat lungimea intervalelor d = 1.01 / count_bins, deoarece h este
deja normat, iar s si v luau valori de la 0 si 100 -> deci 101 valori, dar s si v sunt si ele
normate; de aici a rezultat 1.01 = 101 / 100.
	Lista rezultata din functie am calculat-o ca la rgbHistogram().

===Task 3===

1) preprocess()

	Aceasta functie returneaza matricile X si t necesare functiei learn().
	Pentru aceasta funcite am creat caile catre directoarele cats/ si not_cats/,
apoi am extras numele imaginilor cu pisici si fara pisici folosind functia getImgNames().
Am retinut nr de poze cu pisici si fara pisici, la fel si nr total si am initializat X si t.
In functie de histograma folosita se creeaza o lista cu acea histograma si se adauga iterativ
in matricea X, in t se adauga iterativ 1, cand se lucreaza cu pozele cu pisici, si -1, cand
se lucreaza cu pozele fara pisici.
	La final se adauga o coloana de 1 in matricea X.

2) learn()

	Aceasta functie returneaza vectorul de parametri w.
	Pentru aceasta functie am gandit problema ca si un sistem de forma Ax = b,
unde A = X' * X, iar b = X' * t. Acest sistem am ales sa-l rezolv cu Factorizarea
LU si anume 'Factorizarea Doolittle' (A = LU). Apoi rezolv sistemul inferior 
triunghiular Ly = b (y = Ux), dupa care sistemul superior triunghiular (Ux = y).
	Functiile folosite:
	a) doolittle()
		--> transforma o matrice A in doua matrici L (lower) si U (upper),
		inferior triunghiulara, respectiv superior triunghiulara;
		--> am aplicat algoritmul standard.
	b) SIT()
		--> rezolva un sistem inferior triunghiular, returnand solutia.
	c) SST()
		--> rezolva un sistem inferior triunghiular, returnand solutia.

===Task 4===
---evaluate()---

	Aceasta functie returneaza procentajul pozelor clasificate corect.
	Pentru aceasta funcite am creat caile catre directoarele cats/ si not_cats/,
apoi am extras numele imaginilor cu pisici si fara pisici folosind functia getImgNames().
Am retinut nr de poze cu pisici si fara pisici, la fel si nr total si am initializat
cu 0 numarul de poze clasificate corect, nr_correct.
	In functie de histograma folosita se creeaza o lista cu acea histograma; acea
histograma o pun in x dupa care il transpun si adaug o linie cu un 1. Aflu y din
relatia y = w' * x si ii atribui valoarea 1 sau -1 in functie de semn. Verific daca
poza a fost clasificata corect si daca trece conditia se incrementeaza nr_correct.
	Stiind nr_correct si nr total de poze se poate calcula procentajul dorit.

!Observatii: 1) Acuratetea este mai mare in cazul HSV-ului decat in cazul RGB-ului.
	     2) Pentru valori mici ale lui count_bins acuratetea pentru ambele
	histograme incepe sa se apropie de aceeasi valoare.
	     3) Pentru valori mari ale lui count_bins acuratetea este mai mare
	pentru HSV decat pentru RGB.
