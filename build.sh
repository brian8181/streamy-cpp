pushd build
g++ -c parser.tab.c -o tab.o
g++ -DLEXER_EXE -c lex_parse.yy.c -o lex.o
g++ -DLEXER_EXE tab.o lex.o -o pr
