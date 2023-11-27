# streamy-cpp make
# Fri Sep 29 11:01:50 AM CDT 2023
# Version 0.0.1

LEX = flex
YACC = bison
SRC=./yacc
OBJ=./build
BLD=./build

all: fb1-4.yy.c

fb1-4.yy.c:
	$(LEX) -o build/fb1-4.yy.c fb1-4.l

clean:
	-rm -rf $(BLD)/*