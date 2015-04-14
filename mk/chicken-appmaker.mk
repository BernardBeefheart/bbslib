# ======================================================================
# chicken-appmaker.mk
# ======================================================================

OBJS = $(patsubst %.scm,%.o,$(notdir $(SOURCES)))
CSRCS = $(patsubst %.scm,%.c,$(notdir $(SOURCES)))


all: $(EXE)

$(EXE): $(OBJS) 
	$(CSLD) $(OBJS) -o $@

clean: 
	rm -fv $(OBJS) $(EXE) $(CSRCS)

.PHONY: all clean


