#mk

Here, you will find a set of files which are included in others _Makefiles_.

##chicken-config.mk

Chicken compiler configuration. See _make-chicken-units/Makefile_.

##chicken-appmaker.mk

Rules to compile an application. See _make-chicken-units/Makefile_.

##chicken-r7rs.mk

Rules to complie a R7RS application. Before including this file, you must declare three variables :

* __SOURCES__ : a list of all library sources, the order is important, when a lib is needed by another, place it in first,
* __MAIN__ : the main program source,
* __EXE__ : the name of the output executable.

Here is an exemple :

	SOURCES = println.scm slprintf.scm 
	MAIN = tst-sl-printf.scm
	EXE = tst-sl-printf

	include ../mk/chicken-r7rs-config.mk
