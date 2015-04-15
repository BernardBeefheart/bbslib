;; ======================================================================
;; test.scm
;;
;; ======================================================================
(import (scheme base) (println) (match-case-simple))


(define test-match 
  (lambda (x)
	(match-case-simple x
					   (,x (integer? x) "integer")
					   (,x (string? x) "string")
					   (,x (symbol? x) "symbol")
					   (() ()          "nil")
					   (#t ()          "bool")
					   (#f ()          "bool")
					   ((,x . ,y) ()     
								  (string-append "pair of " (test-match x) " and " (test-match y)))
					   (__ ()           "something else"))))

;; printed result:

;; integer
;; bool
;; symbol
;; string
;; something else
;; pair of integer and pair of integer and pair of integer and nil
(for-each (lambda (x) (println (test-match x)))
		  '(1 #t 'symbol "str" 1.235 (1 2 3)))




