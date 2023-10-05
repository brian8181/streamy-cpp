
# Streamy-cpp Make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

CC       = gcc -g
#LEX      = flex -i -I 
LEX      = flex
YACC     = bison -d -y

SRC = .
BUILD=./build

all: streamy streamy-cpp tokenizer

streamy-cpp: streamy-cpp.yy.c
	$(CC) $(BUILD)/streamy-cpp.yy.c -ll -o $(BUILD)/streamy-cpp

streamy: streamy.yy.c
	%(CC) $(BUILD)/streamy.yy.c -ll -o $(BUILD)/streamy

streamy-cpp.yy.c:
	$(LEX) -o ./build/streamy-cpp.yy.c streamy-cpp.l

streamy.yy.c:
	$(LEX) -o $(BUILD)/streamy.yy.c streamy.l

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BUILD)/tokenizer.yy.c -ll -o $(BUILD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BUILD)/tokenizer.yy.c $(SRC)/tokenizer.l

eof:	eof_rules.l
	$(LEX)  eof_rules.l
	$(CC)   lex.yy.c -o eof -ll

b2: 
	$(YACC) b2.y

.PHONY: clean
clean:
	-rm $(BUILD)/*