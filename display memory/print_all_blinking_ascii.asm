; clear the screen 
[org 0x0100] 

 mov ax, 0xb800 
 mov es, ax  
 mov di, 0
 mov ah,0x8F
 mov al,0
 mov bx,0xFF
nextchar: mov word [es:di],ax  
 add di, 2 
 add al,1
 cmp ax,bx
 jne continuation
 mov al,0 
 continuation:
 cmp di,4000
 jne nextchar 
 mov ax, 0x4c00 
 int 0x21