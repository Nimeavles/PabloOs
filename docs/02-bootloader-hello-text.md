# Printing some text when booting

Now we know what a bootloader is and how does it work, we are going to add some 
text to it. But just booting is not useful, isn't it? So that bootloader we did
is just the barebones of what we are going to code on the nexts chapters.

Let me remind you that you should know a bit about *cpu interrupts* and 
*x86-64 assembly registers*, as we are going to work with 
`lower and hight register's bytes`. Here I let you some documentacion about:

- [🔗 Interrupts](https://www.techtarget.com/whatis/definition/interrupt)
- [🔗 x86-64 registers](https://resources.infosecinstitute.com/topic/registers)

Now we know what we are suposed to do, lets start coding.

- **0x0e** sets the terminal mode
- **0x10** is a general interrupt for video services

We are going to be setting our chars on registers of *16 bits/2 bytes*, as each
char takes just 1 byte. We will be working with `ax` and our characters will be 
on `al`, the lowest part of the register and the terminal mode, on the highest
part `ah`. At this point we are going to set the tty mode just once, as we are
the unique process, but on the real world, the register could be overwritted by 
another process.

The code will look like this:

```asm

mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10 ; 'l' is still on al, remember?
mov al, 'o'
int 0x10

jmp $ ; jump to current address = infinite loop

; padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55

```

## Run the code

You need to have installed nasm and qemu:
```bash

nasm -f bin src/bootloader.asm -o out/bootloader.bin

qemu out/bootloader.bin

```

#### Made with ❤  by Nimeavles

