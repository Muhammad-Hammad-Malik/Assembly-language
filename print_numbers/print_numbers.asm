[org 0x0100]
jmp start
roll: dw 0x5388
mask1: dw 0x000F
mask2: dw 0x00F0
mask3: dw 0x0F00
mask4: dw 0xF000
num1: dw 0
num2: dw 0
num3: dw 0
num4: dw 0
printloc: dw 560
clearscreen:    
                push bp                
                mov bp,sp              
                push es              
                push di 
                push ax
                push cx
                mov ax,0xb800        
                mov es, ax 
                mov ax,0x0720 
                mov di,0
                mov cx,2000             
                cld
                rep stosw
                pop cx
                pop ax
                pop di
                pop es
                pop bp
                ret 

printnum:
                        
                        push bp
                        mov bp,sp
                        push es
                        push ax
                        push bx
                        push cx
                        push dx
                        push si

                        mov ax,0xb800
                        mov es,ax
                        mov ax,[bp+4]
                        add ax,30h
                        mov ah,0x07
                        mov si,word[cs:printloc]
                        mov [es:si],ax
                        add word[cs:printloc],2
                        pop di
                        pop dx
                        pop cx
                        pop bx
                        pop ax
                        pop es
                        pop bp
                        ret 2


start:
mov ax,0xb800
call clearscreen

mov ax,word[roll]
and ax,word[mask1]
mov word[num1],ax

mov ax,word[roll]
and ax,word[mask2]
shr ax,4
mov word[num2],ax

mov ax,word[roll]
and ax,word[mask3]
shr ax,8
mov word[num3],ax

mov ax,word[roll]
and ax,word[mask4]
shr ax,12
mov word[num4],ax

mov ax,word[num4]
push ax
call printnum

mov ax,word[num3]
push ax
call printnum

mov ax,word[num2]
push ax
call printnum

mov ax,word[num1]
push ax
call printnum

mov ax, 0x4c00 ; terminate program
int 0x21