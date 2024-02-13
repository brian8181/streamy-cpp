# File Name:  Makefile
# Build Date: Thu Dec 21 09:06:55 AM CST 2023
# Version:    0.0.2

PREFIX = /usr/local
CXX = g++
CXXFLAGS = -ggdb -Wall -DDEBUG -std=c++17
# CXXEXTRA = -Wshadow -fstats -fno-rtti fmessage-length=100 -fverbose-asm
CC = gcc
CCFLAGS = -ggdb -std=c99 -DDEBUG
LEX = flex
YACC = bison -d
SRC = src
BLD = build
OBJ = build

all: libstreamy.so libstreamy.a index.cgi index2.cgi index3.cgi parser

yacc: tokenizer streamy.bak.yy.c streamy.yy.c

streamy.o: compiler.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC -c $(OBJ)/compiler.o $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

compiler.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/compiler.cpp -o $(OBJ)/compiler.o

utility.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/utility.cpp -o $(OBJ)/utility.o

index.cgi: utility.o libstreamy.so libstreamy.a index.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC -I$(PREFIX)/include $(OBJ)/index.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/index_so.cgi

index2.cgi: utility.o libstreamy.so libstreamy.a index2.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/index2.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index2.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index2.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index2_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index2.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/inde23_so.cgi

index3.cgi: utility.o libstreamy.so libstreamy.a index3.o
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index3.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index3.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index3.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index3_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index3.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/index3_so.cgi

index_soso.cgi: install
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index.o $(OBJ)/utility.o -lstreamy -L$(PREFIX) -o $(BLD)/index_soso.cgi
	cp $(SRC)/index.conf $(BLD)/index.conf

index.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/index.cpp -o $(OBJ)/index.o

index2.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/index2.cpp -o $(OBJ)/index2.o

index3.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/index3.cpp -o $(OBJ)/index3.o

libstreamy.so: streamy.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC --shared $(OBJ)/streamy.o $(OBJ)/compiler.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

libstreamy.a: streamy.o
	ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

# streamy_lex: fileio.o libstreamy.a libstreamy.so
# 	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy_lex.cpp -o $(OBJ)/streamy_lex.o
# 	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(OBJ)/streamy.o -o $(BLD)/streamy_lex
# 	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(BLD)/libstreamy.a -o $(BLD)/streamy_lex_a
# 	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o -lstreamy -L$(PREFIX) -o $(BLD)/streamy_lex_so
# 	cp $(SRC)/streamy_lex.conf $(BLD)/streamy_lex.conf

# streamy_lexer:
# 	$(LEX) -o $(BLD)/streamy.yy.c $(SRC)/streamy.l
# 	$(CXX) -g -DDEBUG -std=c++17 -c $(BLD)/streamy.yy.c -o $(BLD)/streamy_lexer.o
# 	$(CXX) -g -DDEBUG -std=c++17 $(OBJ)/streamy_lexer.o -ll -o $(BLD)/streamy_lexer

fileio.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o`

tokenizer: tokenizer.yy.c
	$(CC) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

parser: streamy.yy.c streamy.tab.c
	$(CC) $(CCFLAGS) $(BLD)/streamy.yy.c $(BLD)/streamy.tab.c -I./build -lfl -o $(BLD)/streamy.exe

streamy.yy.c:
	$(LEX) --header-file=$(BLD)/streamy.yy.h -o $(BLD)/streamy.yy.c $(SRC)/streamy.l

streamy.bak.yy.c:
	$(LEX) -o $(BLD)/streamy.bak.yy.c $(SRC)/streamy.bak.l

streamy.tab.c:
	$(YACC) --header $(SRC)/streamy.y -o $(BLD)/streamy.tab.c

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