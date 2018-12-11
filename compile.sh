#!/bin/bash
yasm -f elf64 -a x86 -p nasm "$1.asm"
gcc -o "$1" -m64 -no-pie "$1.o"
exec "./$1"