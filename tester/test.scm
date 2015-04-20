;; ======================================================================
;; test.scm
;; unit tester
;; ======================================================================

(import (scheme base) (tester))

(test-begin "\n\n" "*** test tester ***")
(test-equal "'(+ 1 2)" '(+ 1 2) 3)
(test-equal "(+ 1 2)" (+ 1 2) 3)
(test-end "test tester")