
# Streamy-cpp Make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

CC       = gcc -g
LEX      = flex -i -I 
YACC     = bison -d -y

BUILD=./build

all: streamy streamy-cpp poc1

streamy-cpp: streamy-cpp.yy.c
	gcc $(BUILD)/streamy-cpp.yy.c -ll -o $(BUILD)/streamy-cpp

poc1: poc1.yy.c
	gcc $(BUILD)/poc1.yy.c -ll -o $(BUILD)/poc1

poc1.yy.c:
	$(LEX) -o $(BUILD)/poc1.yy.c poc1.l

streamy: streamy.yy.c
	gcc $(BUILD)/streamy.yy.c -ll -o $(BUILD)/streamy

streamy-cpp.yy.c:
	flex -o ./build/streamy-cpp.yy.c streamy-cpp.l

streamy.yy.c:
	flex -o $(BUILD)/streamy.yy.c streamy.l

eof:	eof_rules.l
	$(LEX)  eof_rules.l
	$(CC)   lex.yy.c -o eof -ll

.PHONY: clean
clean:
	-rm $(BUILD)/*