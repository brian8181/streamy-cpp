# File Name:  streamy-cpp/makefile
# Build Date: Wed Feb 14 03:28:42 PM CST 2024
# Version:    0.1.0

PREFIX = /usr/local
CXX = g++
CXXFLAGS = -ggdb -Wall -DDEBUG -std=c++17
#CXXEXTRA = -Wshadow -fstats -fno-rtti fmessage-length=100 -fverbose-asm
CC = gcc
CCFLAGS = -ggdb -std=c99 -DDEBUG
LEX = flex
YACC = bison -d
SRC = src
BLD = build
OBJ = build

# do linking dip fucing shit fuck bastard shit
all: $(BLD)/libstreamy.so $(BLD)/libstreamy.a $(BLD)/index.cgi $(BLD)/index2.cgi $(BLD)/index3.cgi $(BLD)/parse $(BLD)/lex


$(BLD)/streamy.o: $(BLD)/compiler.o $(SRC)/streamy.cpp
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC -c $(OBJ)/compiler.o $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

# do linking
$(BLD)/compiler.o: $(SRC)/compiler.cpp
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/compiler.cpp -o $(OBJ)/compiler.o

$(BLD)/utility.o: $(SRC)/utility.cpp
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/utility.cpp -o $(OBJ)/utility.o

$(BLD)/index.cgi: $(BLD)/utility.o $(BLD)/libstreamy.so $(BLD)/libstreamy.a $(BLD)/index.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC -I$(PREFIX)/include $(OBJ)/index.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/index_so.cgi

$(BLD)/index2.cgi: $(BLD)/utility.o $(BLD)/libstreamy.so $(BLD)/libstreamy.a $(BLD)/index2.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/index2.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index2.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include -L$(PREFIX)/lib $(OBJ)/index2.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index2_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index2.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/inde23_so.cgi

$(BLD)/index3.cgi: $(BLD)/utility.o $(BLD)/libstreamy.so $(BLD)/libstreamy.a $(BLD)/index3.o
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index3.o $(OBJ)/streamy.o $(OBJ)/utility.o -o $(BLD)/index3.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index3.o $(OBJ)/libstreamy.a $(OBJ)/utility.o -o $(BLD)/index3_a.cgi
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index3.o $(OBJ)/libstreamy.so $(OBJ)/utility.o -o $(BLD)/index3_so.cgi

$(BLD)/index_soso.cgi: install
	$(CXX) $(CXXFLAGS) -fPIC -I$(PREFIX)/include $(OBJ)/index.o $(OBJ)/utility.o -lstreamy -L$(PREFIX) -o $(BLD)/index_soso.cgi
	cp $(SRC)/index.conf $(BLD)/index.conf

$(BLD)/index.o: $(SRC)/index.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/index.cpp -o $(OBJ)/index.o

$(BLD)/index2.o: $(SRC)/index2.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/index2.cpp -o $(OBJ)/index2.o

$(BLD)/index3.o: $(SRC)/index3.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/index3.cpp -o $(OBJ)/index3.o

$(BLD)/libstreamy.so: $(BLD)/streamy.o
	$(CXX) $(CXXFLAGS) $(CXXEXTRA) -fPIC --shared $(OBJ)/streamy.o $(OBJ)/compiler.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

$(BLD)/libstreamy.a: $(BLD)/streamy.o
	ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

$(BLD)/streamy_lex: $(SRC)/fileio.o $(BLD)/libstreamy.a $(BLD)/libstreamy.so
	# $(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy_lex.cpp -o $(OBJ)/streamy_lex.o
	# $(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(OBJ)/streamy.o -o $(BLD)/streamy_lex
	# $(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(BLD)/libstreamy.a -o $(BLD)/streamy_lex_a
	# $(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o -lstreamy -L$(PREFIX) -o $(BLD)/streamy_lex_so
	# cp $(SRC)/streamy_lex.conf $(BLD)/streamy_lex.conf

$(BLD)/fileio.o: $(SRC)/fileio.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o

$(BLD)/tokenizer: $(BLD)/tokenizer.yy.c
	$(CC) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

$(BLD)/tokenizer.yy.c: $(SRC)/tokenizer.l
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

$(BLD)/parse: $(BLD)/streamy.yy.c $(BLD)/streamy.tab.c
	$(CC) $(CCFLAGS) $(BLD)/streamy.yy.c $(BLD)/streamy.tab.c -I./build -lfl -o $(BLD)/parse

$(BLD)/lex: $(BLD)/streamy.yy.c
	$(CC) $(CCFLAGS) $(BLD)/streamy.yy.c -I./build -lfl -o $(BLD)/lex

$(BLD)/streamy.yy.c: $(SRC)/streamy.lex
	$(LEX) --yylineno --header-file=$(BLD)/streamy.yy.h -o $(BLD)/streamy.yy.c $(SRC)/streamy.lex

$(BLD)/streamy.bak.yy.c: $(SRC)/streamy.bak.l
	$(LEX) -o $(BLD)/streamy.bak.yy.c $(SRC)/streamy.bak.l

$(BLD)/streamy.tab.c: $(SRC)/streamy.y
	$(YACC) -Wcounterexamples --header $(SRC)/streamy.y -o $(BLD)/streamy.tab.c

.PHONY: lex_yacc_ex
lex_yacc_ex:
	$(LEX) -o $(BLD)/ex1.yy.c $(SRC)/ex1.l
	$(CC) $(BLD)/ex1.yy.c -o $(BLD)/ex1
	$(LEX) -o $(BLD)/ex2.yy.c $(SRC)/ex2.l
	$(CC) $(BLD)/ex2.yy.c -o $(BLD)/ex2

.PHONY: install
install:
	mkdir -p /usr/local/lib
	mkdir -p /usr/local/include
	cp $(SRC)/streamy.hpp $(PREFIX)/include/streamy.hpp
	cp -rf  $(BLD)/libstreamy.a $(PREFIX)/lib/libstreamy.a
	cp -rf  $(BLD)/libstreamy.so $(PREFIX)/lib/libstreamy.so
	chmod 755 $(PREFIX)/include/streamy.hpp $(PREFIX)/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

.PHONY: uninstall
uninstall:
	rm $(PREFIX)/include/streamy.hpp
	rm -rf $(PREFIX)/libstreamy.a $(PREFIX)/lib/libstreamy.so

.PHONY: rebuild
rebuild: clean all

.PHONY: clean
clean:
	-rm -rf ./$(OBJ)/*
	-rm -rf ./$(BLD)/*

.PHONY: clean_src
clean_src:
	-rm .$(SRC)/*.o

.PHONY: help
help:
	@echo  '  all         - build all'
	@echo  '  install     - copy files to /usr/local'
	@echo  '  uninstall   - remove files to /usr/local'
	@echo  '  clean       - remove most generated files but keep the config'
