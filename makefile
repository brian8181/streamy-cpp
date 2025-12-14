# File Name:  streamy-cpp/makefile
# Build Date: Wed Feb 14 03:28:42 PM CST 2024
# Version:    0.1.0

CXX=g++
CXXFLAGS=-ggdb -Wall -DDEBUG -std=c++20
CC=gcc
CCFLAGS=-ggdb -std=c99 -DDEBUG
LEX=flex
YACC=bison -d
SRC=src
BLD=build
OBJ=build

LIBS = -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/ -I/home/brian/src/inflex/makes/ -I/home/brian/src/inflex/src/
LDFLAGS = $(LIBS) $(INCLUDES)

ifndef RELEASE
	CXXFLAGS +=-ggdb -DDEBUG
endif

ifdef CYGWIN
	CXXFLAGS +=-DCYGWIN
	LDFLAGS += /usr/lib/libcppunit.dll.a
endif

all: copy_headers $(BLD)/parser_pp $(BLD)/parser $(BLD)/lex $(BLD)/lex2 $(BLD)/lex4

$(BLD)/parser: $(BLD)/lex.yy.o $(BLD)/parser.tab.o
	$(CC) -Ibuild $(CCFLAGS) $^ -lfl -o $@

$(BLD)/parser_pp: $(BLD)/lex.yy.o $(BLD)/parser.tab.o $(SRC)/symtab.cpp
	$(CXX) $(CXXFLAGS) -Ibuild $(CXXFLAGS) $^ -lfl -o $@

$(BLD)/parser.tab.cpp: $(SRC)/parser.yy
	$(YACC) -Wcounterexamples --header $^ -o $@

$(BLD)/parser.tab.c: $(SRC)/parser.y
	$(YACC) -Wcounterexamples --header $^ -o $@

$(BLD)/lex: $(BLD)/lex.yy.c
	$(CC) -DLEXER_EXE $(BLD)/lex.yy.c -o $(BLD)/lex

$(BLD)/lex.yy.c: $(BLD)/parser.tab.c $(SRC)/lex.l
	flex -o build/lex.yy.c --header-file="build/lex.yy.h" src/lex.l

$(BLD)/lex4: $(BLD)/lex4.yy.c
	$(CC) -DLEXER_EXE $(BLD)/lex4.yy.c -o $(BLD)/lex4

$(BLD)/lex4.yy.c: $(BLD)/parser.tab.c $(SRC)/lex.ll
	flex -o build/lex4.yy.c --header-file="build/lex4.yy.h" src/lex.ll

$(BLD)/lex2: $(BLD)/lex2.yy.c
	$(CC) $(BLD)/lex2.yy.c -o $(BLD)/lex2

$(BLD)/lex2.yy.c: $(SRC)/lex2.l
	$(LEX) -o $(BLD)/lex2.yy.c $(SRC)/lex2.l

$(BLD)/lex3: $(BLD)/lex3.yy.c
	$(CC) $(BLD)/lex.yy.c -o $(BLD)/lex3

$(BLD)/lex3.yy.c: $(SRC)/lex3.l
	$(LEX) -o $(BLD)/lex3.yy.c $(SRC)/lex3.l


$(BLD)/fileio.o: $(SRC)/fileio.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o

$(OBJ)/%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $^ -o $@

.PHONY: copy_headers
copy_headers:
	-cp $(SRC)/*.h $(BLD)/

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
	@echo  ' Streamy Templates / library'
	@echo  ' Sun Mar 10 07:10:06 PM CDT 2024'
	@echo
	@echo  -n '** Build Targets **'
	@echo
	@echo  ' * all           - build all'
	@echo  ' * install       - copy files to /usr/local'
	@echo  ' * uninstall     - remove files to /usr/local'
	@echo  ' * clean         - remove most generated files but keep the config'
	@echo  ' * $(BLD)/libstreamy.a  - build static lib'
	@echo  ' * $(BLD)/libstreamy.so - build shared lib'
	@echo  ' * $(BLD)/tokenizer - build shared lib'
