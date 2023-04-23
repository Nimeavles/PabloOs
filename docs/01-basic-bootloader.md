# A bootloader? WTF

Have you ever wonder how your PC starts? Let me say, that after running the
**BIOS/UEFI** health checkups, it goes to the first bootable media, and looks for
an specific data sequence. This sequence needs to be located a the first position
of the media. This sector needs to be at least of **512 bytes**, and this bytes
might be compound of 510 bytes of 0, known as *padding*, and the 2 bytes remanding
are bytes **0xaa55**

It will look something like this:

```txt

e9 fd ff 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 29 more lines with sixteen zero-bytes each ]
00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa

```

It is basically all zeros, ending with the 16-bit value 0xaa55 
(beware of endianness, x86 is little-endian).
The first three bytes perform an infinite jump.

Sumarising, a bootloader is not more than some bytes with a special sequence which
the BIOS knows, and is the entry point of the OS.

## Run the code

 - You have the code available [🔗 here](../src/bootloader.asm)

You need to have installed nasm and qemu:
```bash

nasm -f bin src/bootloader.asm -o out/bootloader.bin

qemu out/bootloader.bin

```

#### Made with ❤  by Nimeavles
