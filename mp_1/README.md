Ce dossier contient les fichiers suivants :

- data : Ce fichier contient des données d'exemple qui peuvent être utilisées pour tester le programme.
- lexeur.l : Ce fichier contient l'analyseur lexical pour le parseur.
- lexeur.yy.c : Ce fichier est généré en exécutant le générateur d'analyseur lexical Flex sur lexeur.l.
- parseur.y : Ce fichier contient le parseur pour le programme.
- parseur.tab.c : Ce fichier est généré en exécutant le générateur de parseur Bison sur parseur.y.
- parseur.tab.h : Ce fichier est généré en exécutant le générateur de parseur Bison sur parseur.y.
- main.c : Ce fichier contient la logique principale du programme.
- main : Ce fichier est l'exécutable compilé du programme.



Voici la description de chaque ligne de code de Makefile :
- `LEX = flex` : Définit la variable `LEX` qui contient le nom du programme Flex.
- `YACC = bison` : Définit la variable `YACC` qui contient le nom du programme Bison.
- `CC = gcc` : Définit la variable `CC` qui contient le nom du compilateur C.
- `CFLAGS = -Wall -g` : Définit la variable `CFLAGS` qui contient les options de compilation à utiliser pour le compilateur C. Ici, les options `-Wall` et `-g` activent respectivement tous les avertissements de compilation et la génération d'informations de débogage.
- `all : main` : Définit la règle par défaut à exécuter lorsqu'on appelle `make`. Ici, la règle par défaut est `main`.
- `main : main.c lex.yy.c parseur.tab.c`: Définit une règle pour créer l'exécutable `main`. La règle spécifie que l'exécutable `main` dépend des fichiers `main.c`, `lexeur.l` (qui est compilé en `lex.yy.c`), et `parseur.y` (qui est compilé en `parseur.tab.c`).
- `$(CC) $(CFLAGS) -o $@ $^ -lfl -ll -lm` : Compile le code source pour créer l'exécutable `main`. Cette commande utilise les variables `CC` et `CFLAGS` pour spécifier le compilateur C et les options de compilation à utiliser. Les fichiers sources `main.c`, `lex.yy.c`, et `parseur.tab.c` sont liés ensemble pour créer l'exécutable `main`. Les options `-lfl`, `-ll`, et `-lm` spécifient les bibliothèques à utiliser lors de la compilation.
- `lex.yy.c: lexeur.l`: Définit une règle pour créer le fichier `lex.yy.c`. La règle spécifie que le fichier `lex.yy.c` dépend du fichier `lexeur.l`. Le programme Flex est utilisé pour compiler le fichier `lexeur.l` en `lex.yy.c`.
- `$(LEX) -o $@ $<` : Compile le fichier `lexeur.l` en `lex.yy.c`. Cette commande utilise la variable `LEX` pour spécifier le programme Flex à utiliser. Le fichier `lexeur.l` est compilé en `lex.yy.c`, qui est créé à l'aide de l'option `-o`.
- `parseur.tab.c parseur.tab.h: parseur.y`: Définit une règle pour créer les fichiers `parseur.tab.c` et `parseur.tab.h`. La règle spécifie que les fichiers `parseur.tab.c` et `parseur.tab.h` dépendent du fichier `parseur.y`. Le programme Bison est utilisé pour compiler le fichier `parseur.y` en `parseur.tab.c` et `parseur.tab.h`.
- `$(YACC) -d -o parseur.tab.c $<` : Compile le fichier `parseur.y` en `parseur.tab.c` et `parseur.tab.h`. Cette commande utilise la variable `YACC` pour spécifier le programme Bison à utiliser. Le fichier `parseur.y` est compilé en `parseur.tab.c` et `parseur.tab.h`, qui sont créés à l'aide de l'option `-o`. L'option `-d` est utilisée pour générer le fichier `parseur.tab.


Pour exécuter le programme, suivez ces étapes :
1. Installez Flex et Bison sur votre système si ce n'est pas déjà fait.
2. Compilez les fichiers source en exécutant le fichier Makefile avec la commande suivante :   make
3. Exécutez le programme en lançant le fichier main avec la commande suivante : ./main data
Ici, "data" est le nom du fichier d'entrée que vous voulez analyser.
Le fichier Makefile inclus dans ce dépôt compilera les fichiers source et les liera dans un exécutable nommé "main".
 
