;; ========================================================================
;; sl-printf.scm
;; ========================================================================

(define-library 
  (sl-printf)
  (export slprintf)
  (import (scheme base) (scheme write) (scheme char))
  (begin
	(define (_println . args)
	  (for-each display args)
	  (newline))

	(define digit->char
	  (lambda(digit base)
		(cond
		  ((< digit 10) (integer->char (+ digit (char->integer #\0))))
		  (else (integer->char (+ digit (- (char->integer #\a) 10)))))))

	(define show-int
	  (lambda(value filler len base)
		(letrec ((in-show-int
				   (lambda(acc x idx)
					 (cond
					   ((and (= x 0) (< idx len))
						(in-show-int (cons filler acc) x (+ idx 1)))
					   ((and (= x 0) (>= idx len))
						acc)
					   (else
						 (let ((q (quotient x base))
							   (r (remainder x base)))
						   (in-show-int (cons (digit->char r base) acc) q (+ idx 1))))))))
		  (list->string (in-show-int '() value 0)))))


	(define (slprintf format . all-args)
	  ;; (_println "sl-printf " format all-args)
	  (let ((lformat (string->list format))
			(default-filler #\space)
			(default-len -1))
		(letrec ((display-and-deformat
				   (lambda(strs lst-of-chars args)
					 (if strs
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
						   ((#\s) (if in-format
									(display-and-deformat (list (car args)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\space #\0) (if in-format
											(deformat (cdr lst-of-chars) args #t #\0 default-len)
											(on-else c lst-of-chars args)))
						   ((#\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9) (if in-format
																	(deformat (cdr lst-of-chars) args #t filler (- (char->integer c) (char->integer #\0)))
																	(on-else c lst-of-chars args)))
						   ((#\x) (if in-format
									(display-and-deformat (list "0x" (show-int (car args) filler len 16)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   ((#\d) (if in-format
									(display-and-deformat (list (show-int (car args) filler len 10)) lst-of-chars (cdr args))
									(on-else c lst-of-chars args)))
						   (else (display-and-deformat (list  c) lst-of-chars args))))
					   #t))))
		  (deformat lformat all-args #f default-filler default-len))))

	))
