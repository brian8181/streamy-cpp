# File Name:   lex/stext2/makefile
# Modify Date: Fri Apr 12 11:26:14 PM CDT 2024
# Version:     0.0.1

CC=gcc
LEX=flex
YACC=bison
BLD=build
SRC=.

all: $(BLD)/stext $(BLD)/stext.yy.c $(BLD)/stext.tab.c

$(BLD)/stext: $(BLD)/stext.tab.c $(BLD)/stext.yy.c
	$(CC) $(BLD)/stext.yy.c $(BLD)/stext.tab.c -o $(BLD)/stext

$(BLD)/stext.yy.c: $(SRC)/stext.l
	$(LEX)  --header-file=$(BLD)/stext.yy.h -o $(BLD)/stext.yy.c $(SRC)/stext.l

$(BLD)/stext.tab.c: $(SRC)/stext.y
	$(YACC) -o $(BLD)/stext.tab.c -d stext.y

.PHONY: clean
clean:
	-rm -rf $(BLD)/*

.PHONY: help
help:
	@echo
	@echo '** Syntax **'
	@echo stext num+num[+num]...
	@echo
	@echo '** Make Targets **'
	@echo 'all - builds stext & dependencies'
	@echo "$(BLD)/stext - builds stext & dependencies"
	@echo "$(BLD)/stext.yy.c - complies stext.l"
	@echo "$(BLD)/stext.tab.c - complies stext.y"
	@echo