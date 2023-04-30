LEX = flex
YACC = bison
CC = gcc
CFLAGS = -Wall -g

all: main

main: main.c lex.yy.c sql.tab.c
	$(CC) $(CFLAGS) -o $@ $^ -lfl -ll -lm

lex.yy.c: sql.l
	$(LEX) -o $@ $<

sql.tab.c sql.tab.h: sql.y
	$(YACC) -d -o sql.tab.c $<

clean:
	rm -f main lex.yy.c sql.tab.c sql.tab.h




























