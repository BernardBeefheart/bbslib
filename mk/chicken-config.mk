# ======================================================================
# chicken-config.mk
# ======================================================================

CSC = csc -c -debug-level 0 -verbose -extend r7rs -require-extension r7rs -I.
CSLD = csc

%.o: %.scm
	$(CSC) $<

