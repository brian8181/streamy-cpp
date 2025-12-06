CC=gcc
LEX=flex
BLD=build
SRC=src

all: $(BLD)/streamer $(BLD)/test $(BLD)/simple $(BLD)/reject $(BLD)/esc_only

$(BLD)/streamer: $(BLD)/tokenizer.yy.c
	$(CC) $(BLD)/tokenizer.yy.c -o $(BLD)/streamer

$(BLD)/tokenizer.yy.c: $(SRC)/tokenizer.l
	$(LEX) -o $(BLD)/tokenizer.yy.c $(SRC)/tokenizer.l

$(BLD)/test: $(BLD)/test.yy.c
	$(CC) $(BLD)/test.yy.c -o $(BLD)/test

$(BLD)/test.yy.c: $(SRC)/test.l
	$(LEX) -o $(BLD)/test.yy.c $(SRC)/test.l

$(BLD)/simple: $(BLD)/simple.yy.c
	$(CC) $(BLD)/simple.yy.c -o $(BLD)/simple

$(BLD)/simple.yy.c: $(SRC)/simple.l
	$(LEX) -o $(BLD)/simple.yy.c $(SRC)/simple.l

$(BLD)/reject: $(BLD)/reject.yy.c
	$(CC) $(BLD)/reject.yy.c -o $(BLD)/reject

$(BLD)/reject.yy.c: $(SRC)/reject.l
	$(LEX) -o $(BLD)/reject.yy.c $(SRC)/reject.l

$(BLD)/esc_only: $(BLD)/esc_only.yy.c
	$(CC) $(BLD)/esc_only.yy.c -o $(BLD)/esc_only

$(BLD)/esc_only.yy.c: $(SRC)/esc_only.l
	$(LEX) -o $(BLD)/esc_only.yy.c $(SRC)/esc_only.l

.PHONY: clean
clean:
	rm build/*
