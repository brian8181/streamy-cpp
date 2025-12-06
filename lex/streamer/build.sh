#!/bin/bash

flex -o build/tokenizer.yy.c src/tokenizer.l
gcc build/tokenizer.yy.c -o build/streamer
