;; ======================================================================
;; application-inc.scm
;; ======================================================================


(define-generic (dohelp (application <Application>) (exit-code <integer>)))
(define-generic (on-bad-argument (application <Application>)))
(define-generic (on-file-error (application <Application>) (direction <string>) exn))
(define-generic (handle-file-operation (application <Application>) (direction <string>) chunk))

(define-method (dohelp before: (application <Application>) (exit-code <integer>))
			   (printf "~A version ~A~%" (slot-value application 'exe-name) (slot-value application 'version))
			   (printf "~A [--help] : this text~%" (slot-value application 'exe-name)))

(define-method (on-bad-argument (application <Application>))
			   (printf "ERROR : bad command line arguments~%")
			   (dohelp application 1))

(define-method (on-file-error (application <Application>) (direction <string>) exn)
	(printf "ERROR (~A): ~A ~A~%" 
			direction 
			((condition-property-accessor 'exn 'message) exn)
			((condition-property-accessor 'exn 'arguments) exn))
	(dohelp application 1))

(define-method (handle-file-operation (application <Application>) (direction <string>) chunk)
	(handle-exceptions exn
					   (on-file-error application direction exn)
					   (chunk)))
