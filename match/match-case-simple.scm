; A simple linear pattern matcher
; It is efficient (generates code at macro-expansion time) and simple:
; it should work on any R5RS Scheme system. This modified version 
; should work on any R7RS Scheme system.
;
; It was first developed for the leanTAP theorem prover in miniKanren.
; It has been in the miniKanren repository
;    http://kanren.sf.net/viewvc/kanren/kanren/mini/leanTAP.scm?view=log
; since August 2005.
;
; found on http://okmij.org/ftp/Scheme/macros.html#match-case-simple
;
; See the above code for the example of using match-case-simple:
; transforming a first-order logic formula to the Negation Normal Form.


; (match-case-simple exp <clause> ...[<else-clause>])
; <clause> ::= (<pattern> <guard> exp ...)
; <else-clause> ::= (else exp ...)
; <guard> ::= boolean exp | ()
; <pattern> :: =
;        ,var  -- matches always and binds the var
;                 pattern must be linear! No check is done
;         __   -- matches always
;        'exp  -- comparison with exp (using equal?)
;        exp   -- comparison with exp (using equal?)
;        (<pattern1> <pattern2> ...) -- matches the list of patterns
;        (<pattern1> . <pattern2>)  -- ditto
;        ()    -- matches the empty list

; In the original version, the always-matching pattern was specified
; as a simple underscore. That does not work in R6RS which reserves
; the underscore. Therefore, the always-matching pattern is changed
; to two underscores.

(define-library 
  (match-case-simple)
  (export match-case-simple)
  (import (scheme base) (println))
  (begin

	(define-syntax match-case-simple
	  (syntax-rules ()
		((_ exp clause ...)
		 (let ((val-to-match exp))
		   (match-case-simple* val-to-match clause ...)))))

	(define (match-failure val)
	  (error "failed match" val))

	(define-syntax match-case-simple*
	  (syntax-rules (else)
		((_ val (else exp ...))
		 (let () exp ...))
		((_ val)
		 (match-failure val))
		((_ val (pattern () exp ...) . clauses)
		 (let ((fail (lambda () (match-case-simple* val . clauses))))
		   ; note that match-pattern may do binding. Here,
		   ; other clauses are outside of these binding
		   (match-pattern val pattern (let () exp ...) (fail))))
		((_ val (pattern guard exp ...) . clauses)
		 (let ((fail (lambda () (match-case-simple* val . clauses))))
		   (match-pattern val pattern
						  (if guard (let () exp ...) (fail))
						  (fail))))
		))


	; (match-pattern val pattern kt kf)
	(define-syntax match-pattern
	  (syntax-rules (__ quote unquote)
		((_ val __ kt kf) kt)
		((_ val () kt kf)
		 (if (null? val) kt kf))
		((_ val (quote lit) kt kf)
		 (if (equal? val (quote lit)) kt kf))
		((_ val (unquote var) kt kf)
		 (let ((var val)) kt))
		((_ val (x . y) kt kf)
		 (if (pair? val)
		   (let ((valx (car val))
				 (valy (cdr val)))
			 (match-pattern valx x
							(match-pattern valy y kt kf)
							kf))
		   kf))
		((_ val lit kt kf)
		 (if (equal? val (quote lit)) kt kf))))

	))
