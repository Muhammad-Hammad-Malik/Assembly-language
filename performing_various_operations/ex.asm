[org 0x0100]
main:
mov ax,0
mov bx,0
mov cx,0
mov dx,0
mov si,0
mov di,0
beginfirst:
jmp highlowfinder
beginsecond:
mov ax,0
mov bx,0
mov cx,0
mov dx,0
mov si,0
mov di,0
jmp unionfinder
beginthird:
mov ax,0
mov bx,0
mov cx,0
mov dx,0
mov si,0
mov di,0
jmp intersectionfinder
beginfourth:
mov ax,0
mov bx,0
mov cx,0
mov dx,0
mov si,0
mov di,0
jmp patternfinder



;IN the first question this code will initially take highest lowest in registers
;and then these registers will be compared to other indexes of the arrays and  
;(placing) functions will be called accordingly

;      QUESTION NUMBER 1 to find highest and lowest 

highlowfinder:
jmp starthigher
higherswap:
mov ax,[data+bx+2]
jmp l2
lowerswap:
mov cx,[data+bx+2]
jmp l4

higherswapneg:
mov ax,[data1+bx+2]
jmp l6

lowerswapneg:
mov ax,[data1+bx+2]
jmp l8
; CODE TO FIND HIGHEST UNSIGNED
starthigher:
mov si,8
mov bx,0
mov ax,[data+bx] ; highest stored in ax
l1:
cmp ax,[data+bx+2]
jb higherswap
l2:
add bx,2
sub si,2
jnz l1

; CODE TO FIND LOWEST UNSIGNED
startlower:
mov si,8
mov bx,0
mov cx,[data+bx] ; LOWEST stored in ax
l3:
cmp cx,[data+bx+2]
ja lowerswap
l4:
add bx,2
sub si,2
jnz l3


; CODE TO FIND HIGHEST SIGNED
starthigherneg:
mov si,8
mov bx,0
mov ax,[data1+bx] ; highest stored in ax
l5:
cmp ax,[data1+bx+2]
jg higherswapneg
l6:
add bx,2
sub si,2
jnz l5

; CODE TO FIND LOWEST SIGNED
startlowerneg:
mov si,8
mov bx,0
mov cx,[data1+bx] ; LOWEST stored in ax
l7:
cmp cx,[data1+bx+2]
jl lowerswapneg
l8:
add bx,2
sub si,2
jnz l7
jmp beginsecond



;In this question the code will place the first array as it is in a new array
;and then the second set or array will traverse and check the first array if 
;something is already present in 1st array then it will not be placed in new
;array 

; QUESTION NUMBER 2 TO FIND UNION OF SETS 
unionfinder:
mov cx,0
mov si,0
mov di,0
mov bx,0
storefirstarray:
mov ax,[data+si]
mov [newarray+si],ax
add si,2
mov ax,[data+si]
cmp ax,cx
jne storefirstarray
mov bx,0
externaloop:
mov dx,1
mov ax,[seq+bx]
internalloop:
cmp ax,[data+di]
je resumption
placement:
add di,2
cmp cx,[data+di]
jne internalloop
cmp cx,[data+di]
je endplay
resumption:
mov dx,0 ;   flag to check repition
endplay:
add bx,2
cmp dx,cx
je externaloop
mov [newarray+si],ax
add si,2
jmp beginthird


; In this next code we will compare two arrays to check if any of indexes are 
; same and if they are same then that value will be placed in a new array and 
; that array will present the intersection of  the sets 

; QUESTION NUMBER 3  TO FIND INTERSECTION
intersectionfinder:
mov bx,0
mov si,0
mov di,0
mov cx,0
outerloop:
mov ax,[seq+si]
add si,2
mov di,0
innerloop:
cmp ax,[data+di]
jne continuation
mov [newarray1+bx],ax ; newarray 1 will store the intersection values
add bx,2
jmp outerloop
continuation:
add di,2
cmp cx,[data+di]
jne innerloop
cmp cx,[seq+si]
jne outerloop
jmp beginfourth


; In this question we will assume we know the size of array and the size of 
; pattern we have to recognize then it will first check if first element of 
; sequence is same as any index of array and if same then a new fuction will be
; called and that function will check the next 2 indexes of array with next 2
; indexes of sequence if they are similar than CX that is the number of 
; will give you the index from which pattern is recognized

; Question number 4 to make a pattern recognizer 
patternfinder:
jmp start
checker:
mov bx,si
add bx,2
mov di,2
mov dx,2
l11:
mov ax,[data2+bx]
cmp ax,[seq1+di]
jne l10 
add di,2
add bx,2
sub dx,1
jnz l11
jmp end

start:
mov si,0  ; show current index of data array
mov di,0  ; show current index of sequence array
mov cx,0 ; control the loop 
l9:
mov bx,[data2+si]
cmp bx,[seq1+di]
je checker
l10:
mov di,0
add si,2
add cx,1
cmp cx,10
jne l9

end:
mov dx,cx ; DX gives us the index from where the pattern is recognized


mov ax,0x4C00
int 0x21


data: dw 3,1,5,7,0
swap: db 0
data1:dw -3,-2,-6,-9,-5
data2:dw 3,0,3,5,4,2,3,5,6,2,3,4
seq1:dw 3,5,6
seq: dw 3,5,6,0
newarray: dw 0,0,0,0,0,0,0,0
newarray1: dw 0,0,0,0,0,0,0,0