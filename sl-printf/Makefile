# ======================================================================
# Makefile 
# for tst-sl-printf
# ======================================================================
#

CSC = csc -debug-level 0 -verbose -require-extension r7rs  -I.


SOURCES = println.scm sl-printf.scm 
MAIN = tst-sl-printf.scm
EXE = tst-sl-printf

OBJS = $(patsubst %.scm,%.so,$(notdir $(SOURCES)))
IMPORTSSCM = $(patsubst %.scm,%.import.scm,$(notdir $(SOURCES)))
all: $(EXE)

$(EXE): $(OBJS) $(MAIN)
	$(CSC) -o $@ $(MAIN)

%.so: %.scm
	$(CSC) -sJ -o $@ $<


clean: 
	rm -fv $(OBJS) $(EXE) $(IMPORTSSCM) 

.PHONY: all clean


