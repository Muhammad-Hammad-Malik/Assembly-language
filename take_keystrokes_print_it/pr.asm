[org 0x0100]

jmp start

string1: db 'HI !! you pressed a $'
string2: db 'HI !! you pressed b $'
string3: db 'HI !! you pressed something else $'

clearscreen:    
                push bp                 ;storing old base pointer
                mov bp,sp               ;moving sp into base pointer
                push es                 ;pushing locals into stack
                push di 
                push ax
                push cs
                mov ax,0xb800
                mov es, ax 
                mov ax,0x0720 
                mov di,0
                mov cx,2000             ;Pixels on screen
                cld
                rep stosw
                pop cx
                pop ax
                pop di
                pop es
                pop bp
                ret 
start:
                                call clearscreen
                                mov ah,0
                                int 0x16
                                cmp al,'a'
                                jne movenext
                                mov dx,string1
                                mov ah,9
                                int 0x21
                                jmp termination

movenext:
                                mov ah,0
                                int 0x16
                                cmp al,'b'
                                jne movenextest 
                                mov dx,string2
                                mov ah,9
                                int 0x21

movenextest:
                                mov dx,string3
                                mov ah,9
                                int 0x21

termination:
                                mov ax,0x4c00
                                int 0x21