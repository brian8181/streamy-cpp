# This Makefile is designed to be simple and readable.  It does not
# aim at portability.  It requires GNU Make.

BISON = bison
CXX = g++
CXXFLAGS =
PROGS = parser2 parser3

parser2: CXXFLAGS = -std=c++14
parser3: CXXFLAGS = -std=c++11

all: $(PROGS)



parser2.cc parser2.hh parser2.html parser2.gv: parser2.yy
	$(BISON) $(BISONFLAGS) --html --graph -o $*.cc $<

parser2: parser2.cc
	$(CXX) $(CXXFLAGS) -o$@ $<

%.cc %.hh %.html %.gv: %.yy
	$(BISON) $(BISONFLAGS) --html --graph -o $*.cc $<

%: %.cc
	$(CXX) $(CXXFLAGS) -o$@ $<

clean:
	rm -f $(PROGS:=.cc) $(PROGS)
