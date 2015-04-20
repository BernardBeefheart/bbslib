;; ========================================================================
;; test.scm
;; Usage :
;; gosh -I. -I../match test.scm
;; sagittarius -L../match -L. test.scm
;; chibi-scheme -I . -I ../match test.scm
;; foment -I ../match  test.scm
;; chicken : make clean all && ./test
;; Note:
;; chibi needs ln -s *.scm *.sld
;; chicken needs : ln -s ../dir/*.so && ln -s format/*.so format.*.so
;; ========================================================================

(import (scheme base) (slprintf) (println) (exception))

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
	(guard (except (else (print-exception except)))
		   (slprintf "with error : %d\n" "raté"))
	(guard (except (else (print-exception except)))
		   (slprintf "with error : %c\n" 32))
    (cond-expand
     (foment (println "No bad call test"))
     (else
      (guard (except (else (print-exception except)))
		   (format-char "Ho!"))))
	(println "Fin du test!")))



(test-main)

