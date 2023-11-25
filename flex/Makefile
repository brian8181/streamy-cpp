
# Streamy-cpp Make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

CC       = gcc -g
#LEX      = flex -i -I 
LEX      = flex
YACC     = bison

SRC = .
BUILD= ./build

all: streamy streamy-cpp tokenizer

streamy-cpp: streamy-cpp.yy.c
	gcc $(BUILD)/streamy-cpp.yy.c -ll -o $(BUILD)/streamy-cpp

streamy: streamy.yy.c
	gcc $(BUILD)/streamy.yy.c -ll -o $(BUILD)/streamy

streamy-cpp.yy.c:
	flex -o ./build/streamy-cpp.yy.c streamy-cpp.l

streamy.yy.c:
	flex -o $(BUILD)/streamy.yy.c streamy.l

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BUILD)/tokenizer.yy.c -ll -o $(BUILD)/tokenizer

tokenizer.yy.c:
	flex -o $(BUILD)/tokenizer.yy.c $(SRC)/tokenizer.l

eof: eof_rules.l
	$(LEX)  eof_rules.l
	$(CC)   lex.yy.c -o eof -ll

test: 
	$(YACC) -dv -o $(BUILD)/test.tab.c $(SRC)/test.y
	$(LEX) -i -I -o $(BUILD)/stream_t1.yy.c $(SRC)/streamy.l


b2: 
	$(YACC) b2.y

clean:
	-rm -rf $(BUILD)/*