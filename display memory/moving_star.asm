[org 0x0100]

jmp start
delay:      
		push cx
        mov cx, 0xFFFF
l1:                     
		loop l1
        mov cx, 0xFFFF
l2:
		loop l2
		mov cx,0xFFFF
l3:
		loop l3
		mov cx,0xFFFF
l4: 
		loop l4
		pop cx
		ret
start:
		  mov ax, 0xb800                                                
		  mov es, ax                                                         
		  mov di, 0                                                           
nextchar:
		  mov word [es:di], 0x0720                   
		  add di, 2                                                            
		  cmp di, 4000                                                     
		  jne nextchar                     
		  mov ax, 0xb800                                                
		  mov es, ax
		  mov di,160
		  mov cl,79    

firstrows:
           mov word [es:di], 0x0720                   
           add di, 2                           
           mov word[es:di],0x042A
           dec cl
           call delay
           cmp cl,0
           jnz firstrows
           mov cl,23
firstcol:
           mov word [es:di], 0x0720                   
           add di, 160
           mov word[es:di],0x042A
           call delay
           dec cl
           cmp cl,0
           jnz firstcol
           mov cl,79
secondrow:
           mov word [es:di], 0x0720                   
           sub di, 2                            
           mov word[es:di],0x042A
           call delay
           dec cl
           cmp cl,0
           jnz secondrow
           mov cl,23

secondcol:
		   mov word [es:di], 0x0720                   
		   sub di, 160                       
		   mov word[es:di],0x042A
		   call delay
		   dec cl
		   cmp cl,0
		   jnz secondcol

mov ax,0x4c00
int 0x21