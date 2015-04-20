;; ========================================================================
;; format-int.scm
;; ========================================================================

(define-library 
  (format format-int)
  (export format-int)
  (import (scheme base))
  (begin

	(define format-int
	  (lambda(value filler len base)
		(if (not (integer? value))
		  (raise "Integer expected")
		  (let* ((s (number->string value base))
				 (l (string-length s))
				 (d (- len l)))
			(if (> d 0)
			  (string-append (make-string d filler) s)
			  s)))))

  ))