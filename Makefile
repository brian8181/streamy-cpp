# CHANGE DATE: 
# Mon Oct  2 05:06:26 PM CDT 2023

# Compiler settings - Can be customized.
CXX = g++
CXXFLAGS = -std=c++11 -DDEBUG -ggdb
CC       = gcc -g
LEX      = flex -i -I 
YACC     = bison -d

# lib settings
LDFLAGS = -static -lcppunit -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/

# Makefile settings - Can be customized.
APPNAME = streamy
BUILD = ./build
SRC = ./src
OBJ = ./build

#all:: $(APPNAME) 
all:: stream_app
all:: streamy-cpp

$(APPNAME): main.o streamy.o streamy.yy.c 
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/streamy.o -ll -o $(BUILD)/streamy

$(APPNAME).so: $(APPNAME).o
	$(CXX) $(CXXFLAGS) --shared $(OBJ)/$(APPNAME).o -o $(BUILD)/$(APPNAME).so

$(APPNAME).a: $(APPNAME).o
	ar rvs $(BUILD)/$(APPNAME).a $(OBJ)/$(APPNAME).o

$(APPNAME).o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/$(APPNAME).cpp -o $(OBJ)/$(APPNAME).o	

main.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o

stream_app: main.o stream_app.o
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/stream_app.o -o $(BUILD)/stream_app

stream_app.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/app.cpp -o $(OBJ)/stream_app.o

streamy-cpp: streamy-cpp.o
	$(CXX) $(CXXFLAGS) $(OBJ)/streamy-cpp.yy.o -ll -o $(BUILD)/streamy-cpp

streamy-cpp.o: streamy-cpp.yy.c
	$(CXX) $(CXXFLAGS) -c $(BUILD)/streamy-cpp.yy.c -o $(BUILD)/streamy-cpp.yy.o

streamy-cpp.yy.c:
	flex -o $(BUILD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

$(APPNAME).yy.c:
	flex -o $(BUILD)/$(APPNAME).yy.c $(SRC)/$(APPNAME).l

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(OBJ)/tokenizer.yy.o -ll -o $(BUILD)/tokenizer

tokenizer.yy.c:
	flex -o $(BUILD)/tokinzer.yy.c $(SRC)/tokinzer.l

# streamy.yy.c:
# 	flex -o $(BUILD)/streamy.yy.c streamy.l

y.tab.c y.tab.h:
	$(YACC) $(SRC)/streamy-cpp.y
	mv ./streamy-cpp.tab.* $(BUILD)/.

$(APPNAME).yy.c: