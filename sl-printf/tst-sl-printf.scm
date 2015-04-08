;; ========================================================================
;; tst-sl-printf.scm
;; ========================================================================

(include "sl-printf.scm")

(define main
  (lambda()
    (newline)
    (sl-printf "str %s(coucou) int %3d (5) le d ne passe %s (pas)?\n<EOL> mais si! hex %03x (23 -> 0x17)\n" 
			   "coucou" 5 "pas" 23)))

(main)

