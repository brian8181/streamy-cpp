# streamy-cpp make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

CXX = g++
CXXFLAGS = -g -Wall -DDEBUG -std=c++17
CC = gcc -g
#LEX = flex -i -I 
LEX = flex
YACC = bison

SRC = .
BUILD=./build

all: streamy-cpp.yy.c

streamy-cpp: streamy-cpp.yy.c tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BUILD)/streamy-cpp.yy.c -o $(BUILD)/streamy-cpp

streamy-cpp.yy.c:
	$(LEX) -o $(BUILD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BUILD)/tokenizer.yy.c $(BUILD)/streamy-cpp.yy.c -I/usr/include -o $(BUILD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BUILD)/tokenizer.yy.c $(SRC)/tokenizer.l


# eof: eof_rules.l
# 	$(LEX)  eof_rules.l
# 	$(CC)   lex.yy.c -o eof -ll

test: 
	$(YACC) -dv -o $(BUILD)/test.tab.c $(SRC)/test.y
	$(LEX) -i -I -o $(BUILD)/stream_t1.yy.c $(SRC)/streamy.l
	$(YACC) b2.y

clean:
	-rm -rf $(BUILD)/*