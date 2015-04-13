;; ========================================================================
;; tst-sl-printf.scm
;; Usage :
;; gosh -I. tst-sl-printf.scm
;; ========================================================================

(import (scheme base) (scheme write))
(import (sl-printf))

(define test-main
  (lambda()
    (newline)
    (slprintf "str %s(coucou) int %3d (5) le d ne passe %s (pas)?\n<EOL> mais si! hex %03x (23 -> 0x17)\n" 
			   "coucou" 5 "pas" 23)))

(test-main)

