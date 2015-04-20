# ======================================================================
# chicken-r7rs.mk
# for tst-sl-printf
# ======================================================================
# Usage:
#
# SOURCES = println.scm slprintf.scm 
# MAIN = tst-sl-printf.scm
# EXE = tst-sl-printf
# 
# include ../mk/chicken-r7rs.mk
# ======================================================================

CSC = csc -debug-level 0 -verbose -X r7rs -require-extension r7rs -include-path . $(CSCFLAGS)

OBJS = $(patsubst %.scm,%.so,$(SOURCES))
IMPORTSSCM = $(patsubst %.scm,%.import.scm,$(SOURCES))

all: $(EXE)

$(EXE): $(OBJS) $(MAIN)
	$(CSC) -o $@ $(MAIN)

%.so: %.scm
	$(CSC) -sJ -o $@ $<


clean: 
	rm -fv $(OBJS) $(EXE) $(IMPORTSSCM) 

.PHONY: all clean


