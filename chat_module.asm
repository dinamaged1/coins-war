;Mohamed Shams
;Chat Module
.model small
.stack
.data
player1name db "Player 1$"
player2name db "Player 2$"
player1msg db 30,?,30 DUP("$")
player2msg db ?
.code
main proc
        mov ax,@data
        mov ds,ax
        mov ax, 0A000h      ; to graphics screen
        mov es, ax      
        
        mov ah,0
        mov al,13h
        int 10h			;switch to 320x200 mode
        
        mov di, 28800    ; (row*320+col)
        mov Al,0fH
        mov cx,320    
        rep STOSB

        ;mov ah,2
        ; mov cx,0
        ; mov dx,0
        ; int 33h         ;set cursor position
        mov ah,9
        mov dx,offset player1name
        int 21h                 ;display the name of player 1


        mov ah,2
        ; mov cx,40
        mov dx,0C00h
        int 10h         ;set the cursor for player 2 name
        mov ah,9
        mov dx,offset player2name
        int 21h      
        

        ;set cursor position to write next to player 1
        mov ah,2
        mov dx,000Ah
        int 10h 

        AGAIN: mov ah,01
                int 16h
                jz AGAIN
                mov ah,0
                int 16h
                cmp al,0dH
                je SEND
                cmp al,1bH
                je EXIT
                jne DISP


        SEND:mov ah,2
        ; mov cx,40
                mov dx,0C00h
                int 10h 
                mov ah,9
                mov dx,offset player1msg+2
                int 21h
                mov ah,2
                mov dx,0C00h
                int 10h 
                jmp AGAIN

       DISP: mov  ah, 0Ah                    	;SERVICE TO CAPTURE STRING FROM KEYBOARD.
        mov  dx, offset player1msg
        int  21h
        ;DISPLAY STRING.
        mov  ah, 9                      	;SERVICE TO DISPLAY STRING.
        mov  dx, offset player1msg
        int  21h
        jmp AGAIN

EXIT: mov ah,4CH
        int 21h
    
main ENDP
end main
