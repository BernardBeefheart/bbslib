;; ========================================================================
;; println.scm
;; ========================================================================

(define-library 
  (sl-printf println)
  (export println err-println)
  (import (scheme base) (scheme write))

  (begin
	(define (println . args)
	  (for-each display args)
	  (newline))
	
	(define (err-println . args)
	  (display "ERROR: ")
	  (for-each display args)
	  (newline))
	))
