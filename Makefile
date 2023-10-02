# Sun Oct  1 07:32:29 PM CDT 2023

# Compiler settings - Can be customized.
CXX = g++
CXXFLAGS = -std=c++11
CC       = gcc -g
LEX      = flex -i -I 
YACC     = bison -d -y

# lib settings
LDFLAGS = -static -lcppunit -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/

# Makefile settings - Can be customized.
APPNAME = streamy
EXT = cpp
ROOTDIR  = .
BUILDDIR = ./build
SRCDIR = ./src
OBJDIR = ./build

#debug: CXXFLAGS += -DDEBUG -ggdb

all: $(APPNAME) $(APPNAME).so $(APPNAME).a streamy-cpp

$(APPNAME): streamy.o streamy.yy.c 
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/main.cpp -o $(BUILDDIR)/main.o	
	$(CXX) $(CXXFLAGS) $(BUILDDIR)/main.o $(BUILDDIR)/streamy.o -o $(BUILDDIR)/streamy

$(APPNAME).so: $(APPNAME).o
	$(CXX) $(CXXFLAGS) --shared $(BUILDDIR)/$(APPNAME).o -o $(BUILDDIR)/$(APPNAME).so

$(APPNAME).a: $(APPNAME).o
	ar rvs $(BUILDDIR)/$(APPNAME).a $(BUILDDIR)/$(APPNAME).o

$(APPNAME).o:
	$(CXX) $(CXXFLAGS) -fPIC -c $(SRCDIR)/$(APPNAME).cpp -o $(BUILDDIR)/$(APPNAME).o	

streamy-cpp: streamy-cpp.yy.c
	gcc $(BUILDDIR)/streamy-cpp.yy.c -ll -o $(BUILDDIR)/streamy-cpp

streamy-cpp.yy.c:
	flex -o $(BUILDDIR)/streamy-cpp.yy.c $(SRCDIR)/streamy-cpp.l

$(APPNAME).yy.c:
	flex -o $(BUILDDIR)/$(APPNAME).yy.c $(SRCDIR)/$(APPNAME).l

bison_incl_skel:
	$(YACC) $(SRCDIR)/bison_incl_skel.y

# delete object files & app executable
.PHONY: clean
clean:
	-rm ./build/*	
