;; ======================================================================
;; macros.scm
;; playing with macros in Scheme
;; ======================================================================

(define-library 
  (macros)
  (cond-expand
	(chibi (import (scheme base) (srfi 46)))
	(else (import (scheme base))))
  (export mywhile mywhen)
  
  (begin


	;; exemple : à partir de http://www.willdonnelly.net/blog/scheme-syntax-rules/
	;; écrire un while
	;; (define x 0)
	;; (while (< x 5)
	;;   (set! x (+ x 1))
	;;   (print x))
	;; 
	(define-syntax mywhile
	  (syntax-rules ()
					((mywhile condition body ...)
					 (let loop ()
					   (if condition
						 (begin
						   body ...
						   (loop))
						 #f)))))

	;; avec when
	(define-syntax mywhen
	  (syntax-rules ()
					((mywhen condition body ...)
					 (if condition
					   (begin
						 body ...)
					   #f))))
	))
