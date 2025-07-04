section .data
    arp_msg db "ARP intercettato", 10
    arp_len equ $ - arp_msg

    mac_src_msg db "MAC sorgente: ", 0
    mac_dst_msg db "MAC destinazione: ", 0

section .bss
    buffer resb 65535      ; spazio per pacchetti
    hexbuf resb 18         ; MAC in ASCII + separatori + newline

section .text
    global _start

_start:
    ; socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))
    mov eax, 102
    mov ebx, 1
    push word 0x0300      ; ETH_P_ALL (0x0003) in big endian
    push byte 3           ; SOCK_RAW
    push byte 17          ; AF_PACKET
    mov ecx, esp
    int 0x80
    mov esi, eax          ; salva socket fd

.loop:
    ; recvfrom(esi, buffer, 65535, 0, NULL, NULL)
    mov eax, 102
    mov ebx, 10
    push 0
    push 0
    push 0
    push buffer
    push esi
    mov ecx, esp
    int 0x80

    ; controlla Ethertype (offset 12–13) == 0x0806 (ARP)
    movzx eax, byte [buffer + 12]
    shl eax, 8
    add al, byte [buffer + 13]
    cmp ax, 0x0806
    jne .loop

    ; stampa "ARP intercettato"
    mov eax, 4
    mov ebx, 1
    mov ecx, arp_msg
    mov edx, arp_len
    int 0x80

    ; stampa MAC destinazione
    mov eax, 4
    mov ebx, 1
    mov ecx, mac_dst_msg
    mov edx, 17
    int 0x80
    mov edi, buffer
    call print_mac

    ; stampa MAC sorgente
    mov eax, 4
    mov ebx, 1
    mov ecx, mac_src_msg
    mov edx, 16
    int 0x80
    mov edi, buffer + 6
    call print_mac

    jmp .loop

;----------------------------------
; print_mac: stampa 6 byte da [EDI] in formato MAC
;----------------------------------
print_mac:
    pusha
    mov esi, hexbuf
    mov ecx, 6
.next:
    mov al, byte [edi]
    call byte_to_hex
    mov byte [esi+2], ':'
    add esi, 3
    inc edi
    loop .next
    sub esi, 1
    mov byte [esi], 10   ; newline
    mov eax, 4
    mov ebx, 1
    mov ecx, hexbuf
    mov edx, 18
    int 0x80
    popa
    ret

;----------------------------------
; byte_to_hex: AL in -> [ESI] = 2 ASCII hex
;----------------------------------
byte_to_hex:
    push ax
    mov ah, al
    shr al, 4
    call nybble_to_char
    mov [esi], al
    mov al, ah
    and al, 0x0F
    call nybble_to_char
    mov [esi+1], al
    pop ax
    ret

nybble_to_char:
    cmp al, 10
    jl .digit
    add al, 'A' - 10
    ret
.digit:
    add al, '0'
    ret
