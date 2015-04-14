;; ======================================================================
;; make-chicken-units.scm
;; compilation : csc make-chicken-units.scm
;; usage       : make-chicken-units source-file unit-name output-file
;; ======================================================================

(require-extension matchable)

(require-extension coops)
(require-extension coops-primitive-objects)

(declare (uses extras))
(declare (uses application))

(include "application-inc.scm")

(define-method (dohelp (self <Application>) (exit-code <integer>))
	(printf "~A source-file unit output-file~%" (slot-value self 'exe-name))
	(printf "Adds the following line:~%")
	(printf "   (declare (unit ~A))~%" "unit-name")
	(printf "at the beginning of output-file~%")
	(printf "and copy source-file after.")
	(exit exit-code))

(define *application* (make <Application> 
							'exe-name (car (argv)) 
							'version "1.0.2"))

(define get-file
  (lambda (file-name)
	(handle-file-operation 
	  *application*
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
		  *application*
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
			 (() (dohelp *application* 0))
			 (("--help") (dohelp *application* 0))
			 ((source-file unit output-file) (file->unit source-file unit output-file))
			 (_ (on-bad-argument *application*))))))

(main)
