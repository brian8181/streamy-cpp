# Sun Oct  1 07:32:29 PM CDT 2023

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
all:: stream_app.o
#all:: streamy-cpp
all:: y.tab.c
all:: $(APPNAME).so $(APPNAME).a 

stream_app: main.o stream_app.o
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/stream_app.o -o $(BUILD)/stream_app

main.o: stream_app.o
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/main.o

stream_app.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/app.cpp -o $(OBJ)/stream_app.o

$(APPNAME): main.o streamy.o streamy.yy.c 
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/streamy.o -o $(BUILD)/streamy

$(APPNAME).so: $(APPNAME).o
	$(CXX) $(CXXFLAGS) --shared $(OBJ)/$(APPNAME).o -o $(BUILD)/$(APPNAME).so

$(APPNAME).a: $(APPNAME).o
	ar rvs $(BUILD)/$(APPNAME).a $(OBJ)/$(APPNAME).o

$(APPNAME).o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/$(APPNAME).cpp -o $(OBJ)/$(APPNAME).o	

streamy-cpp: streamy-cpp.yy.c
	$(CXX) $(BUILD)/streamy-cpp.yy.c -o $(BUILD)/streamy-cpp

streamy-cpp.yy.c:
	flex -o $(BUILD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

$(APPNAME).yy.c:
	flex -o $(BUILD)/$(APPNAME).yy.c $(SRC)/$(APPNAME).l

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

y.tab.c y.tab.h:
	$(YACC) $(SRC)/streamy-cpp.y
	mv ./streamy-cpp.tab.* $(BUILD)/.

# delete object files & app executable
.PHONY: clean
clean:
	-rm ./build/*	
