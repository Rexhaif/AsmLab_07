list:
	nasm -l main.lst main.asm
viewList:
	cat main.lst
build:
	nasm -f elf64 -o main.o main.asm
	ld -o main main.o
run:
	./main
debug:
	nasm -f elf64 -o main.o -g main.asm
	ld -o main-d main.o
gdb:
	gdb main-d
