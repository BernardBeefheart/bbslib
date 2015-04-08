;; ======================================================================
;; make-chicken-units.scm
;; compilation : csc make-chicken-units.scm
;; usage       : make-chicken-units source-file unit-name output-file
;; ======================================================================

(declare (uses extras))

(define get-file
  (lambda (file-name)
	(read-lines file-name)))

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
	  (let ((file-name (first args))
			(unit-name (second args))
			(output-file-name (third args)))
		(file->unit file-name unit-name output-file-name)))
	(exit 0)))

(main)
