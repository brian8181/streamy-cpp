# CHANGE DATE: 
# Tue Oct  3 07:03:38 AM CDT 2023
# RTFM (Read the fucking manual)

CXX = g++
CXXFLAGS = -std=c++11 -DDEBUG -ggdb
CC       = gcc -g
LEX      = flex -i -I 
YACC     = bison -d   

# cppunit not used ! remove ?
LDFLAGS = -static -lcppunit -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/

APPNAME = streamy
BUILD = ./build
SRC = ./src
OBJ = ./build

#all:: $(APPNAME) 
all:: stream_app
all:: streamy-cpp

$(APPNAME): main.o streamy.o streamy.yy.c 
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/streamy.o -ll -o $(BUILD)/streamy

$(APPNAME).yy.c:
	flex -o $(BUILD)/$(APPNAME).yy.c $(SRC)/$(APPNAME).l

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

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(OBJ)/tokenizer.yy.o -ll -o $(BUILD)/tokenizer

tokenizer.yy.c:
	flex -o $(BUILD)/tokinzer.yy.c $(SRC)/tokinzer.l

y.tab.c y.tab.h:
	$(YACC) $(SRC)/streamy-cpp.y
	mv ./streamy-cpp.tab.* $(BUILD)/.

.PHONY: clean
clean:
	-rm $(BUILD)/*