section .text
global map
global map_funct
global reduce

; functia map aplica functia specificata pe fiecare element dintr-un array si
; stocheaza rezultatele intr-un alt array.

map:
    ; salvez adresa de baza a stivei si stabilesc un nou cadru de stiva
    push    rbp
    mov     rbp, rsp
    push    rbx
    ; dimensiunea totala a spatiului alocat pentru variabile locale
    sub     rsp, 56
    ; rdi = destination_array
    mov     [rbp-40], rdi  
    ; rsi = source_array 
    mov     [rbp-48], rsi 
    ; rdx = array_size  
    mov     [rbp-56], rdx 
    ; rcx = f (functia aplicata fiecarui element)      
    mov     [rbp-64], rcx       
    ; initializez contorul i la 0
    mov     qword [rbp-24], 0   
    jmp     .src_iter

.loop_src_arr:
    ; rax = i
    mov     rax, [rbp-24] 
    ; calculez offsetul pentru source_array      
    lea     rdx, [rax*8]    
    ; rax = source_array    
    mov     rax, [rbp-48]       
    ; rax = &source_array[i]
    add     rax, rdx   
    ; rax = source_array[i]         
    mov     rax, [rax]          
    ; rdx = i
    mov     rdx, [rbp-24]     
    ; calculez offsetul pentru destination_array  
    lea     rcx, [rdx*8]        
    ; rdx = destination_array
    mov     rdx, [rbp-40]    
    ; rbx = &destination_array[i]   
    lea     rbx, [rcx+rdx]      
    ; rdx = f
    mov     rdx, [rbp-64]     
    ; rdi = source_array[i]  
    mov     rdi, rax            
    ; apelez functia f(source_array[i])
    call    rdx                 
    ; destination_array[i] = rezultat
    mov     [rbx], rax          
    ; incrementez i
    add     qword [rbp-24], 1   
.src_iter:
    ; rax = i
    mov     rax, [rbp-24]       
    ; compar i cu array_size
    cmp     rax, [rbp-56]       
    ; sar la .loop_src_arr daca i < array_size
    jl      .loop_src_arr                 
    nop
    nop
    ; restaurez rbx
    mov     rbx, [rbp-8]        
    leave
    ret

; functie auxiliara pentru map, reprezentand functia aplicata fiecarui element

map_funct:
    push    rbp
    mov     rbp, rsp
    ; rdi = curr_elem (elementul curent)
    mov     [rbp-8], rdi        
    ; rax = curr_elem (elementul curent)
    mov     rax, [rbp-8]        
    ; rax = curr_elem * 2
    add     rax, rax            
    pop     rbp
    ret

; functia reduce aplica o functie specificata asupra elementelor unui array si
; returneaza un singur rezultat.

reduce:
    push    rbp
    mov     rbp, rsp
    ; lucrez in 64-bit + aloca spatiu pentru variabile locale
    sub     rsp, 64
    ; destination_array
    mov     QWORD [rbp-24], rdi       
    ; source_array
    mov     QWORD [rbp-32], rsi       
    ; array_size
    mov     QWORD [rbp-40], rdx      
    ; accumulator_initial_value 
    mov     QWORD [rbp-48], rcx       
    ; f (source_array)
    mov     QWORD [rbp-56], r8       
    ; initializez accumulatorul cu valoarea initiala a acumulatorului
    mov     rax, QWORD [rbp-48] 
    ; 8 octeti = 64-bit     
    mov     QWORD [rbp-8], rax
    ; initializez contorul de bucla
    mov     QWORD [rbp-16], 0         
.loop_src_arr:
    ; mut contorul de bucla in rax
    mov     rax, QWORD [rbp-16]      
    ; calculez offsetul: contor_bucla * sizeof(int64_t)
    lea     rdx, [rax*8]             
    ; mut source_array in rax
    mov     rax, QWORD [rbp-32]      
    ; calculez adresa elementului curent: source_array + offset
    add     rax, rdx                 
    ; mut elementul curent in rdx
    mov     rdx, QWORD [rax]         
    ; mut accumulatorul in rax
    mov     rax, QWORD [rbp-8]       
    ; mut f in rcx
    mov     rcx, QWORD [rbp-56]      
    ; mut elementul curent in rsi (al doilea argument al lui f)
    mov     rsi, rdx                 
    ; mut accumulatorul in rdi (primul argument al lui f)
    mov     rdi, rax                 
    ; apelez f(acc, src[i]) si stocam rezultatul in rax
    call    rcx                      
    ; actualizez accumulatorul cu rezultatul
    mov     QWORD [rbp-8], rax       
    ; incrementez contorul de bucla
    add     QWORD [rbp-16], 1      
    ; mut contorul de bucla in rax  
    mov     rax, QWORD [rbp-16]      
    ; compar contorul de bucla cu dimensiunea array-ului
    cmp     rax, QWORD [rbp-40]  
     ; sar la .loop_src_arr daca contorul < dimensiune_array    
    jl      .loop_src_arr                   
    ; mut destination_array in rax
    mov     rax, QWORD [rbp-24]      
    ; mut accumulatorul in rdx
    mov     rdx, QWORD [rbp-8]     
    ; stochez valoarea acumulatorului in destination_array 
    mov     QWORD [rax], rdx         
    ; mut valoarea acumulatorului in rax
    mov     rax, QWORD [rbp-8]       
    leave
    ret