sl-printf
=========

This printf was done to get formatted output as in C. Written for R7RS.

documentation
-------------

_sl-printf_ gives two libraries :
* _println_, which print a list of items followed by a new line,
* _slprintf_, wich gives a (little) subset of the C _printf_.

Here is an exemple :

	(println "Hello" " - " '(1 2 3) " world") => "Hello - 1 2 3 world"
	(slprintf "%3d -> 0x%02x\n" 128 128) => "128 0x80"

### println

__Usage__ :

	(import (println))

	(println arg1 arg2 ...)

__Result__ : prints each _argn_ one by one, without separation, ending with a newline.

### slprintf

__Usage__ :

	(import (slprintf))

	(slprintf format arg1 arg2 ...)

__Result__ : prints each _argn_ according to the fromat string. This string accepts the following syntax :

* %% : the \#\\% character,
* %s : consider the corresponding argument as a string,
* %c : consider the corresponding argument as a single character,
* %[d|x|b] : consider the corresponding argument as an integer, print it in base 10 for __d__, 16 for __x__, 2 for __b__.

Integer formats can have a filler, _\#\\0_ or _\#\\space_, and a length attributes from 0 to 9. 

__Exceptions__ : _slprintf_ can raise an exception when the expected type does not corresond to the argument type (only for chars and integers).

## tests

You can use the program _tst-sl-printf.scm_ to test.

With _Gauche_ :

	gosh -b -I. tst-sl-printf.scm

With Chicken :

	make clean all && ./tst-sl-printf

__Note__ : the _Makefile_ constructs the test _and_ the libs.

With Chibi Scheme :

	chibi-scheme tst-sl-printf.scm

__Note__ : you must do this before :

	ln -s println.scm println.sld
	ln -s slprintf.scm slprintf.sld

