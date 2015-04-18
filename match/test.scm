;; ======================================================================
;; test.scm
;;
;; ======================================================================
(import (scheme base) (println) (match-case-simple) (tester))


(define test-match 
  (lambda (x)
	(match-case-simple x
					   (,x (integer? x) 'integer)
					   (,x (string? x) 'string)
					   (,x (symbol? x) 'symbol)
					   (() ()          'nil)
					   (#t ()          'bool)
					   (#f ()          'bool)
					   ((,x . ,y) ()     
								  (list 'pair-of (test-match x) 'and (test-match y)))
					   (__ ()           'something-else))))

(test-begin "match-case-simple")
(test-equal "test-match" 
            (map test-match '(1 #t 'symbol "str" 1.235 (1 2 3)))
            '(integer bool 
              (pair-of symbol and (pair-of symbol and nil)) 
              string something-else 
              (pair-of integer and (pair-of integer and (pair-of integer and nil)))))
(test-end "match-case-simple")




