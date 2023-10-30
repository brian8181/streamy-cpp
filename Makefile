# CHANGE DATE: 
# Tue Oct  3 07:03:38 AM CDT 2023
# Tue Oct 24 08:40:27 AM CDT 2023

CXX = g++
CXXFLAGS = -g -std=c++11 -DDEBUG
CCFLAGS  = -g
CC       = gcc $(CCFLAGS)
#LEX      = flex -i -I 
LEX      = flex
YACC     = bison -d   

# cppunit not used ! remove ?
LDFLAGS = -static -lcppunit -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/

APPNAME = streamy
SRC = src
BLD = build
OBJ = build

all: streamy streamy.so streamy.a stream_app streamy-cpp tokenizer

streamy: app.o main.o streamy.o
	$(CXX) $(CXXFLAGS) $(OBJ)/app.o $(OBJ)/main.o $(OBJ)/streamy.o -o $(BLD)/streamy

streamy.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/$(APPNAME).cpp -o $(OBJ)/$(APPNAME).o

app.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/app.cpp -o $(OBJ)/app.o

main.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o

streamy.yy.c:
	$(LEX) -o $(BLD)/$(APPNAME).yy.c $(SRC)/$(APPNAME).l

streamy.so: streamy.o
	$(CXX) $(CXXFLAGS) --shared $(OBJ)/$(APPNAME).o -o $(BLD)/$(APPNAME).so

streamy.a: streamy.o
	ar rvs $(BLD)/$(APPNAME).a $(OBJ)/$(APPNAME).o

stream_app: main.o stream_app.o
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/stream_app.o -o $(BLD)/stream_app

stream_app.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/app.cpp -o $(OBJ)/stream_app.o

streamy-cpp: streamy-cpp.o
	$(CXX) $(CXXFLAGS) $(OBJ)/streamy-cpp.yy.o -ll -o $(BLD)/streamy-cpp

streamy-cpp.o: streamy-cpp.yy.c
	$(CXX) $(CXXFLAGS) -c $(BLD)/streamy-cpp.yy.c -o $(BLD)/streamy-cpp.yy.o

streamy-cpp.yy.c:
	$(LEX) -o $(BLD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

bison_incl_skel:"../../streamy-cpp/src/streamy.hpp"
	$(YACC) $(SRC)/bison_incl_skel.y

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

y.tab.c y.tab.h:
	$(YACC) $(SRC)/streamy-cpp.y
	mv ./streamy-cpp.tab.* $(BLD)/.

.PHONY: clean
clean:
	-rm $(BLD)/*