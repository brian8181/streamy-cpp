#// License:    None
#// File Name:  ./project_template/makefile
#// Build Date: Wed Feb 14 03:58:51 PM CST 2024
#// Version:    0.1.0

CXX=g++
CC=gcc
LEX=flex
YACC=bison
CXXFLAGS=-Wall -std=c++17 -DDEBUG -g
CCFLAGS=-ggdb -std=c99 -DDEBUG
APPNAME=abc
BLD=build
OBJ=build
SRC=.

debug: all

all: $(BLD)/parser.tab.c $(BLD)/lexer

$(BLD)/parser: $(BLD)/lexer.yy.c $(BLD)/parser.tab.c
	$(CC) $(CX) $(BLD)/lexer.yy.c $(BLD)/parser.tab.c -lfl -o $(BLD)/parser

$(BLD)/lexer: $(BLD)/lexer.yy.c
	$(CC) $(CCFLAGS) $(BLD)/lexer.yy.c -I./build -lfl -o $(BLD)/lexer

$(BLD)/lexer.yy.c: $(SRC)/lexer.l
	$(LEX) --yylineno --header-file=$(BLD)/lexer.yy.h -o $(BLD)/lexer.yy.c $(SRC)/lexer.l

$(BLD)/parser.tab.c: $(SRC)/parser.y
	$(YACC) -Wcounterexamples --header $(SRC)/parser.y -o $(BLD)/parser.tab.c

.PHONY: clean
clean:
	-rm -f $(OBJ)/*.
	-rm -f $(BLD)/*
