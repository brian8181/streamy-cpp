# cgi scripts

# Compiler settings - Can be customized.
CXX = g++
CXXFLAGS = -Wall -std=c++17

# lib settings
LDFLAGS = -static -lcppunit -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/
# add addtional libs here

# Makefile settings - Can be customized.
APPNAME = smartycpp
EXT = cpp
ROOTDIR  = ..
BUILDDIR = .
SRCDIR = $(ROOTDIR)/src
OBJDIR = .

# compile & link for debug
debug: CXXFLAGS += -DDEBUG -g
debug: all

# compile & link for debug GDBversion variable
debuggdb: CXXFLAGS += -DDEBUG -ggdb # compile & link

all: main.o utility.o get.o sed.o find_tags.o load_conf.o dump.o dump_ifstream.o 
	$(CXX) $(CXXFLAGS) main.o -o main.cgi
	$(CXX) $(CXXFLAGS) get.o -o get.cgi
	$(CXX) $(CXXFLAGS) sed.o -o sed.cgi
	$(CXX) $(CXXFLAGS) find_tags.o utility.o -o find_tags.cgi
	$(CXX) $(CXXFLAGS) load_conf.o utility.o -o load_conf.cgi
	$(CXX) $(CXXFLAGS) dump.o utility.o -o dump.cgi
	$(CXX) $(CXXFLAGS) dump_ifstream.o utility.o -o dump_ifstream.cgi

main.o:
	$(CXX) $(CXXFLAGS) -c main.cpp -o main.o

get.o:
	$(CXX) $(CXXFLAGS) -c get.cpp -o get.o

sed.o:
	$(CXX) $(CXXFLAGS) -c sed.cpp -o sed.o

load_conf.o:
	$(CXX) $(CXXFLAGS) -c load_conf.cpp -o load_conf.o

dump_ifstream.o:
	$(CXX) $(CXXFLAGS) -c dump_ifstream.cpp -o dump_ifstream.o

dump.o:
	$(CXX) $(CXXFLAGS) -c dump.cpp -o dump.o

find_tags.o:
	$(CXX) $(CXXFLAGS) -c find_tags.cpp -o find_tags.o

utility.o:
	$(CXX) $(CXXFLAGS) -c utility.cpp -o utility.o

upload:
	cp *.cgi /var/www/html/cgi

.PHONY: clean
clean:
	rm *.cgi *.o