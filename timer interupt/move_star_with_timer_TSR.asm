[org 0x0100]
jmp start
position: dw -2
time: dw 0
buffer: dw 0
flag: dw 0

timer:      pusha
            mov cx,word[cs:time]
            inc word[cs:time]
            cmp cx,18
            jne termination
            mov word[cs:time],0
            

            mov ax, 0xb800
            mov es, ax
            mov si, word[cs:position]
            cmp si, 0
            jnge beforeflag
        
            mov bx, word[cs:buffer]
            mov word[es:si],bx
            mov di, si 
            cmp word[flag], 1
            je afterflag
        beforeflag:     
                cmp di,156
                jle row1
                cmp di,3996
                jle col1
                mov byte[flag], 1
                jmp afterflag
        row1:   add di, 2
                jmp skip
        col1:   add di,160
                jmp skip

        afterflag: 
                 cmp di,3840
                 jg row2
                 cmp di,0
                 jg col2
                 mov word[flag],0
        row2:   sub di, 2
                jmp skip
        col2:   sub di,160
                jmp skip                
                
                
        skip:   mov bx, word[es:di]
                mov word[cs:buffer],bx
                mov word[es:di],0x072A
                mov word[cs:position],di
        termination:        
            mov al, 0x20
            out 0x20, al ; end of interrupt
            popa 
            iret ; return from interrupt

start:      xor ax, ax
            mov es, ax ; point es to IVT base

            cli ; disable interrupts
            mov word [es:8*4], timer; store offset at n*4
            mov [es:8*4+2], cs ; store segment at n*4+2
            sti ; enable interrupts

            mov dx, start ; end of resident portion
            add dx, 15 ; round up to next para
            mov cl, 4
            shr dx, cl ; number of paras

            mov ax, 0x3100 ; terminate and stay resident
            int 0x21 