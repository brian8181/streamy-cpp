# File Name:   lex/calc/makefile
# Modify Date: Fri Apr 12 11:26:14 PM CDT 2024
# Version:     0.0.1

CC=gcc
LEX=flex
YACC=bison
BLD=build
SRC=.
YYACFLAGS=-Wcounterexamples

all: $(BLD)/calc $(BLD)/calc.yy.c $(BLD)/calc.tab.c

$(BLD)/calc: $(BLD)/calc.tab.c $(BLD)/calc.yy.c
	$(CC) $(BLD)/calc.yy.c $(BLD)/calc.tab.c -o $(BLD)/calc

$(BLD)/calc.yy.c: $(SRC)/calc.l
	$(LEX) -o $(BLD)/calc.yy.c $(SRC)/calc.l

$(BLD)/calc.tab.c: $(SRC)/calc.y
	$(YACC) $(YYACFLAGS) -o $(BLD)/calc.tab.c -d calc.y

.PHONY: clean
clean:
	-rm -rf $(BLD)/*

.PHONY: help
help:
	@echo
	@echo '** Syntax **'
	@echo calc num+num[+num]...
	@echo
	@echo '** Make Targets **'
	@echo 'all - builds calc & dependencies'
	@echo "$(BLD)/calc - builds calc & dependencies"
	@echo "$(BLD)/calc.yy.c - complies calc.l"
	@echo "$(BLD)/calc.tab.c - complies calc.y"
	@echo
