;; ========================================================================
;; slprintf.scm
;; ========================================================================

(define-library 
  (slprintf)
  (export slprintf)
  (import (scheme base) (scheme write) (scheme char) (println) (exception)
          (format format-string) (format format-int) (format format-char))
  (begin

	
    ;; idée limite: faire une macro pour obtenir une constante...
    (define-syntax default-filler
      (syntax-rules ()
        ((default-filler) #\space)))

    (define-syntax default-len
      (syntax-rules ()
        ((default-len) -1)))
    
	(define (slprintf format . all-args)
      (when (not (string? format))
        (raise-exception 'ERROR 'sl-printf "format must be a string"))
	  (let ((lformat (string->list format)))
		(letrec ((display-and-deformat
				   (lambda(strs lst-of-chars args)
                     (display strs)
					 (deformat (cdr lst-of-chars) args #f (default-filler) (default-len))))
				 (on-else
				   (lambda(c lst-of-chars args)
					 (display c)
					 (deformat (cdr lst-of-chars) args #f (default-filler) (default-len))))
				 (deformat
				   (lambda(lst-of-chars args in-format filler len)
					 (if (not (null? lst-of-chars))
					   (let ((c (car lst-of-chars)))
						 (case c
						   ((#\newline) (newline)
										(deformat (cdr lst-of-chars) args #f (default-filler) (default-len)))
						   ((#\%) (deformat (cdr lst-of-chars) args #t (default-filler) (default-len)))
						   ((#\space #\0) (if in-format
											(deformat (cdr lst-of-chars) args #t c (default-len))
											(on-else c lst-of-chars args)))
						   ((#\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9) (if in-format
																	(deformat (cdr lst-of-chars) args #t filler (- (char->integer c) (char->integer #\0)))
																	(on-else c lst-of-chars args)))
						   ((#\s) (if in-format
									(display-and-deformat (format-string (car args) #\space -1) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\x) (if in-format
									(display-and-deformat (format-int (car args) filler len 16) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\b) (if in-format
									(display-and-deformat (format-int (car args) filler len 2) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\d) (if in-format
									(display-and-deformat (format-int (car args) filler len 10) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\c) (if in-format
									(display-and-deformat (format-char (car args)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   (else
                            (if in-format
                                (raise-exception 'ERROR 'sl-printf "Bad format definition")
                                (display-and-deformat c lst-of-chars args)))))
					   #t))))
		  (deformat lformat all-args #f (default-filler) (default-len)))))

	))
