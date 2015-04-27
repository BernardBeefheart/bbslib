;; ======================================================================
;; r7rs-main-compat.scm
;; pas de cond-expand pour mzscheme,
;; ======================================================================

(cond-expand
  ((not r7rs)

   (define-syntax define-library
	 (syntax-rules (import export)
				   ((_ (libname) (import libs ...) (export funcs ...) body)
					body)
				   ((_ (libname) (export funcs ...) (import libs ...) body)
					body)
					))
   )
  (else '()))

(cond-expand
  (gambit
	;; gambit
	(define-syntax guard
	  (syntax-rules (else)
					((guard (exception (else on-error)) body)
					 (with-exception-catcher
					   (lambda (exception) 
						 on-error)
					   (lambda() 
						 body))))))
  (mit
	;; mit-scheme
	(define-syntax raise
	  (syntax-rules ()
					((raise exception)
					 (warn exception))))

	(define-syntax guard
	  (syntax-rules (else)
					((guard (exception (else on-error)) body)
					 (bind-condition-handler '()
											 (lambda (exception) 
											   on-error)
											 (lambda () 
											   body))))))
  (guile
	;; guile
	(define-syntax raise
	  (syntax-rules ()
					((raise exception)
					 (throw exception))))

	(define-syntax guard
	  (syntax-rules (else)
					((guard (exception (else on-error)) body)
					 (let ((done #f))
					   (catch #t
							  (lambda () 
								body)
							  (lambda (exception . args)
								(when (not done) on-error))
							  (lambda (exception  . args)
								(set! done #t)
								on-error)))))))

	(else '()))
