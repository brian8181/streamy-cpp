# // License:    GPL
# // Author:     Brian K Preston
# // File Name:  Makefile
# // Build Date: Sun Nov 26 12:55:26 PM CST 2023
# // Version:    3.6.7

PREFIX = build
CXX = g++
CXXFLAGS = -g -Wall -DDEBUG -std=c++17
CC = gcc -g
LEX = flex
YACC = bison -d   
SRC = src
BLD = build
OBJ = build

all: libstreamy.so libstreamy.a streamy_lex streamy_lexer streamy_app bash_color_test

yacc_lex: streamy_lexer tokenizer

test:
	$(CXX) $(CXXFLAGS) -c $(SRC)/%.cpp

streamy.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

libstreamy.so: streamy.o
	$(CXX) $(CXXFLAGS) -fPIC --shared $(OBJ)/streamy.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

libstreamy.a: streamy.o
	ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

streamy_app: fileio.o streamy.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy_app.cpp -o $(OBJ)/streamy_app.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_app.o $(OBJ)/streamy.o $(OBJ)/fileio.o -o $(BLD)/streamy_app
	#$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_app.o $(BLD)/libstreamy.a $(OBJ)/fileio.o -o $(BLD)/streamy_app_a
	#$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_app.o -lstreamy -L$(PREFIX)/lib -o $(BLD)/streamy_app_so

streamy_lex: fileio.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy_lex.cpp -o $(OBJ)/streamy_lex.o
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(OBJ)/streamy.o -o $(BLD)/streamy_lex
	$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o $(BLD)/libstreamy.a -o $(BLD)/streamy_lex_a
	#$(CXX) $(CXXFLAGS) -fPIC $(OBJ)/streamy_lex.o $(OBJ)/fileio.o -lstreamy -L$(PREFIX)/lib -o $(BLD)/streamy_lex_so
	cp $(SRC)/streamy_lex.conf $(BLD)/streamy_lex.conf

streamy_lexer:
	$(LEX) -o $(BLD)/streamy.yy.c $(SRC)/streamy.l
	$(CXX) -g -DDEBUG -std=c++17 -c $(BLD)/streamy.yy.c -o $(BLD)/streamy_lexer.o
	$(CXX) -g -DDEBUG -std=c++17 $(OBJ)/streamy_lexer.o -ll -o $(BLD)/streamy_lexer

# app: main.o app.o streamy.o
# 	$(CXX) $(CXXFLAGS) $(OBJ)/app.o $(OBJ)/main.o $(OBJ)/streamy.o $(OBJ)/fileio.o -o $(BLD)/app

bash_color_test:
	$(CXX) $(CXXFLAGS) $(SRC)/bash_color_test.cpp -o $(BLD)/bash_color_test

main.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/main.cpp -o $(OBJ)/main.o

# app.o:
# 	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/app.cpp -o $(OBJ)/app.o

fileio.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/fileio.cpp -o $(BLD)/fileio.o	

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BLD)/tokenizer.yy.c -ll -o $(BLD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

test1:
	g++ -std=c++14 -Wall -I/usr/local/include $(SRC)/010-TestCase.cpp -o $(BLD)/test1 

020-TestCase:
	g++ -std=c++14 -fPIC -Wall -I/usr/local/include -c $(SRC)/020-TestCase-1.cpp -o $(BLD)/020-TestCase-1.o
	g++ -std=c++14 -fPIC -Wall -I/usr/local/include -c $(SRC)/020-TestCase-2.cpp -o $(BLD)/020-TestCase-2.o
	g++ -std=c++14 -Wall -I/usr/local/include -o $(BLD)/020-TestCase $(BLD)/020-TestCase-1.o $(SRC)/020-TestCase-2.cpp && $(BLD)/020-TestCase --success

# *.o: fileio.o libstreamy
# 	$(CXX) $(CXXFLAGS) $% -o $@
# 	echo $^
# 	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/$@

stream_app.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/app.cpp -o $(OBJ)/stream_app.o

streamy-cpp.o: streamy-cpp.yy.c
	$(CXX) $(CXXFLAGS) -c $(BUILD)/streamy-cpp.yy.c -o $(BUILD)/streamy-cpp.yy.o

streamy-cpp.yy.c:
	$(LEX) -o $(BUILD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

complie:
	g++ -c $(SRC)/*.cpp

install:
	cp -rf  $(BLD)/libstreamy.a $(PREFIX)/lib/libstreamy.a
	cp -rf  $(BLD)/libstreamy.so $(PREFIX)/lib/libstreamy.so
	chmod 755  $(PREFIX)/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

uninstall:
	rm -rf /usr/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

clean:
	-rm $(BLD)/*

clean_src:
	-rm ./*.o