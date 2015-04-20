;; ========================================================================
;; format-string.scm
;; ========================================================================

(define-library 
  (format format-string)
  (export format-string)
  (import (scheme base) (bbmatch) (exception))
  (begin

	(define format-string
	  (lambda(value filler len)
        (match value
               ((? string?)
                (let* ((s value)
                       (l (string-length s))
                       (d (- len l)))
                (if (> d 0)
                  (string-append (make-string d filler) s)
                  s)))
               (else
                  (raise-exception 'ERROR 'format-string "String expected")))))

  ))
