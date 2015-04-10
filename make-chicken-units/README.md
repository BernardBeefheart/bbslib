make-chicken-units
==================

This utility is written for _Chicken Scheme_. It transform a standard scheme source file in a _Chicken Scheme_ unit by adding a line at the beginning of the file :

	(declare (unit unit-name))

You can compile it with:

	make clean all

You can use it like that:

	./make-chicken-units source-file unit-name output-file

You can get (little) help with:

	./make-chicken-units [--help]

Notes
-----

Porting this code on other Scheme implementations is possible with some work on handling exceptions and ML like matches for the command line.

This utility could be done with a simple shell script, but I wanted to play with a few concepts in Chicken Scheme.

