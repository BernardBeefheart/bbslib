# ======================================================================
# Makefile 
# for tst-sl-printf
# ======================================================================
#

SOURCES = println.scm format/format-char.scm format/format-int.scm format/format-string.scm  slprintf.scm
MAIN = test.scm
EXE = test
CSCFLAGS = -include-path ../match -include-path ../../match -L../match -L../../match

format/%.so: format/%.scm
	$(CSC) -sJ -o $@ $<

include ../mk/chicken-r7rs.mk
