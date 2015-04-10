;; ======================================================================
;; application-inc.scm
;; ======================================================================


(define-generic (dohelp (self <Application>) (exit-code <integer>)))

(define-method (dohelp before: (self <Application>) (exit-code <integer>))
			   (printf "~A version ~A~%" (slot-value self 'exe-name) (slot-value self 'version))
			   (printf "~A [--help] : this text~%" (slot-value self 'exe-name)))

(define-method (on-bad-argument (self <Application>))
			   (printf "ERROR : bad command line arguments~%")
			   (dohelp self 1))


