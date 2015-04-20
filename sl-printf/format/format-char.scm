;; ========================================================================
;; format-char.scm
;; ========================================================================

(define-library 
  (format format-char)
  (export format-char)
  (import (scheme base) (bbmatch))
  (begin

    (define format-char
	  (lambda (value)
		(match value
           ((? char?) value)
           (else (raise "char expected")))))
    
))