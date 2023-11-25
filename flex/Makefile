
# streamy-cpp make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

<<<<<<< HEAD
CC = gcc -g
#LEX = flex -i -I 
LEX = flex
YACC = bison -d -y

SRC = .
BUILD=./build

all: streamy-cpp tokenizer
=======
CC       = gcc -g
#LEX      = flex -i -I 
LEX      = flex
YACC     = bison

SRC = .
BUILD= ./build

all: streamy streamy-cpp tokenizer
>>>>>>> step_one_lexer

streamy-cpp: streamy-cpp.yy.c
	$(CC) $(BUILD)/streamy-cpp.yy.c -ll -o $(BUILD)/streamy-cpp

streamy-cpp.yy.c:
	$(LEX) -o ./build/streamy-cpp.yy.c streamy-cpp.l

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BUILD)/tokenizer.yy.c -ll -o $(BUILD)/tokenizer

<<<<<<< HEAD
tokenizer.yy.c:
	$(LEX) -o $(BUILD)/tokenizer.yy.c $(SRC)/tokenizer.l
=======
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
>>>>>>> step_one_lexer

clean:
	-rm -rf $(BUILD)/*