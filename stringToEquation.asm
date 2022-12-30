include 'emu8086.inc'

org 100h

; Input string
    printn "Enter a paragraph: "
    
    lea di, para
    mov dx, paraLen
    call get_string
    
    call newline

; Process the string to get anwser

    ; Extracting operator
    mov dx, paraLen
    sub dx, 2
    
    mov bx, 0
loopOp:
    lea si, para
    add si, bx
    lea di, word
    
    mov cx, 8
    rep movsb
    
    ; Check for add
    lea si, word
    lea di, addd
    
    mov cx, 3
    rep cmpsb
    jnz Lmul
    
    ; assign operator to variable
    lea si, op
    mov b.[si], '+'
    mov bx, dx
    dec bx

Lmul:
    ; Check for  multiply
    lea si, word
    lea di, multiply
    
    mov cx, 8
    rep cmpsb
    jnz Ldiv
    
    ; assign operator to variable
    lea si, op
    mov b.[si], '*'
    mov bx, dx
    dec bx

Ldiv:
    ; Check for divide
    lea si, word
    lea di, divide
    
    mov cx, 6
    rep cmpsb
    jnz opHere
    
    ; assign operator to variable
    lea si, op
    mov b.[si], '/'
    mov bx, dx
    dec bx
    
opHere:    
    inc bx
    cmp dx, bx
    jnz loopOp
    
    ; Extracting Numbers
    mov dx, paraLen
    sub dx, 2
    
    mov bx, 0
loopNum:
    lea si, para
    add si, bx
    lea di, word
    
    mov cx, 5
    rep movsb
    
    ; Check for one
    lea si, word
    lea di, one
    
    mov cx, 3
    rep cmpsb
    jnz Ltwo
    
    ; add 1 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '1'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 1
    call ansproc 
    
    add ind, 2
    
Ltwo:
    ; Check for two
    lea si, word
    lea di, two
    
    mov cx, 3
    rep cmpsb
    jnz Lthree
    
    ; add 2 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '2'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 2
    call ansproc
    
    add ind, 2
    
Lthree:
    ; Check for three
    lea si, word
    lea di, three
    
    mov cx, 5
    rep cmpsb
    jnz Lfour
    
    ; add 3 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '3'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 3
    call ansproc
    
    add ind, 2

Lfour:
    ; Check for four
    lea si, word
    lea di, four
    
    mov cx, 4
    rep cmpsb
    jnz Lfive
    
    ; add 4 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '4'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 4
    call ansproc
    
    add ind, 2

Lfive:
    ; Check for five
    lea si, word
    lea di, five
    
    mov cx, 4
    rep cmpsb
    jnz Lsix
    
    ; add 5 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '5'
    inc si
    mov al, op
    mov b.[si], al

    mov cx, 5
    call ansproc
    
    add ind, 2

Lsix:
    ; Check for six
    lea si, word
    lea di, six
    
    mov cx, 3
    rep cmpsb
    jnz Lseven
    
    ; add 6 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '6'
    inc si
    mov al, op
    mov b.[si], al

    mov cx, 6 
    call ansproc
    
    add ind, 2

Lseven:
    ; Check for seven
    lea si, word
    lea di, seven
    
    mov cx, 5
    rep cmpsb
    jnz Leight
    
    ; add 7 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '7'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 7 
    call ansproc
    
    add ind, 2

Leight:
    ; Check for eight
    lea si, word
    lea di, eight
    
    mov cx, 5
    rep cmpsb
    jnz Lnine
    
    ; add 8 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '8'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 8
    call ansproc
    
    add ind, 2

Lnine:
    ; Check for nine
    lea si, word
    lea di, nine
    
    mov cx, 4
    rep cmpsb
    jnz Lzero
    
    ; add 9 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '9'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 9
    call ansproc
    
    add ind, 2

Lzero:
    ; Check for zero
    lea si, word
    lea di, zero
    
    mov cx, 4
    rep cmpsb
    jnz Leos:
    
    ; add 0 to answer
    lea si, answer
    add si, ind
    
    mov b.[si], '0'
    inc si
    mov al, op
    mov b.[si], al
    
    mov cx, 0
    call ansproc
    
    add ind, 2

Leos:
    ;check for end of string
    lea si, word
    lea di, eos
    
    mov cx, 5
    rep cmpsb
    jnz here:
    
    mov bx, dx
    dec bx

here:
    inc bx
    cmp dx, bx
    jnz loopNum

    ; Here last operator changes to '='
    dec ind
    lea si, answer
    add si, ind
    
    mov b.[si], '='

; Output answer
printArea:
    call clear_screen
    
    gotoxy x, y
    lea si, answer
    call print_string 
    mov ax, ans
    call print_num_uns
    
    mov ah, 00h
    int 16h

downDef:
    ; check for down key press
    cmp ah, 50h
    jnz upDef
    
    lea bx, y
    inc b.[bx]
    
    jmp printArea

upDef:    
    ; check for up key press
    cmp ah, 48h
    jnz rightDef
    
    lea bx, y
    dec b.[bx]
    
    jmp printArea

rightDef:    
    ; check for right key press
    cmp ah, 4dh
    jnz leftDef
    
    lea bx, x
    inc b.[bx]
    
    jmp printArea

leftDef:    
    ; check for left key press
    cmp ah, 4bh
    jnz ex
    
    lea bx, x
    dec b.[bx]
    
    jmp printArea

ex:

ret

; Variables
ind dw 0

; Input string
para db 100 dup('$')
paraLen equ $-para

; extra strings
word db "$$$$$", 0
wordLen equ $-word

op db '$', 0
   
; Substrings
zero db "zero", 0
one db "one", 0
two db "two", 0
three db "three", 0
four db "four", 0
five db "five", 0
six db "six", 0
seven db "seven", 0
eight db "eight", 0
nine db "nine", 0
eos db "$$$$$", 0

; Operators
addd db "add", 0
multiply db "multiply", 0
divide db "divide", 0 
         
; Output answer
answer db 100 dup(0)
ans dw 0

; Variables for positions
; x for left and right
; y for up and down
; screen is 80 x 25 ranges : (0 - 79) x (0 - 24)
x db 40
y db 12

; Extra library
define_clear_screen
define_get_string
define_print_string
define_print_num_uns

; Procedures
newline proc
    putc 0dh
    putc 10
ret
newline endp

ansproc proc
    cmp op, '+'
    jnz nextmul
    add ans, cx
nextmul:
    cmp op, '*'
    jnz nextdiv
    mul cx
    mov ans, ax
nextdiv:
    cmp op, '/'
    jnz nextskip
    div cx
    xor ah, ah
    mov ans, ax
nextskip:
ret
ansproc endp

end