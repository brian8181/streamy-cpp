# File Name:  makefile
# Build Date: Fri Feb  2 08:20:33 PM CST 2024
# Version:    0.0.1

CC=gcc
CX=-Wall -std=c11 -DDEBUG -ggdb
LEX=flex
YACC=bison
SRC=.
OBJ=./build
BLD=./build

all: parser

$(BLD)/parser: $(BLD)/lex.yy.c $(BLD)/parser.tab.c
	$(CC) $(CX) $(BLD)/lex.yy.c $(BLD)/parser.tab.c -lfl -o $(BLD)/parser

$(BLD)/lex.yy.c: tokenizer.l
	$(LEX) --header-file=$(BLD)/lex.yy.h -o $(BLD)/lex.yy.c tokenizer.l

$(BLD)/parser.tab.c: parser.y
	$(YACC) --header parser.y -o $(BLD)/parser.tab.c

clean:
	-rm -rf build/*