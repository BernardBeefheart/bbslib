;; ======================================================================
;; test-macros.scm
;; playing with macros in Scheme : tests
;; ======================================================================

(import (scheme base) (println) (macros))

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

;; test
(define x 0)
(println "\n-> mywhile test ...")
(mywhile (< x 5)
		 (set! x (+ x 1))
		 (println x))
(println "\n-> mywhile test end")


;; test
(define mywhen-test 
  (lambda(N)
	(mywhen (>= N 0)
			(println N)
			(mywhen-test (- N 1)))))

(println "\n-> mywhen test ...")
(mywhen-test 5)
(println "\n-> mywhen test end")
