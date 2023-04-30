LEX = flex
YACC = bison
CC = gcc
CFLAGS = -Wall -g

all: main

main: main.c lex.yy.c parseur.tab.c
	$(CC) $(CFLAGS) -o $@ $^ -lfl -ll -lm

lex.yy.c: lexeur.l
	$(LEX) -o $@ $<

parseur.tab.c parseur.tab.h: parseur.y
	$(YACC) -d -o parseur.tab.c $<

clean:
	rm -f main lex.yy.c parseur.tab.c parseur.tab.h




























