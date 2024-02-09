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

parser: streamy.yy.c streamy.tab.c
	$(CC) $(CX) $(BLD)/streamy.yy.c $(BLD)/streamy.tab.c -lfl -o $(BLD)/streamy

streamy.yy.c:
	$(LEX) --header-file=$(BLD)/streamy.yy.h -o $(BLD)/streamy.yy.c streamy.l

streamy.tab.c:
	$(YACC) --header streamy.y -o $(BLD)/streamy.tab.c

clean:
	-rm -rf build/*