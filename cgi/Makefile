# cgi scripts

all: main.o get.o sed.o
	g++ main.o -o main.cgi
	g++ get.o -o get.cgi
	g++ sed.o -o sed.cgi
	g++ find_tags.cpp utility.cpp -o find_tags.cgi
	g++ load_conf.cpp utility.cpp -o load_conf.cgi

utility.o:
	g++ -c utility.cpp -o utility.o

main.o:
	g++ -c main.cpp -o main.o

get.o:
	g++ -c get.cpp -o get.o

sed.o:
	g++ -c sed.cpp -o sed.o

upload:
	cp *.cgi /var/www/html/cgi

.PHONY: clean
clean:
	rm *.cgi *.o