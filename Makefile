# CHANGE DATE: 
# Tue Oct  3 07:03:38 AM CDT 2023
# Tue Oct 24 08:40:27 AM CDT 2023
# Thu Nov 16 06:31:21 PM CST 2023
# Mon Nov 20 09:38:52 AM CST 2023

PREFIX = build
CXX = g++
<<<<<<< HEAD
CXXFLAGS = -g -Wall -DDEBUG -std=c++17
=======
CXXFLAGS = -std=c++11 -DDEBUG -ggdb
CC       = gcc -g
#LEX      = flex -i -I 
>>>>>>> step_one_lexer
LEX      = flex
YACC     = bison -d   

APPNAME = streamy
SRC = src
BLD = build
OBJ = build

all: libstreamy.so libstreamy.a streamy_lex streamy_app app bash_color_test

<<<<<<< HEAD
yacc_lex: streamy_lexer tokenizer
=======

test:
	$(CXX) $(CXXFLAGS) -c $(SRC)/%.cpp

$(APPNAME): app.o main.o streamy.o streamy.yy.c 
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/streamy.o -o $(BUILD)/streamy
>>>>>>> step_one_lexer

streamy.o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRC)/streamy.cpp -o $(OBJ)/streamy.o

libstreamy.so: streamy.o
	$(CXX) $(CXXFLAGS) -fPIC --shared $(OBJ)/streamy.o -o $(BLD)/libstreamy.so
	chmod 755 $(BLD)/libstreamy.so

libstreamy.a: streamy.o
	ar rvs $(BLD)/libstreamy.a $(OBJ)/streamy.o
	chmod 755 $(BLD)/libstreamy.a

streamy_app: fileio.o streamy.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC -c $(SRC)/streamy_app.cpp -o $(OBJ)/streamy_app.o
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_app.o $(OBJ)/streamy.o $(OBJ)/fileio.o -o $(BLD)/streamy_app
#$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_app.o $(BLD)/libstreamy.a $(OBJ)/fileio.o -o $(BLD)/streamy_app_a
#$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_app.o -lstreamy -L$(PREFIX)/lib -o $(BLD)/streamy_app_so

streamy_lex: fileio.o libstreamy.a libstreamy.so
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC -c $(SRC)/streamy_lex.cpp -o $(OBJ)/streamy_lex.o
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_lex.o $(OBJ)/streamy.o $(OBJ)/fileio.o -o $(BLD)/streamy_lex
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_lex.o $(BLD)/libstreamy.a $(OBJ)/fileio.o -o $(BLD)/streamy_lex_a
#$(CXX) $(CXXFLAGS) -std=c++17 -fPIC $(OBJ)/streamy_lex.o -lstreamy -L$(PREFIX)/lib $(OBJ)/fileio.o -o $(BLD)/streamy_lex_so

streamy_lexer:
	$(LEX) -o $(BLD)/streamy.yy.c $(SRC)/streamy.l
	$(CXX) $(CXXFLAGS) -c $(BLD)/streamy.yy.c -o $(BLD)/streamy_lexer.o
	$(CXX) $(CXXFLAGS) $(OBJ)/streamy_lexer.o -ll -o $(BLD)/streamy_lexer

app: main.o app.o streamy.o
	$(CXX) $(CXXFLAGS) $(OBJ)/app.o $(OBJ)/main.o $(OBJ)/streamy.o $(OBJ)/fileio.o -o $(BLD)/app

bash_color_test:
	$(CXX) $(CXXFLAGS) -std=c++17 $(SRC)/bash_color_test.cpp -o $(BLD)/bash_color_test

main.o:
<<<<<<< HEAD
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC -c $(SRC)/main.cpp -o $(OBJ)/main.o

app.o:
	$(CXX) $(CXXFLAGS) -std=c++17 -fPIC -c $(SRC)/app.cpp -o $(OBJ)/app.o

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

*.o: fileio.o libstreamy
	$(CXX) $(CXXFLAGS) $% -o $@
	echo $^
=======
	$(CXX) $(CXXFLAGS) -c $(SRC)/main.cpp -o $(OBJ)/$@

$(APPNAME).yy.c:
	$(LEX) -o $(BUILD)/$(APPNAME).yy.c $(SRC)/$(APPNAME).l

$(APPNAME).so: $(APPNAME).o
	$(CXX) $(CXXFLAGS) --shared $(OBJ)/$(APPNAME).o -o $(BUILD)/$(APPNAME).so

$(APPNAME).a: $(APPNAME).o
	ar rvs $(BUILD)/$(APPNAME).a $(OBJ)/$(APPNAME).o

stream_app: main.o stream_app.o
	$(CXX) $(CXXFLAGS) $(OBJ)/main.o $(OBJ)/$@.o -o $(BUILD)/$@

stream_app.o:
	$(CXX) $(CXXFLAGS) -c $(SRC)/app.cpp -o $(OBJ)/stream_app.o

streamy-cpp: streamy-cpp.o
	$(CXX) $(CXXFLAGS) $(OBJ)/streamy-cpp.yy.o -o $(BUILD)/streamy-cpp

streamy-cpp.o: streamy-cpp.yy.c
	$(CXX) $(CXXFLAGS) -c $(BUILD)/streamy-cpp.yy.c -o $(BUILD)/streamy-cpp.yy.o

streamy-cpp.yy.c:
	$(LEX) -o $(BUILD)/streamy-cpp.yy.c $(SRC)/streamy-cpp.l

bison_incl_skel:
	$(YACC) $(SRC)/bison_incl_skel.y

tokenizer: tokenizer.yy.c
	$(CXX) $(CXXFLAGS) $(BUILD)/tokenizer.yy.c -o $(BUILD)/tokenizer

tokenizer.yy.c:
	$(LEX) -o $(BUILD)/tokenizer.yy.c $(SRC)/tokenizer.l
>>>>>>> step_one_lexer

y.tab.c y.tab.h:
	$(YACC) $(SRC)/streamy-cpp.y
	mv ./streamy-cpp.tab.* $(BLD)/.

install:
	cp -rf  $(BLD)/libstreamy.a $(PREFIX)/lib/libstreamy.a
	cp -rf  $(BLD)/libstreamy.so $(PREFIX)/lib/libstreamy.so
	chmod 755  $(PREFIX)/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

uninstall:
	rm -rf /usr/lib/libstreamy.a $(PREFIX)/lib/libstreamy.so

clean:
	-rm $(BLD)/*