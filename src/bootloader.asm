loop:
    jmp loop

times 510-($-$$) db 0 ;fill with 510 zeros minus the size of the previus code

dw 0xaa55; Magic number
