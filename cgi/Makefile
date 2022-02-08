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
BUILDDIR = $(ROOTDIR)/cgi
SRCDIR = $(ROOTDIR)/cgi
OBJDIR = $(ROOTDIR)/cgi

# compile & link for debug
debug: CXXFLAGS += -DDEBUG -g
debug: all

# compile & link for debug GDBversion variable
debuggdb: CXXFLAGS += -DDEBUG -ggdb # compile & link

everything: all dump_get.o dump_fread.o dump_ifstream.o
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/main.o -o $(BUILDDIR)/main.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump_ifstream.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump_ifstream.cgi

all: utility.o get.o sed.o find_tags.o load_conf.o dump.o 
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/get.o -o $(BUILDDIR)/get.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/sed.o -o $(BUILDDIR)/sed.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/find_tags.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/find_tags.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/load_conf.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/load_conf.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump.cgi
	
main.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/main.cpp -o $(BUILDDIR)/main.o

get.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/get.cpp -o $(BUILDDIR)/get.o

sed.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/sed.cpp -o $(BUILDDIR)/sed.o

load_conf.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/load_conf.cpp -o $(BUILDDIR)/load_conf.o

dump_ifstream.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/dump_ifstream.cpp -o $(BUILDDIR)/dump_ifstream.o

dump.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/dump.cpp -o $(BUILDDIR)/dump.o

dump_fread.o:
	$(CXX) $(CXXFLAGS) -c$(SRCDIR)/dump_fread.cpp -o $(BUILDDIR)/dump_fread.o


find_tags.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/find_tags.cpp -o $(BUILDDIR)/find_tags.o

utility.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/utility.cpp -o $(BUILDDIR)/utility.o

upload:
	cp *.cgi /var/www/html/cgi

.PHONY: clean
clean:
	rm *.cgi *.o