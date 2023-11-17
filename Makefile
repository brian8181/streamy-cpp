# CHANGE DATE: 
# Tue Oct  3 07:03:38 AM CDT 2023
# Tue Oct 24 08:40:27 AM CDT 2023

PREFIX = /usr
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

all: libstreamy.so libstreamy.a streamy_test streamy_app streamy_lex

yacc_lex: streamy_lex tokenizer

streamy.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

libstreamy.so: streamy.o
	$(CXX) $(CXXFLAGS) -fPIC --shared $(OBJ)/streamy.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

libstreamy.a: streamy.o
	ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

streamy_test: streamy.o
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/app.cpp -o $(OBJ)/app.o
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o
	$(CXX) $(CXXFLAGS) $(OBJ)/app.o $(OBJ)/main.o $(OBJ)/streamy.o -o $(BLD)/streamy_test

streamy_app: libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC -c $(SRC)/streamy_app.cpp -o $(OBJ)/streamy_app.o
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_app.o -lstreamy -L$(PREFIX)/lib -o $(BLD)/streamy_app_so
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_app.o $(BLD)/libstreamy.a -o $(BLD)/streamy_app_a

streamy_lex: streamy.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC -c $(SRC)/streamy_lex.cpp -o $(OBJ)/streamy_lex.o
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_lex.o $(BLD)/streamy.o -o $(BLD)/streamy_lex
#$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_lex.o -lstreamy -L$(PREFIX)/lib -o $(BLD)/streamy_lex_so
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_lex.o $(BLD)/libstreamy.a -o $(BLD)/streamy_lex_a


streamy_lexer:
	$(LEX) -o $(BLD)/streamy.yy.c $(SRC)/streamy.l
	$(CXX) $(CXXFLAGS) -c $(BLD)/streamy.yy.c -o $(BLD)/streamy_lexer.o
	$(CXX) $(CXXFLAGS) $(OBJ)/streamy_lexer.o -ll -o $(BLD)/streamy_lexer

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

.PHONY: install
install:
	cp -rf  $(BLD)/libstreamy.a $(PREFIX)/lib/libstreamy.a
	cp -rf  $(BLD)/libstreamy.so $(PREFIX)/lib/libstreamy.so
	chmod 755  $(PREFIX)/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so


.PHONY: uninstall
uninstall:
	rm -rf /usr/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

.PHONY: clean
clean:
	-rm $(BLD)/*