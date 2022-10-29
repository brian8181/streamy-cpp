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
ROOTDIR  = ..
BUILDDIR = .
SRCDIR = $(ROOTDIR)/src
OBJDIR = .

debug: CXXFLAGS += -DDEBUG -ggdb

all: streamy.a streamy.so

streamy.so: streamy.o
	$(CXX) $(CXXFLAGS) --shared $(BUILDDIR)/streamy.o -o $(BUILDDIR)/streamy.so

streamy.a: streamy.o
	ar rvs streamy.a streamy.o

streamy.o:
	$(CXX) $(CXXFLAGS) -c $(SRCDIR)/streamy.$(EXT) -o $(BUILDDIR)/streamy.o	

# install man pages
.PHONY: man$(APPNAME)_test
man:
	cp ../man/$(APPNAME).1 $(man1dir)
	# gzip $(man1dir)/$(APPNAME).1
	mandb

.PHONY: unman
unman:
	rm $(man1dir)/$(APPNAME).1.gz
	mandb

# delete object files & app executable
.PHONY: clean
clean:
	-rm -f $(BUILDDIR)/streamy.[ao];\
	
# delete all auto generated files
.PHONY: distclean
distclean: clean
	rm -f $(SRCDIR)/config.* $(SRCDIR)/Makefile $(SRCDIR)/Makefile.in $(SRCDIR)/INSTALL $(SRCDIR)/configure 
	#rm ../stamp-h1 ../aclocal.m4 ../compile ../install-sh ../libtool ../ltmain.sh ../stamp-h1 ../missing ../depcomp
	#rm ../src/Makefile ../src/Makefile.in
	#rm -rf ../autom4te.cache ../src/.deps ../src/.libs
	#rm ../src/.o
