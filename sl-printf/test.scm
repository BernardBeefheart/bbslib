;; ========================================================================
;; tst-sl-printf.scm
;; Usage :
;; gosh -I. tst-sl-printf.scm
;; ========================================================================

(import (scheme base) (scheme write) (slprintf) (println))

(define number-loop
  (lambda (N)
	(if (< N 0)
	  0
	  (begin
		(slprintf "loop %3d -> %02x -> %08b\n" N N N)
		(number-loop (- N 1))))))

(define test-main
  (lambda()
    (newline)
	(number-loop 255)
    (slprintf "str %s(coucou) int %3d (5) le d ne passe %s (pas)?\n<EOL> mais si! hex %03x (23 -> 0x17) %c ('a')\n" 
			   "coucou" 5 "pas" 23 #\a)
	(guard (except (else (println "ERROR: " except)))
		   (slprintf "with error : %d\n" "raté"))
	(guard (except (else (println "ERROR: " except)))
		   (slprintf "with error : %c\n" 32))
    (cond-expand
     (foment (println "No bad call test"))
     (else
      (guard (except (else (println "ERROR, bad call: " except)))
		   (format-char "Ho!"))))
	(println "Fin du test!")))



(test-main)

