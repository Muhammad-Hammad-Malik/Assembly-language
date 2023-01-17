[org 0x0100]
jmp start

goose:
        push bp
        mov bp,sp
        push ax
        mov ax,-4
        mov [bp+4],ax
        pop ax
        pop bp
        ret

sky:    
        push bp
        mov bp,sp
        push ax
        mov ax,[bp+6]
        sub ax,[bp+4]
        mov [bp+8],ax
        pop ax
        pop bp 
        ret 4


sheep:
        push bp
        mov bp,sp
        push ax
        mov ax,[bp+4]
        cmp ax,0
        jl continue1
        cmp ax,0
        jge continue2
        continue1:
        mov word[bp+6],1
        jmp exit
        continue2:
        mov word[bp+6],0
        jmp exit
        exit:
        pop ax
        pop bp
        ret 2


duck:
        push bp
        mov bp,sp
        push ax

        push cx
        push dx
        push dx
        mov ax,[bp+4]
        push ax
        call sheep
        pop dx

        cmp dx,1
        je l1
        cmp dx,0
        je l2
l1:
        mov ax,[bp+4]
        mov cl,-1
        mul cl
        mov [bp+6],ax
        jmp exit2
l2:
        mov ax,[bp+4]
        mov cl,1
        mul cl
        mov [bp+6],ax
        jmp exit2

exit2:
        pop dx
        pop cx
        pop ax
        pop bp
        ret 2

start:
        push dx
        call goose
        pop dx

        push dx
        mov ax,15
        push ax
        mov ax,10
        push ax
        call sky
        pop dx

        push dx
        mov ax,-3
        push ax
        call sheep
        pop dx

        push dx
        mov ax,4
        push ax
        call duck
        pop dx

mov ax, 0x4c00 ; terminate program
int 0x21