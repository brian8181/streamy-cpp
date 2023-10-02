
# Streamy-cpp Make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

CC       = gcc -g
LEX      = flex -i -I 
YACC     = bison -d -y

BUILD=./build

all: streamy streamy-cpp

streamy-cpp: streamy-cpp.yy.c
	gcc $(BUILD)/streamy-cpp.yy.c -ll -o $(BUILD)/streamy-cpp

streamy: streamy.yy.c
	gcc $(BUILD)/streamy.yy.c -ll -o $(BUILD)/streamy

streamy-cpp.yy.c:
	flex -o ./build/streamy-cpp.yy.c streamy-cpp.l

streamy.yy.c:
	flex -o $(BUILD)/streamy.yy.c streamy.l

eof:	eof_rules.l
	$(LEX)  eof_rules.l
	$(CC)   lex.yy.c -o eof -ll

b2: 
	$(YACC) b2.y

.PHONY: clean
clean:
	-rm $(BUILD)/*