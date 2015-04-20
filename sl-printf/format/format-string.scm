;; ========================================================================
;; format-string.scm
;; ========================================================================

(define-library 
  (format format-string)
  (export format-string)
  (import (scheme base))
  (begin

	(define format-string
	  (lambda(value filler len)
		(if (not (string? value))
		  (raise "String expected")
		  (let* ((s value)
				 (l (string-length s))
				 (d (- len l)))
			(if (> d 0)
			  (string-append (make-string d filler) s)
			  s)))))

  ))
