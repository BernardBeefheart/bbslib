;; ========================================================================
;; tst-sl-printf.scm
;; Usage :
;; gosh -I. tst-sl-printf.scm
;; ========================================================================

(import (scheme base) (scheme write))
(import (sl-printf) (println))

(define number-loop
  (lambda (N)
	(if (< N 0)
	  0
	  (begin
		(slprintf "loop %3d -> %03x\n" N N)
		(number-loop (- N 1))))))

(define test-main
  (lambda()
    (newline)
    (slprintf "str %s(coucou) int %3d (5) le d ne passe %s (pas)?\n<EOL> mais si! hex %03x (23 -> 0x17)\n" 
			   "coucou" 5 "pas" 23)
	(number-loop 255)
	(guard (except (else (_println "ERROR: " except)))
		   (slprintf "with error : %d\n" "raté"))
	(_println "Fin du test!")))



(test-main)

