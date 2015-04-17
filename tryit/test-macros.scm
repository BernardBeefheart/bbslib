;; ======================================================================
;; test-macros.scm
;; playing with macros in Scheme : tests
;; ======================================================================

(import (scheme base) (println) (macros) (tester))

(cond-expand
  (chibi
	(println "macros experiments with chibi scheme"))
  (gauche
	(println "macros experiments with gauche"))
  (chicken
	(println "macros experiments with chicken"))
  (sagittarius
	(println "macros experiments with sagittarius"))
  (foment
	(println "macros experiments with foment"))
  ;; le else est obligatoire pour gosh!
  (else
	(println "macros experiments with unknown scheme")))

(test-begin "macros")
;; test
(define x 0)
(test-equal "before mywhile" x 0)
(mywhile (< x 5)
		 (set! x (+ x 1))
		 (println x))
(test-equal "after mywhile" x 5)


;; test
(define mywhen-test 
  (lambda()
	(mywhen (> x 0)
			(println x)
            (set! x (- x 1))
			(mywhen-test))))

(println "\n-> mywhen test ...")
(mywhen-test)
(test-equal "after mywhen" x 0)
(test-end "maros")
