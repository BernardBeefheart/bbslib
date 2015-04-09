;; ======================================================================
;; make-chicken-units.scm
;; compilation : csc make-chicken-units.scm
;; usage       : make-chicken-units source-file unit-name output-file
;; ======================================================================

(require-extension matchable)
(declare (uses extras))

(define *exe-name* "make-chicken-units")
(define *version* "1.0.0")

(define dohelp
  (lambda (exit-code)
	(printf "~A version ~A~%" *exe-name* *version*)
	(printf "~A [--help] : this text~%" *exe-name*)
	(printf "~A source-file unit output-file~%" *exe-name*)
	(exit exit-code)))

(define on-file-error 
  (lambda (direction exn)
	(printf "ERROR (~A): ~A ~A~%" 
			direction 
			((condition-property-accessor 'exn 'message) exn)
			((condition-property-accessor 'exn 'arguments) exn))
	(dohelp 1)))

(define handle-file-operation
  (lambda (direction chunk)
	(handle-exceptions exn
					   (on-file-error direction exn)
					   (chunk))))

(define get-file
  (lambda (file-name)
	(handle-file-operation 
	  "read"
	  (lambda ()
		(read-lines file-name)))))

(define file->unit
  (lambda (file-name unit-name output-file-name)
	(let ((file-content (get-file file-name)))
	  (letrec ((write-file-content
				 (lambda (port rest)
				   (when (not (null? rest))
					 (fprintf port "~A~%" (car rest))
					 (write-file-content port (cdr rest))))))
		(handle-file-operation
		  "write"
		  (lambda ()
			(call-with-output-file output-file-name
								   (lambda (port)
									 (fprintf port "(declare (unit ~A))~%" unit-name)
									 (write-file-content port file-content)))))))))

(define main
  (lambda()
	(let ((args (cdr (argv))))
	  (match args
			 (() (dohelp 0))
			 (("--help") (dohelp 0))
			 ((source-file unit output-file) (file->unit source-file unit output-file))
			 (_ (dohelp 1))))))

(main)
