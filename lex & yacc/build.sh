#!/bin/bash

mkdir -p build
flex -o build/fb1-4.yy.c fb1-4.l
#gcc fb1-4.yy.c -lfl