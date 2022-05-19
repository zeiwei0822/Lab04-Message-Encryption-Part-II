;Encryption Program               (Encrypt.asm)

; This program demonstrates simple symmetric
; encryption using the XOR instruction.

INCLUDE Irvine32.inc
; KEY = 239           any value between 1-255
BUFMAX = 128        ; maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text: ",0
sKey  BYTE  "Enter the key: ",0
sEncrypt BYTE  "Cipher text: ",0
sDecrypt BYTE  "Decrypted:            ",0
buffer   BYTE   BUFMAX+1 DUP(0)
kBuffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?
keySize  DWORD  ?

.code
main PROC
    call    InputTheString      ; input the plain text
    call    InputTheKey      ; input the key
    call    DealKey
    call    TranslateBuffer ; encrypt the buffer
    mov edx,OFFSET sEncrypt ; display encrypted message
    call    DisplayMessage

    exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
    pushad
    mov edx,OFFSET sPrompt  ; display a prompt
    call    WriteString
    mov ecx,BUFMAX      ; maximum character count
    mov edx,OFFSET buffer   ; point to the buffer
    call    ReadString          ; input the string
    mov bufSize,eax         ; save the length
    call    Crlf
    popad
    ret
InputTheString ENDP

;-----------------------------------------------------
InputTheKey PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
    pushad
    mov edx,OFFSET sKey  ; display a prompt
    call    WriteString
    mov ecx,BUFMAX      ; maximum character count
    mov edx,OFFSET kBuffer   ; point to the buffer
    call    ReadString          ; input the string
    mov keySize,eax         ; save the length
    call    Crlf
    popad
    ret
InputTheKey ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
    pushad
    call    WriteString
    mov ecx,bufSize     ; loop counter
    mov esi,0           ; index 0 in buffer
L2:
    mov al,buffer[esi]   ; display the buffer
    call    WriteHex
    mov  al,' '
    call WriteChar
    inc esi
    loop L2

    popad
    ret
DisplayMessage ENDP

;-----------------------------------------------------
DealKey PROC
;
;-----------------------------------------------------
    pushad
    mov ecx,bufSize     ; loop counter
    mov esi,0           ; index 0 in buffer
    mov edi,keySize
    sub ecx,keySize
L1: 
    mov al,buffer[esi]
    mov kBuffer[edi],al
    inc esi             ; point to next byte
    loop    L1
    popad
    ret
DealKey ENDP


;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
    pushad
    mov ecx,bufSize     ; loop counter
    mov esi,0           ; index 0 in buffer
L1: 
    mov al,Kbuffer[esi]
    xor buffer[esi],al ; translate a byte
    inc esi             ; point to next byte
    loop    L1

    popad
    ret
TranslateBuffer ENDP
END main