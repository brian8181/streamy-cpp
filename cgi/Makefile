# cgi scripts

# Compiler settings - Can be customized.
CXX = g++
CXXFLAGS = -std=c++17 -DDEBUG -g

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
debug: 
	#$(CXXFLAGS) += -DDEBUG -g
debug: all

# compile & link for debug GDBversion variable
debuggdb: 
	#$(CXXFLAGS) += -DDEBUG -ggdb # compile & link

world: all main.o dump_get.o dump_matches.o
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/main.o -o $(BUILDDIR)/main.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump_get.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump_get.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump_matches.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump_matches.cgi
	
all: utility.o get.o sed.o find_tags.o load_conf.o dump.o smartypp.o
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/get.o -o $(BUILDDIR)/get.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/sed.o -o $(BUILDDIR)/sed.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/find_tags.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/find_tags.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/load_conf.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/load_conf.cgi
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/dump.o $(BUILDDIR)/utility.o -o $(BUILDDIR)/dump.cgi

smartypp.o:
	$(CXX) $(CXXFLAGS) -c ../src/smartypp.cpp -o ../src/smartypp.o

main.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/main.cpp -o $(BUILDDIR)/main.o

get.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/get.cpp -o $(BUILDDIR)/get.o

sed.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/sed.cpp -o $(BUILDDIR)/sed.o

load_conf.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/load_conf.cpp -o $(BUILDDIR)/load_conf.o

dump.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/dump.cpp -o $(BUILDDIR)/dump.o

dump_get.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/dump_get.cpp -o $(BUILDDIR)/dump_get.o

dump_matches.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/dump_matches.cpp -o $(BUILDDIR)/dump_matches.o

find_tags.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/find_tags.cpp -o $(BUILDDIR)/find_tags.o

utility.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/utility.cpp -o $(BUILDDIR)/utility.o

upload:
	cp *.cgi /var/www/html/cgi

.PHONY: clean
clean:
	rm *.cgi *.o