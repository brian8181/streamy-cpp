#// License:    None
#// File Name:  ./project_template/makefile
#// Build Date: Wed Feb 14 03:58:51 PM CST 2024
#// Version:    0.1.0

XX=g++
CXXFLAGS=-ggdb -Wall -DDEBUG -std=c++17
CC=gcc
CCFLAGS=-ggdb -std=c99 -DDEBUG
LEX=flex
YACC=bison -d
SRC=src
BLD=build
OBJ=build
PREFIX=/usr/local

all: $(BLD)/parse

$(BLD)/parse: $(BLD)/lexer.yy.c $(BLD)/parse.tab.c
	$(CC) $(CCFLAGS) $(BLD)/lexer.yy.c $(BLD)/parse.tab.c -I./build -lfl -o $(BLD)/parse

$(BLD)/parse.tab.c: $(SRC)/parse.y
	$(YACC) --header $(SRC)/parse.y -o $(BLD)/parse.tab.c

$(BLD)/lexer.yy.c: $(SRC)/lexer.l
	$(LEX) --yylineno --header-file=$(BLD)/lexer.yy.h -o $(BLD)/lexer.yy.c $(SRC)/lexer.l

.PHONY: clean
clean:
	-rm -f $(OBJ)/*.
	-rm -f $(BLD)/*
