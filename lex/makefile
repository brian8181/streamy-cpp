# File Name:   lex/makefile
# Modify Date: Fri Apr 12 11:26:14 PM CDT 2024
# Version:     0.0.1

CC=gcc
LEX=flex
YACC=bison
BLD=build
SRC=.
YYACFLAGS=-Wcounterexamples

all: $(BLD)/ch3 $(BLD)/ch3.yy.c $(BLD)/ch3.tab.c

$(BLD)/ch3: $(BLD)/ch3.tab.c $(BLD)/ch3.yy.c
	$(CC) $(BLD)/ch3.yy.c $(BLD)/ch3.tab.c -o $(BLD)/ch3

$(BLD)/ch3.yy.c: $(SRC)/ch3.l
	$(LEX) -o $(BLD)/ch3.yy.c $(SRC)/ch3.l

$(BLD)/ch3.tab.c: $(SRC)/ch3.y
	$(YACC) $(YYACFLAGS) -o $(BLD)/ch3.tab.c -d ch3.y

.PHONY: clean
clean:
	-rm -rf $(BLD)/*

.PHONY: help
help:
	@echo
	@echo '** Syntax **'
	@echo ch3 num+num[+num]...
	@echo
	@echo '** Make Targets **'
	@echo 'all - builds ch3 & dependencies'
	@echo "$(BLD)/ch3 - builds ch3 & dependencies"
	@echo "$(BLD)/ch3.yy.c - complies ch3.l"
	@echo "$(BLD)/ch3.tab.c - complies ch3.y"
	@echo
