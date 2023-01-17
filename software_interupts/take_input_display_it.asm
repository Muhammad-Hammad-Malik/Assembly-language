[org 0x0100]
jmp start
maxlength: dw 80 ; maximum length of input
msg1: db 'Enter your name? .$'
msg2: db 'What is your roll no? .$'
msg3: db 'What is your course? .$'
msg4: db 'What is your section? .$'
naming: times 81 db 0 ;initializes array with 0s
roll:  times 81 db 0 
course: times 81 db 0 ; space for input string
sec:  times 81 db 0

clrscr: 
push es
 push ax
 push cx
 push di
 mov ax, 0xb800
 mov es, ax ; 
 xor di, di ;
 mov ax, 0x0720 ; 
 mov cx, 2000 ; 
 cld ;
 rep stosw ; 
 pop di
 pop cx
 pop ax
 pop es
 ret

start:
mov dx,msg1
mov ah,9 ; service-9 write string
int 0x21
mov cx,[maxlength]
mov si,naming

nextchar:
mov ah,1 ; service-1-read-char
int 0x21
cmp al,13
je continue1
mov [si],al
add si,1
loop nextchar

continue1:
mov dx,msg2
mov ah,9 ; service-9 write string
int 0x21
mov cx,[maxlength]
mov si,roll

nextcharagain:
mov ah,1 ; service-1-read-char
int 0x21
cmp al,13
je continue2
mov [si],al
add si,1
loop nextcharagain

continue2:
mov dx,msg3
mov ah,9 ; service-9 write string
int 0x21
mov cx,[maxlength]
mov si,course

nextchar3:
mov ah,1 ; service-1-read-char
int 0x21
cmp al,13
je continue3
mov [si],al
add si,1
loop nextchar3

continue3:
mov dx,msg4
mov ah,9 ; service-9 write string
int 0x21
mov cx,[maxlength]
mov si,sec

nextchar4:
mov ah,1 ; service-1-read-char
int 0x21
cmp al,13
je print
mov [si],al
add si,1
loop nextchar4

print: 
                call clrscr
                mov ah, 0x13;   service 13 - print string
                mov al, 1;              subservice 01 – update cursor 
                mov bh, 0;              output on page 0
                
                mov bl, 11000011B       ; normal attrib
                mov cx, 30                      ; length of string
                mov dx, 0x0103          ; row 1 column 3
                push ds
                pop es                          ; es=ds segment of string
                mov bp, naming  ; bp = offset of string
                
                INT 0x10                        ; call BIOS video service
        mov ah, 0x13            ; service 13 - print string
                
                mov al, 1                       ; subservice 01 – update cursor 
                mov bh, 0                       ; output on page 0
                
                mov bl, 11000011B       ; normal attrib
                mov cx, 11                      ; length of string
                mov dx, 0x0203          ; row 2 column 3
                push ds
                pop es                          ; es=ds segment of string
                 mov bp,roll    ; bp = offset of string
                
                INT 0x10                        ; call BIOS video service

                ;;;;;;
                mov ah, 0x13            ; service 13 - print string
                
                mov al, 1                       ; subservice 01 – update cursor 
                mov bh, 0                       ; output on page 0
                
                mov bl, 11000011B       ; normal attrib
                mov cx, 30                      ; length of string
                mov dx, 0x0303          ; row 3 column 3
                push ds
                pop es                          ; es=ds segment of string
                 mov bp,course  ; bp = offset of string
                
                INT 0x10                        ; call BIOS video service

                mov ah, 0x13            ; service 13 - print string
                
                mov al, 1                       ; subservice 01 – update cursor 
                mov bh, 0                       ; output on page 0
                
                mov bl, 11000011B       ; normal attrib
                mov cx, 11                      ; length of string
                mov dx, 0x0403          ; row 4 column 3
                push ds
                pop es                          ; es=ds segment of string
                 mov bp, sec    ; bp = offset of string
                
                INT 0x10                        ; call BIOS video service

exit: 
mov ax, 0x4c00 ; terminate program
int 0x21