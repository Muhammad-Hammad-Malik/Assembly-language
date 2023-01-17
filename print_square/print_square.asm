[org 0x0100]
jmp start;

leftcorner: dw 0
rightcorner: dw 80
bottomleft: dw 960
bottomright: dw 1040

clearscreen:
push es
push ax
push cx
push di
mov ax,0xb800
mov es,ax
mov di,0
mov ax,0x0720
mov cx,2000
cld
rep stosw

pop di
pop cx
pop ax
pop es
ret

printrectangle:
push bp
mov bp,sp
push es
push ax
push bx
push cx
push dx
push di
push si 
mov bx,[bp+8]
mov cx,[bp+6]
mov dx,[bp+4]
mov ax,0xb800
mov es,ax
mov ax,[bp+10]
mov di,ax
mov si,ax
mov ax,0x072B
l1: 
mov word[es:di],ax
add di,2
cmp di,bx
jne l1

mov ax,0x072D
l2: 
mov word[es:di],ax
add di,160
cmp di,dx
jne l2

mov ax,0x072B
l3: 
mov word[es:di],ax
sub di,2
cmp di,cx
jne l3

mov ax,0x0721
l4: 
mov word[es:di],ax
sub di,160
cmp di,si
jne l4


pop si
pop di
pop dx
pop cx
pop bx
pop ax
pop es
ret



start:
call clearscreen; to make it blank
mov ax,word[leftcorner];
push ax
mov ax,word[rightcorner];
push ax
mov ax,word[bottomleft];
push ax
mov ax,word[bottomright];
push ax
call printrectangle
mov ax, 0x4c00
int 0x21 