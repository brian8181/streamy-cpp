
# // License:    GPL
# // Author:     Brian K Preston
# // File Name:  lex & yacc/Makefile
# // Build Date: Mon Nov 27 09:33:36 AM CST 2023
# // Version:    0.0.1

DIR=.
LEX=flex
YACC=bison
SRC=$(DIR)
OBJ=./build
BLD=./build

all: fb1-4.yy.c

fb1-4.yy.c:
	$(LEX) -o build/fb1-4.yy.c fb1-4.l

exampleA:
	flex -o  $(BLD)/exmapleA.yy.c exampleA.l
	gcc $(BLD)/exmapleA.yy.c -lfl -$(SRC)/exmapleA.yy.c

bas:
	yacc -d bas.y

blank:
	flex -o build/blank.yy.c blank.l
	
clean:
	-rm -rf build/*