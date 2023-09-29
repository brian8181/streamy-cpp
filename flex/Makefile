
CC       = gcc -g
LEX      = flex -i -I 
YACC     = bison -d -y

BUILD=./build

all: streamy eof

poc1: poc1.yy.c
	gcc $(BUILD)/poc1.yy.c -ll -o $(BUILD)/poc1

poc1.yy.c:
	$(LEX) -o $(BUILD)/poc1.yy.c poc1.l

streamy: streamy.yy.c
	gcc $(BUILD)/streamy.yy.c -ll -o $(BUILD)/streamy

streamy.yy.c:
	flex -o $(BUILD)/streamy.yy.c streamy.l

eof:	eof_rules.l
	$(LEX)  eof_rules.l
	$(CC)   lex.yy.c -o eof -ll

.PHONY: clean
clean:
	-rm $(BUILD)/*