LEX = flex
YACC = bison
CC = gcc
CFLAGS = -Wall -g
LIBS = -lfl -ll -lm

all: main

main: parseur.tab.c lex.yy.c main.c
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

lex.yy.c: lexeur.l
	$(LEX) -o $@ $<

parseur.tab.c parseur.tab.h: parseur.y
	$(YACC) -d -o parseur.tab.c $<

clean:
	rm -f main lex.yy.c parseur.tab.c parseur.tab.h