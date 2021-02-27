# -Decryption
computer architecture 


----------------------------Decryption_regfile---------------------------------------------


Pentru a intarzia semnalele done si error ne vom folosi de semnalele auxiliare a 
si b. Daca s-a incercat o scriere sau o citire atunci semnalul a o sa devina 1
(la fel ca semnalul done, dar acesta o sa fie interziat), daca nu s-a incercat 
o scriere sau o citire atunci a o sa fie 0.

Daca s-a incercat o citire la adresele care nu sunt valide atunci semnalul 
b(care o sa aiba aceeasi valoare ca semnalul error) o sa devina 1. Altfel, 
b o sa aiba valoarea 0.

In urmatoarea etapa verificam daca semnalul rst_n este 0 sau 1. Daca este 0 atunci
o sa resetam cu valorile date semnalele 'select', 'caesar', 'scytale', 'zigzag'.
Daca semnalul rst_n este 1 atunci vom verifica daca s-au facut citiri sau scrieri.
Daca semnalul write este 1 atunci vom verifica adresa la care se face 
scrierea si vom adauga la semnalul corespunzator. Daca semnalul read este 1 atunci
vom scrie in outputurile corespuzatoare, in functie de adresa addr.   



----------------------------Cifrul Caesar---------------------------------------------

Pentru decriptarea acestui cifru o sa ne uitam prima oara la semnalul rst_n. Daca este 0
atunci o sa resetam valorile data_o, busy si valid_o. Daca este 1 atunci vom avea iesirile
in functie de semnalul valid_i. Daca este 1 atunci pentru a obtine semnalul de iesire se 
scade din semnalul de intrare cheia. Daca valid_i este 0 atunci si urmatorul valid_o o sa fie
0. 
Semnalul busy este mereu 0, dupa cum  se zice si in pdf.


----------------------------Cifrul Scytale---------------------------------------------

Pentru decriptarea cifrului scytale o sa avem acelasi semnal rst_n in functie de care 
decriptam. Daca acest semnal este 0 o sa resetam toate semnalele care ne intereseaza.
Iesirea cifrului o sa depinde de semnalul busy. Se observa ca daca semnalul este 1 atunci 
putem scrie pe urmatorul semnal de clk. Acesta se face 0 atunci cand sunt scrise toate literele
de intrare( adica atunci cand indicele i este 0), deoarece in i stocam numarul de cifre din
intare. Daca in cifrele numarul intalnim valoarea 8'hFA atunci urmatoarea valoarea semnalului de 
busy devine 1.
Pentru a calcula iesirea o sa ne plimbam in vectorul nou creat dupa formula f*key_n +q, incrementand
valoarea lui f pentru fiecare valoare a lui q. Atunci cand f ajunge la valoarea lui key_M atunci acesta
se va reseta. 
Valoarea lui q se reseteaa cand se ajunge la valoarea key_N.


----------------------------Cifrul ZigZag---------------------------------------------

Pentru ZigZag am implementat doar cheia 2. Pentru aceasta am pastrat aceeasi structura de baza ca la 
cifrul scytale (ex semnalul busy devine 1 atunci cand in data_i se intalneste valoarea 8'hFA, 
valorile semnalelor se reseteaza atunci cand rst_n este 0, semnalul busy se face 0 cand se scriu toate
datele de iesire si i se face 0). Pentru decriptarea datelor de iesire trebuie sa verificam daca 
indicele pozitiei curente este par sau impar. aceasta verificare se face verificand ultimul 
bit din f. Daca aceasta este 0 inseamna ca f este par si in data_o o sa scriem din vectorul cu 
datele de intrare valoarea de pe pozitia f/2. Daca indicele f este impar o sa scriem valoarea de 
la jumatatea numerelor + un contor m(care se plimba de la la jumatatea numarului.).





----------------------------MUX ----------------------------------------------------


Pentru implementarea muxului o sa verificam fiecare semnal valid_i daca este 1. 
Daca intr-adevar este atunci o sa modificam iesirea data_o in data_iDaca toate semnalele valid_i 
sunt 0 atunci inseamna ca pe semnalul  urmator de clock atat data_o cat si valid_o o sa fie 0

----------------------------DEMUX ----------------------------------------------------


Pe master clock am verificat daca valid_i este 1. Daca este atunci in a vom 
adauga secventa care trebuie citita si de asemenea in functie de semnalul select vom 
schimba valorile lui valid_o.
pe semnalul clk_sys verificam daca semnalele de output valid sunt 1 si daca sunt atunci o 
sa scriem pe semnalul data_o corespunzator. Pentru a desparti semnalul de 32 de biti 
in 4 semnale de 8 biti ne vom folosi de indicele h pe care il decrementam cu 8 de fiecare
data cand scriem din el.  


 
