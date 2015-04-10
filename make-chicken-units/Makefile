# ======================================================================
# Makefile 
# for make-chicken-units
# ======================================================================
#

CSC = csc -c -debug-level 0 -verbose -compile-syntax
CSLD = csc

SOURCES = make-chicken-units.scm application.scm 

OBJS = $(patsubst %.scm,%.o,$(notdir $(SOURCES)))
# OBJS = $(addprefix $(ODIR)/, $(_OBJS))

EXE = make-chicken-units

all: $(EXE)

$(EXE): $(OBJS) 
	$(CSLD) $(OBJS) -o $@

%.o: %.scm
	$(CSC) $<

clean: 
	rm -fv $(OBJS) $(EXE)

.PHONY: all clean


