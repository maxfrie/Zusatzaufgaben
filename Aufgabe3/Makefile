CC=gcc
CFLAGS=-m32 -Wall -g
ASM=nasm
ASMFLAGS=-f elf32 -O0 -g -F dwarf

.PHONY: clean

Prog: main.o parseStr.o
	$(CC) $(CFLAGS) -o Prog main.o parseStr.o

main.o: main.c
parseStr.o: parseStr.asm
	$(ASM) $(ASMFLAGS) -o parseStr.o parseStr.asm

clean:
	rm -f Prog main.o parseStr.o
