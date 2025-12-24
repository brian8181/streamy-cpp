# File Name:  makefile
# Build Date: Thu, Dec 18, 2025  9:16:12 PM
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
TST=tests

CXXFLAGS = -std=c++20 -fPIC
CCFLAG = -std=c99 -fPIC

LIBS = -L/usr/local/lib/
INCLUDES = -I./build/ -I./src
LDFLAGS = $(LIBS) $(INCLUDES)

ifndef RELEASE
	CXXFLAGS +=-ggdb -DDEBUG
endif

ifdef CYGWIN
	CXXFLAGS +=-DCYGWIN
	LDFLAGS += -lfmt -lcppunit.dll
else
	LDFLAGS += -lfmt -lcppunit
endif

all: copy_headers $(BLD)/parser_pp $(BLD)/parser $(BLD)/lex $(BLD)/lex2 $(BLD)/TEST_lex # $(BLD)/lex4

$(BLD)/parser: $(BLD)/parser.tab.c $(BLD)/parser.tab.h $(BLD)/lex.yy.c $(BLD)/lex.yy.h
	$(CC) -Ibuild $(CCFLAGS) $^ -lfl -o $@

$(BLD)/parser_pp: $(BLD)/lex.yy.o $(BLD)/parser.tab.o $(SRC)/symtab.cpp
	$(CXX) $(CXXFLAGS) -Ibuild $(CXXFLAGS) $^ -lfl -o $@

$(BLD)/parser.tab.cpp: $(SRC)/parser.yy
	$(YACC) -Wcounterexamples --header $^ -o $@
	cp $(SRC)/bash_color.h $(BLD)/

$(BLD)/parser.tab.c $(BLD)/parser.tab.h: $(SRC)/parser.y
	$(YACC) -Wcounterexamples --header $^ -o $@
	cp $(SRC)/bash_color.h $(BLD)/

$(BLD)/lex: $(BLD)/parser.tab.c $(BLD)/parser.tab.h $(BLD)/lex.yy.c $(BLD)/lex.yy.h
	$(CC) $(CCFLAGS) -DLEXER_EXE $(BLD)/lex.yy.c -o $(BLD)/lex

$(BLD)/lex.yy.c $(BLD)/lex.yy.h: $(SRC)/lex.l
	$(LEX) -o build/lex.yy.c --header-file="build/lex.yy.h" src/lex.l

$(BLD)/lex4: $(BLD)/lex4.yy.c
	$(CC) $(CCFLAGS) -DLEXER_EXE $(BLD)/lex4.yy.c -o $(BLD)/lex4

$(BLD)/lex4.yy.o: $(BLD)/lex4.yy.c
	$(CC) $(CCFLAGS) -DLEXER_EXE -c $^ -o $@

$(BLD)/lex4.yy.c: $(BLD)/parser.tab.c $(SRC)/lex.ll
	$(LEX) -DLEXER_EXE -o build/lex4.yy.c --header-file="build/lex4.yy.h" src/lex.ll

$(BLD)/TEST_lex: $(TST)/TEST_config.cpp $(TST)/TEST_lexer.cpp $(TST)/main.cpp $(BLD)/utility.o $(BLD)/fileio.o $(BLD)/streamy.o
	$(CXX) -DLEXER_EXE $(CXXFLAGS) $^ $(LDFLAGS) -o $@

$(BLD)/fileio.o: $(SRC)/fileio.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o

$(OBJ)/%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $^ -o $@

# copy all headers from src to build dir
.PHONY: copy_headers
copy_headers:
	-cp $(SRC)/*.h $(BLD)/

# clean & make
.PHONY: rebuild
rebuild: clean all

# remove all from build dir
.PHONY: clean
clean:
	-rm -rf ./$(OBJ)/*
	-rm -rf ./$(BLD)/*

# remove any object files from src dir
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
