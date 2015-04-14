;; ========================================================================
;; println.scm
;; ========================================================================



(define-library 
  (println)
  (export println)
  (import (scheme base) (scheme write))
  (begin
	(define (println . args)
	  (for-each display args)
	  (newline))))
