## Tololoi Ilinca-Roxana ##
## 311CB ##
## Tema 3 PCLP2 ##

## Task 1: ##
## Functia check_parantheses: ##

    Functia este responsabila pentru verificarea corectitudinii parantezelor dintr-un sir de caractere.
    Pentru inceput, functia primeste adresa de inceput a sirului de caractere.
    Dupa, initializeaza indicele varfului stivei la 0 si incepe parcurgerea sirului de caractere.
    Pentru fiecare caracter, se verifica daca este o paranteza deschisa sau inchisa.
    Daca este o paranteza deschisa, o pune pe stiva si avanseaza la urmatorul caracter.
    Daca este o paranteza inchisa, verifica daca stiva este goala si daca paranteza curenta se potriveste cu ultima paranteza deschisa din stiva.
    La final, functia verifica daca stiva este goala pentru a asigura perechile de paranteze.
    In functie de rezultat, seteaza un byte care indica succesul sau eroarea si se returneaza rezultatul.

## Bonus: ##

## Functia map: ##

    Functia map aplica o functie specificata (f) pe fiecare element dintr-un array si stocheaza rezultatele intr-un alt array.
    Pentru inceput, se stabileste un nou cadru de stiva pentru a gestiona variabilele locale si se initializeaza spatiul necesar.
    Prin intermediul unui ciclu, functia itereaza prin fiecare element al array-ului sursa, aplicand functia f pe fiecare element si stocand rezultatele in array-ul destinatar.
    La fiecare pas, indexul i este incrementat pentru a trece la urmatorul element al array-ului sursa.
    Ciclul continua pana cand toate elementele din array-ul sursa au fost procesate.
    La final, se restaureaza stiva si se revine din functie.

## Functia reduce: ##

    In cadrul functiei reduce, este stabilit un nou cadru de stiva pentru a gestiona variabilele locale prin instructiunile push rbp, mov rbp, rsp, si sub rsp, 64. 
    Acest lucru asigura ca variabilele locale sunt alocate in mod corespunzator si ca stiva poate fi utilizata pentru a stoca aceste variabile.
    Urmatoarele instructiuni, cum ar fi mov QWORD PTR [rbp-24], rdi, mov QWORD PTR [rbp-32], rsi, etc., sunt utilizate pentru a stoca parametrii si alte variabile locale in cadrul stivei. 
    Parametrii functiei sunt preluati din registre si stocati in locatii de memorie specifice pe stiva pentru a putea fi accesate ulterior in cadrul functiei.
    Instructiunea mov QWORD PTR [rbp-8], rax este folosita pentru a initializa acumulatorul cu valoarea initiala specificata.
    Apelul efectiv al functiei de reducere are loc in cadrul ciclului for reprezentat de etichetele .loop_src_arr si .src_iter. 
    In fiecare iteratie a ciclului, se preia un element din array-ul sursa si se aplica functia specificata (f) pe perechea de elemente, actualizandu-se acumulatorul cu rezultatul. 
    Aceasta este realizata prin intermediul instructiunilor care preiau elementele array-ului si acumulatorul din memoria stivei si le folosesc ca argumente pentru apelul functiei specificate.
    Ciclul continua pana cand toate elementele din array-ul sursa au fost procesate, moment in care valoarea finala a acumulatorului este returnata ca rezultat al functiei reduce.
    Instructiunile de finalizare a functiei se ocupa de stocarea rezultatului in locatia specificata de destination_array, precum si de eliberarea spatiului alocat pentru variabilele locale prin instructiunile leave si ret.
