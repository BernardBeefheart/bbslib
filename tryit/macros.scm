;; ======================================================================
;; macros.scm
;; playing with macros in Scheme
;; ======================================================================

(define-library 
  (macros)
  (import (scheme base) (println))
  (begin

	(cond-expand
	  (chibi
		(println "macros experiments with chibi scheme"))
	  (gauche
		(println "macros experiments with gauche"))
	  (chicken
		(println "macros experiments with chicken"))
	  ;; le else est obligatoire pour gosh!
	  (else
		(println "macros experiments with unknown scheme")))
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

	;; test
	(define x 0)
	(println "\n-> mywhile test ...")
	(mywhile (< x 5)
			 (set! x (+ x 1))
			 (println x))
	(println "\n-> mywhile test end")

	;; avec when
	(define-syntax mywhen
	  (syntax-rules ()
					((mywhen condition body ...)
					 (if condition
					   (begin
						 body ...)
					   #f))))

	;; test
	(define mywhen-test 
	  (lambda(N)
		(mywhen (>= N 0)
				(println N)
				(mywhen-test (- N 1)))))

	(println "\n-> mywhen test ...")
	(mywhen-test 5)
	(println "\n-> mywhen test end")

	))
