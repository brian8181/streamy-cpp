# CHANGE DATE: 
# Tue Oct  3 07:03:38 AM CDT 2023
# Tue Oct 24 08:40:27 AM CDT 2023

CXX = g++
CXXFLAGS = -g -Wall -std=c++11 -DDEBUG
CCFLAGS  = -g
CC       = gcc $(CCFLAGS)
#LEX      = flex -i -I 
LEX      = flex
YACC     = bison -d   

APPNAME = streamy
SRC = src
BLD = build
OBJ = build

all: streamy.so streamy.a streamy_test streamy_lex tokenizer

streamy.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

streamy.so: streamy.o
	$(CXX) $(CXXFLAGS) --shared $(OBJ)/streamy.o -o $(BLD)/streamy.so

streamy.a: streamy.o
	ar rvs $(BLD)/streamy.a $(OBJ)/streamy.o

streamy_test: streamy.o
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/app.cpp -o $(OBJ)/app.o
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o
	$(CXX) $(CXXFLAGS) $(OBJ)/app.o $(OBJ)/main.o $(OBJ)/streamy.o -o $(BLD)/streamy_test

streamy_lex:
	$(LEX) -o $(BLD)/streamy.yy.c $(SRC)/streamy.l
	$(CXX) $(CXXFLAGS) -c $(BLD)/streamy.yy.c -o $(BLD)/streamy_lex.o
	$(CXX) $(CXXFLAGS) $(OBJ)/streamy_lex.o -ll -o $(BLD)/streamy_lex

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

test1:
	g++ -std=c++14 -Wall -I/usr/local/include $(SRC)/010-TestCase.cpp -o $(BLD)/test1 

020-TestCase:
	g++ -std=c++14 -fPIC -Wall -I/usr/local/include -c $(SRC)/020-TestCase-1.cpp -o $(BLD)/020-TestCase-1.o
	g++ -std=c++14 -fPIC -Wall -I/usr/local/include -c $(SRC)/020-TestCase-2.cpp -o $(BLD)/020-TestCase-2.o
	g++ -std=c++14 -Wall -I/usr/local/include -o $(BLD)/020-TestCase $(BLD)/020-TestCase-1.o $(SRC)/020-TestCase-2.cpp && $(BLD)/020-TestCase --success

y.tab.c y.tab.h:
	$(YACC) $(SRC)/streamy-cpp.y
	mv ./streamy-cpp.tab.* $(BLD)/.

.PHONY: clean
clean:
	-rm $(BLD)/*