# MAKE TEMPLATE 06-02-2020 1
# MAKE TEMPLATE 03-11-2021 1.1
# MAKE TEMPLATE 05-22-2021 1.2
# MAKE TEMPLATE 07-07-2021 1.3

# RUN BEFORE autoreconf -ivfm
# RUN BEFORE autoreconf -i

MAKE_TEMPLATE = 1.3;
BUILD_VERSION = 0.1.0

prefix = /usr/local
prefix = /usr/local
mandir = $(prefix)/share/man
man1dir = $(mandir)/man1

# Compiler settings - Can be customized.
CXX = g++
CXXFLAGS = -Wall -std=c++11 -std=gnu++17 -fPIC
# lib settings
LDFLAGS = -static -lcppunit -L/usr/local/lib/
INCLUDES = -I/usr/local/include/cppunit/

# Makefile settings - Can be customized.
APPNAME = streamycpp
EXT = cpp
ROOTDIR  = .
BUILDDIR = ./build
SRCDIR = $(ROOTDIR)/src
OBJDIR = ./build

debug: CXXFLAGS += -DDEBUG -ggdb

all: streamy

steamy: streamy.o
	$(CXX) $(CXXFLAGS) $(SRCDIR)/streamy.cpp -o $(BUILDDIR)/streamy

streamy.so: streamy.o
	$(CXX) $(CXXFLAGS) --shared $(BUILDDIR)/streamy.o -o $(BUILDDIR)/streamy.so

streamy.a: streamy.o
	ar rvs streamy.a $(BUILDDIR)\streamy.o

streamy.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/streamy.cpp -o $(BUILDDIR)/streamy.o	

# delete object files & app executable
.PHONY: clean
clean:
	-rm ./build/*	
