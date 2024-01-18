# File Name:  Makefile
# Build Date: Thu Dec 21 09:06:55 AM CST 2023
# Version:    0.0.2

PREFIX = /usr/local
CXX = g++
CXXFLAGS = -ggdb -Wall -DDEBUG -std=c++17
# CXXEXTRA = -Wshadow -fstats -fno-rtti fmessage-length=100 -fverbose-asm
CC = gcc
CCFLAGS = -ggdb -std=c99
LEX = flex
YACC = bison -d
SRC = src
BLD = build
OBJ = build

all: libstreamy.so libstreamy.a compiler.o streamy_lexer index.cgi lexer_tester.cgi page_test.cgi streamy_lexer tokenizer tools file.o

yacc_lex: streamy_lexer tokenizer

streamy.o: compiler.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC -c $(SRC)/streamy.cpp $(OBJ)/compiler.o -o $(OBJ)/streamy.o

compiler.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/compiler.cpp -o $(OBJ)/compiler.o

utility.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/utility.cpp -o $(OBJ)/utility.o

page_test.cgi: utility.o libstreamy.so libstreamy.a page_test.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/page_test.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/page_test.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/page_test.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/page_test_a.cgi

index.cgi: utility.o libstreamy.so libstreamy.a index.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC -I$(PREFIX)/include $(OBJ)/index.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/index_so.cgi

lexer_tester.cgi: utility.o libstreamy.so libstreamy.a lexer_tester.o
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/lexer_tester.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/lexer_tester.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/lexer_tester.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/lexer_tester_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/lexer_tester.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/lexer_tester_so.cgi

index_soso.cgi: install
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index.o $(OBJ)/utility.o -lstreamy -L$(PREFIX) -o $(BLD)/index_soso.cgi
	cp $(SRC)/index.conf $(BLD)/index.conf

page_test.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/page_test.cpp -o $(OBJ)/page_test.o

index.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/index.cpp -o $(OBJ)/index.o

lexer_tester.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/lexer_tester.cpp -o $(OBJ)/lexer_tester.o

libstreamy.so: streamy.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC --shared $(OBJ)/streamy.o $(OBJ)/compiler.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

libstreamy.a: streamy.o streamy.o
	#ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

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
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o`

tools: tools.o
	$(CC) $(CCFLAGS) $(BLD)/tools.o -o $(BLD)/tools

tools.o:
	$(CC) $(CCFLAGS) -c $(SRC)/tools.c -o $(BLD)/tools.o

file.o:
	$(CC) $(CCFLAGS) -c $(SRC)/file.c -o $(BLD)/file.o

tokenizer: tokenizer.yy.c
	$(CC) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

streamy-cpp.o: streamy-cpp.yy.c
	$(CXX) $(CXXFLAGS) -c $(BLD)/streamy-cpp.yy.c -o $(BLD)/streamy-cpp.yy.o

streamy-cpp.yy.c:
	$(LEX) -o $(BLD)/streamy-cpp.yy.c $(SRC)/streamy-cpp

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

complie:
	g++ -c $(SRC)/*.cpp

install:
	mkdir -p /usr/local/lib
	mkdir -p /usr/local/include
	cp $(SRC)/streamy.hpp $(PREFIX)/include/streamy.hpp
	cp -rf  $(BLD)/libstreamy.a $(PREFIX)/lib/libstreamy.a
	cp -rf  $(BLD)/libstreamy.so $(PREFIX)/lib/libstreamy.so
	chmod 755 $(PREFIX)/include/streamy.hpp $(PREFIX)/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

uninstall:
	rm $(PREFIX)/include/streamy.hpp
	rm -rf $(PREFIX)/libstreamy.a $(PREFIX)/lib/libstreamy.so

clean:
	-rm $(BLD)/*

clean_src:
	-rm ./*.o