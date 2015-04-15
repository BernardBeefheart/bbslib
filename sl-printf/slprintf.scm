;; ========================================================================
;; slprintf.scm
;; ========================================================================

(define-library 
  (slprintf)
  (export slprintf)
  (import (scheme base) (scheme write) (scheme char) (println) (match-case-simple))
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

	(define format-char
	  (lambda (value)
		(match-case-simple value
						   (,value (char? value) value)
						   (__ () (raise "char expected")))))

	(define (slprintf format . all-args)
	  (let ((lformat (string->list format))
			(default-filler #\space)
			(default-len -1))
		(letrec ((display-and-deformat
				   (lambda(strs lst-of-chars args)
					 (when strs
					   (for-each display strs))
					 (deformat (cdr lst-of-chars) args #f default-filler default-len)))
				 (full-display-and-deformat
				   (lambda(strs lst-of-chars args filler len)
					 (if strs
					   (for-each display strs))
					 (deformat (cdr lst-of-chars) args #f filler len)))
				 (on-else
				   (lambda(c lst-of-chars args)
					 (display c)
					 (deformat (cdr lst-of-chars) args #f default-filler default-len)))
				 (deformat
				   (lambda(lst-of-chars args in-format filler len)
					 (if (not (null? lst-of-chars))
					   (let ((c (car lst-of-chars)))
						 (case c
						   ((#\newline) (newline)
										(deformat (cdr lst-of-chars) args #f default-filler default-len))
						   ((#\%) (deformat (cdr lst-of-chars) args #t default-filler default-len))
						   ((#\space #\0) (if in-format
											(deformat (cdr lst-of-chars) args #t #\0 default-len)
											(on-else c lst-of-chars args)))
						   ((#\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9) (if in-format
																	(deformat (cdr lst-of-chars) args #t filler (- (char->integer c) (char->integer #\0)))
																	(on-else c lst-of-chars args)))
						   ((#\s) (if in-format
									(display-and-deformat (list (car args)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\x) (if in-format
									(display-and-deformat (list (format-int (car args) filler len 16)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\b) (if in-format
									(display-and-deformat (list (format-int (car args) filler len 2)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\d) (if in-format
									(display-and-deformat (list (format-int (car args) filler len 10)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\c) (if in-format
									(display-and-deformat (list (format-char (car args))) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   (else (display-and-deformat (list  c) lst-of-chars args))))
					   #t))))
		  (deformat lformat all-args #f default-filler default-len))))

	))
