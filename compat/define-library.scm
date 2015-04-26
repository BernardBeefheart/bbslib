;; ======================================================================
;; pas de cond-expand pour mzscheme,
;; guile : le guard ne fonctionne pas !!!
;; ======================================================================

(cond-expand
  ((not r7rs)
   (define-syntax define-library
	 (syntax-rules (import export)
				   ((declare-library (libname) (import libs ...) (export funcs ...) body)
					body)
				   ((declare-library (libname) (export funcs ...) (import libs ...) body)
					body))))
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
	(define-syntax raise
	  (syntax-rules ()
					((raise exception)
					 (throw exception))))

	(define-syntax guard
	  (syntax-rules (else)
					((guard (exception (else on-error)) body)
					 (catch #t
							(lambda () 
							  body)
							(lambda (key exception function . currently-unused)
							  on-error))))))

	(else '()))
