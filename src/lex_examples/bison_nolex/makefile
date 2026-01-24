# File Name:   lex/calc2/makefile
# Modify Date: Fri Apr 12 11:26:14 PM CDT 2024
# Version:     0.0.1

CC=gcc
LEX=flex
YACC=bison
OBJ=build
BLD=build
SRC=.

all: $(BLD)/calc

$(BLD)/calc: $(BLD)/lexer.h $(BLD)/calc.tab.c $(OBJ)/lexer.o
	$(CC) $(OBJ)/lexer.o $(BLD)/calc.tab.c -o $(BLD)/calc

$(OBJ)/lexer.o: $(BLD)/calc.tab.h $(SRC)/lexer.h $(SRC)/lexer.c
	$(CC) -c $(SRC)/lexer.c -o $@

$(BLD)/calc.tab.c: $(SRC)/calc.y
	$(YACC) --header -o $(BLD)/calc.tab.c -d $(SRC)/calc.y

# copy header files
$(BLD)/lexer.h: $(SRC)/lexer.h
	cp $^ $@


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
