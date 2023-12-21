# License:    GPL
# Author:     Brian K Preston
# File Name:  Makefile
# Build Date: Thu Dec 21 09:06:55 AM CST 2023
# Version:    0.0.2

PREFIX = /usr/lib
CXX = g++
CXXFLAGS = -ggdb -Wall -DDEBUG -std=c++17 # -fmessage-length=100 -fverbose-asm
CC = gcc -ggdb
LEX = flex
YACC = bison -d   
SRC = src
BLD = build
OBJ = build

all: libstreamy.so libstreamy.a streamy_lexer index.cgi index.cgi streamy_lexer tokenizer

yacc_lex: streamy_lexer tokenizer

streamy.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

utility.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/utility.cpp -o $(OBJ)/utility.o

index.cgi: utility.o libstreamy.so libstreamy.a index.o
	$(CXX) $(CXXFLAGS) -fPIC -I$(SRC) $(OBJ)/index.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(SRC) $(OBJ)/index.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(SRC) $(OBJ)/index.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/index_so.cgi   

index_soso.cgi: install
	$(CXX) $(CXXFLAGS) -fPIC -I$(SRC) $(OBJ)/index.o $(OBJ)/utility.o -lstreamy -L$(PREFIX) -o $(BLD)/index_soso.cgi                                                                 
	cp $(SRC)/index.conf $(BLD)/index.conf

index.o: 
	$(CXX) $(CXXFLAGS) -I$(SRC) -c $(SRC)/index.cpp -o $(OBJ)/index.o

libstreamy.so: streamy.o
	$(CXX) $(CXXFLAGS) -fPIC --shared $(OBJ)/streamy.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

libstreamy.a: streamy.o
	ar rcs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	#ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

streamy_app: fileio.o streamy.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy_app.cpp -o $(OBJ)/streamy_app.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_app.o $(OBJ)/streamy.o $(OBJ)/fileio.o -o $(BLD)/streamy_app
	#$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_app.o $(BLD)/libstreamy.a $(OBJ)/fileio.o -o $(BLD)/streamy_app_a
	#$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_app.o -lstreamy -L$(PREFIX) -o $(BLD)/streamy_app_so

streamy_lex: fileio.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy_lex.cpp -o $(OBJ)/streamy_lex.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(OBJ)/streamy.o -o $(BLD)/streamy_lex
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(BLD)/libstreamy.a -o $(BLD)/streamy_lex_a
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o -lstreamy -L$(PREFIX) -o $(BLD)/streamy_lex_so
	cp $(SRC)/streamy_lex.conf $(BLD)/streamy_lex.conf

streamy_lexer:
	$(LEX) -o $(BLD)/streamy.yy.c $(SRC)/streamy.l
	$(CXX) -g -DDEBUG -std=c++17 -c $(BLD)/streamy.yy.c -o $(BLD)/streamy_lexer.o
	$(CXX) -g -DDEBUG -std=c++17 $(OBJ)/streamy_lexer.o -ll -o $(BLD)/streamy_lexer

fileio.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o	

tokenizer: tokenizer.yy.c
	$(CC) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

CATCH_SINGLE_INCLUDE = /usr/local/include
test1:
	#g++ -std=c++14 -Wall -I/usr/local/include $(SRC)/010-TestCase.cpp -o $(BLD)/test1
	g++ -std=c++14 -Wall -I$(CATCH_SINGLE_INCLUDE) $(SRC)/010-TestCase.cpp -o $(BLD)/010-TestCase
	g++ -std=c++14 -Wall -I/usr/local/include -c $(SRC)/020-TestCase-1.cpp -o $(BLD)/020-TestCase-1.o
	g++ -std=c++14 -Wall -I/usr/local/include -c $(SRC)/020-TestCase-2.cpp -o $(BLD)/020-TestCase-2.o
	g++ -std=c++14 -Wall -I/usr/local/include -o $(BLD)/020-TestCase $(BLD)/020-TestCase-1.o $(SRC)/020-TestCase-2.cpp && $(BLD)/020-TestCase --success

020-TestCase-1:
	g++ -std=c++14 -Wall -I/usr/local/include -c $(SRC)/020-TestCase-1.cpp -o $(BLD)/020-TestCase-1.o

stream_app.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/app.cpp -o $(OBJ)/stream_app.o

streamy-cpp.o: streamy-cpp.yy.c
	$(CXX) $(CXXFLAGS) -c $(BLD)/streamy-cpp.yy.c -o $(BLD)/streamy-cpp.yy.o

streamy-cpp.yy.c:
	$(LEX) -o $(BLD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

complie:
	g++ -c $(SRC)/*.cpp

install:
	cp -rf  $(BLD)/libstreamy.a $(PREFIX)/libstreamy.a
	cp -rf  $(BLD)/libstreamy.so $(PREFIX)/libstreamy.so
	chmod 755  $(PREFIX)/libstreamy.a $(PREFIX)/libstreamy.so

uninstall:
	rm -rf $(PREFIX)/libstreamy.a $(PREFIX)/libstreamy.so

clean:
	-rm $(BLD)/*

clean_src:
	-rm ./*.o