[org 0x0100]
jmp start;
arr: dw 4,1,2,3,5,6,7,15,9,10
start:
mov ax,[arr+0]; highest number
mov cx,[arr+0]; lowest number
mov dx,0
mov bx,0

;first loop will find maximium 
l1:
cmp ax,word[arr+bx]
jnb l2
mov ax,word[arr+bx]
l2:
add bx,2
add dx,1
cmp dx,10
jne l1

mov dx,0
mov bx,0

l3:
cmp cx,word[arr+bx]
jb l4
mov cx,word[arr+bx]
l4:
add bx,2
add dx,1
cmp dx,10
jne l3


mov ax, 0x4c00
int 0x21 