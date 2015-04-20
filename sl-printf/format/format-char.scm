;; ========================================================================
;; format-char.scm
;; ========================================================================

(define-library 
  (format format-char)
  (export format-char)
  (import (scheme base) (match-case-simple))
  (begin

    (define format-char
	  (lambda (value)
		(match-case-simple value
						   (,value (char? value) value)
						   (__ () (raise "char expected")))))
    
))