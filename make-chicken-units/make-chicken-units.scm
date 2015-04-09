;; ======================================================================
;; make-chicken-units.scm
;; compilation : csc make-chicken-units.scm
;; usage       : make-chicken-units source-file unit-name output-file
;; ======================================================================

(require-extension matchable)
(declare (uses extras))

(define dohelp
  (lambda (exit-code)
	(printf "make-chicken-units [--help] : this text~%")
	(printf "make-chicken-units source-file unit output-file~%")
	(exit exit-code)))


(define (check thunk)
  (condition-case (thunk)
    [(exn file) (printf "File error~%") (dohelp 1)]
    [(exn) (printf "Other error~%") (dohelp 1)]
    [var () (print "something else") (dohelp 1)]))

(define get-file
  (lambda (file-name)
	(check (lambda () (read-lines file-name)))))

(define file->unit
  (lambda (file-name unit-name output-file-name)
	(let ((file-content (get-file file-name)))
	  (letrec ((write-file-content
				 (lambda (port rest)
				   (when (not (null? rest))
					 (fprintf port "~A~%" (car rest))
					 (write-file-content port (cdr rest))))))
		(call-with-output-file output-file-name
							   (lambda (port)
								 (fprintf port "(declare (unit ~A))~%" unit-name)
								 (write-file-content port file-content)))))))

(define main
  (lambda()
	(let ((args (cdr (argv))))
	  (match args
			 (("--help") (dohelp 0))
			 (() (dohelp 0))
			 ((source-file unit output-file) (file->unit source-file unit output-file))
			 (_ (dohelp 1))))))
			 
(main)
