CC=gcc
LEX=flex
YACC=bison
BLD=build
SRC=.

all: $(BLD)/calc $(BLD)/calc.yy.c $(BLD)/calc.tab.c

$(BLD)/calc: $(BLD)/calc.tab.c $(BLD)/calc.yy.c
	$(CC) $(BLD)/calc.yy.c $(BLD)/calc.tab.c -o $(BLD)/calc

$(BLD)/calc.yy.c: $(SRC)/calc.l
	$(LEX) -o $(BLD)/calc.yy.c $(SRC)/calc.l

$(BLD)/calc.tab.c: $(SRC)/calc.y
	$(YACC) -o $(BLD)/calc.tab.c -d calc.y

.PHONY: clean
clean:
	-rm -rf $(BLD)/*
