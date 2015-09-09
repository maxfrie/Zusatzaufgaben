.PHONY: clean

Prog: main.o scalarP.o
	gcc -m32 -Wall -g -o Prog main.o scalarP.o

main.o:	main.c
scalarP.o: scalarP.asm
	nasm -f elf32 -O0 -g -F dwarf -o scalarP.o scalarP.asm

clean:
	rm -f Prog *.o
