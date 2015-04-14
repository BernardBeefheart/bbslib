;; ========================================================================
;; println.scm
;; ========================================================================



(define-library 
  (println)
  (export _println)
  (import (scheme base) (scheme write))
  (begin
	(define (_println . args)
	  (for-each display args)
	  (newline))))
