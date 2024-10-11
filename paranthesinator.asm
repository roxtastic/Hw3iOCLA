%include "../include/io.mac"
; programul este in 32 biti
[bits 32] 


section .data
    open_parantheses db "([{"
    close_parantheses db ")]}"
    ; 0 pentru succes, 1 pentru eroare
    result db 0  

section .bss
    ; stiva pentru paranteze, poate stoca pana la 256 paranteze
    stack resb 256  
    ; varful stivei (index)
    top resd 1  

section .text
global check_parantheses
check_parantheses:
    push ebp
    mov ebp, esp
    ; rezerv spatiu pentru index
    sub esp, 4  
    ; initializez varful stivei la 0
    mov dword [top], 0  
    ; adresa sirului de intrare
    mov esi, [ebp+8]  

next_char:
    ; citesc caracterul curent
    mov al, [esi]  
    test al, al
    ; daca am ajuns la sfarsitul sirului, ies din bucla
    je check_end  

    ; verific daca este o paranteza deschisa
    mov edi, open_parantheses
    ; 3 reprezinta lungimea listei de paranteze deschise/inchise
    mov ecx, 3 
    repe scasb
    ; daca nu este paranteza deschisa, verific daca este paranteza inchisa
    jne check_close  
    ; ajustez edi pentru a corecta indexul
    dec edi  

    ; pun paranteza deschisa in stiva
    mov ebx, [top]
    mov [stack + ebx], al
    ; se afla un singur element nou in stiva
    add dword [top], 1 
    jmp advance

check_close:
    ; verific daca este o paranteza inchisa
    mov edi, close_parantheses
    ; 3 reprezinta lungimea listei de paranteze deschise/inchise
    mov ecx, 3 
    repe scasb
    ; daca nu este paranteza inchisa, trec la urmatorul caracter
    jne advance  
    ; ajustez edi pentru a corecta indexul
    dec edi  

    ; verific daca stiva este goala
    mov ebx, [top]
    ; compar val lui ebx cu 0 ca sa aflu daca stiva e goala
    cmp ebx, 0 
    je error

    ; Scot din stiva paranteza si verific perechea
    sub dword [top], 1
    mov ebx, [top]
    mov bl, [stack + ebx]
    mov cl, al
    ; perechea asteptata
    mov al, [open_parantheses + (edi - close_parantheses)]  

    cmp al, bl
    jne error

advance:
    inc esi
    jmp next_char

check_end:
    ; verific daca stiva este goala
    cmp dword [top], 0
    jne error
    ; succes
    mov byte [result], 0  
    jmp done

error:
    ; eroare
    mov byte [result], 1  

done:
    mov eax, [result]

    leave
    ret