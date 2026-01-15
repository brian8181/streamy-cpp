# File Name:  makefile
# Build Date: Thu, Dec 18, 2025  9:16:12 PM
# Version:    0.1.0


# ifndef ROOT
# 	ROOT=/home/brian/src/streamyv2
# endif

CXX=g++
CXXFLAGS=-ggdb -DDEBUG -std=c++20 -Wall # $(CXXWARN)
CC=gcc
CCFLAGS=-ggdb -std=c99 -DDEBUG
LEX=flex
YACC=bison -d
SRC=src
BLD=build
OBJ=build
TST=tests

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

all: $(BLD)/parser $(BLD)/lex++ $(BLD)/TEST_lex $(BLD)/lex # $(BLD)/parser++

# parser # USING C COMPLIER ON CPP! BUT IT BUILDS?
$(BLD)/parser: $(BLD)/parser.tab.h $(BLD)/parser.tab.c $(BLD)/lex.yy.h $(BLD)/lex.yy.c $(OBJ)/symtab.o | copy_headers
	@echo -e "\nBuilding \"lexer & parser\" ...\n"
	$(CC) $(CCFLAGS) -Ibuild $^ -lfl -o $@

$(BLD)/parser.tab.c $(BLD)/parser.tab.h $(BLD)/bash_color.h: $(SRC)/parser.y #$(SRC)/bash_color.h
	@echo -e "\nGererating \"parser\" ...\n"
	$(YACC) -Wcounterexamples --header $^ -o $@
	cp $(SRC)/*.h $(BLD)/

# CC lexer
$(BLD)/lex.yy.c $(BLD)/lex.yy.h: $(SRC)/lex.l
	@echo -e "\nGenerating \"lexer\" ...\n"
	$(LEX) -o build/lex.yy.c --header-file="build/lex.yy.h" src/lex.l

$(BLD)/lex: $(BLD)/parser.tab.h $(BLD)/parser.tab.c $(BLD)/lex.yy.h $(BLD)/lex.yy.c $(OBJ)/symtab.o
	$(CC) $(CCFLAGS) $^ -lfl -o $@

$(BLD)/parser_test: $(BLD)/parser_test.tab.h $(BLD)/parser_test.tab.c $(BLD)/lex.yy.h $(BLD)/lex.yy.c
	@echo -e "\nBuilding \"lexer & parser\" ...\n"
	$(CC) $(CCFLAGS) -Ibuild $^ -lfl -o $@

$(BLD)/parser_test.tab.c $(BLD)/parser_test.tab.h: $(SRC)/parser_test.y #$(SRC)/bash_color.h
	@echo -e "\nGererating \"parser_test\" ...\n"
	$(YACC) -Wcounterexamples --header $^ -o $@
	cp $(SRC)/bash_color.h $(BLD)/

$(BLD)/lex.bak.yy.c $(BLD)/lex.bak.yy.h: $(SRC)/lex.l
	$(LEX) -o build/lex.bak.yy.c --header-file="build/lex.bak.yy.h" src/lex.l

# CXX parser
$(BLD)/parser++: $(BLD)/parser++.tab.hpp $(BLD)/parser++.tab.cpp $(BLD)/lex++.yy.hpp $(BLD)/lex++.yy.cpp $(SRC)/symtab.h $(SRC)/symtab.cpp
	$(CXX) $(CXXFLAGS) -Ibuild $^ -lfl -o $@

$(BLD)/parser++.tab.cpp $(BLD)/parser++.tab.hpp: $(SRC)/parser.yy
	$(YACC) -Wcounterexamples --header $^ -o $@
	cp $(SRC)/bash_color.h $(BLD)/

# CXX lexer # USING C COMPLIER ON CPP! BUT IT BUILDS?
$(BLD)/lex++: $(BLD)/parser++.tab.hpp $(BLD)/lex++.yy.cpp
	$(CC) -ggdb -DDEBUG -DMAIN_IMP -DLEXER_EXE $(BLD)/lex++.yy.cpp -o $(BLD)/lex++

$(BLD)/lex++.yy.cpp: $(SRC)/lex.ll
	$(LEX) -DLEXER_EXE -o $(BLD)/lex++.yy.cpp --header-file="$(BLD)/lex++.yy.hpp" src/lex.ll

# UTILITY
$(BLD)/fileio.o: $(SRC)/fileio.cpp
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o

# ABSTARCT
$(OBJ)/%.o: $(SRC)/%.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

$(OBJ)/%.o: $(SRC)/%.c
	$(CC) $(CFLAGS) -c $^ -o $@

$(BLD)/pcxx.cc $(BLD)/pcxx.hh: $(SRC)/parsercxx.yy
	$(YACC) -o $(BLD)/pcxx.cc $(SRC)/parsercxx.yy

$(BLD)/pcxx: $(BLD)/pcxx.cc
	$(CXX) -g -std=c++14 -I$(ROOT)/src -o $@ $<

# TEST
$(BLD)/TEST_lex: $(TST)/TEST_config.cpp $(TST)/TEST_lexer.cpp $(TST)/main.cpp $(BLD)/utility.o $(BLD)/fileio.o $(BLD)/streamy.o
	$(CXX) -DLEXER_EXE $(CXXFLAGS) $^ $(LDFLAGS) -o $@

# copy header files
$(BLD)/fileio.h $(BLD)/streamy.hpp: $(SRC)/fileio.h $(SRC)/streamy.hpp
	cp $^ $(BLD)/

# MAKE UTILTY
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
