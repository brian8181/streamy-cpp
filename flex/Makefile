BUILD=./build

all: poc1 streamy

poc1: poc1.yy.c
	gcc $(BUILD)/poc1.yy.c -ll -o $(BUILD)/poc1

poc1.yy.c:
	flex -o $(BUILD)/poc1.yy.c poc1.l

streamy: streamy.yy.c
	gcc $(BUILD)/streamy.yy.c -ll -o $(BUILD)/streamy

streamy.yy.c:
	flex -o $(BUILD)/streamy.yy.c streamy.l

.PHONY: clean
clean:
	-rm $(BUILD)/*