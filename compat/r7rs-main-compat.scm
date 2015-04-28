;; ======================================================================
;; r7rs-main-compat.scm
;; pas de cond-expand pour mzscheme,
;; ======================================================================

(cond-expand
  (guile

   (define-syntax import
	 (syntax-rules()
	   ((import (dir module))
		(use-modules (dir module)))
	   ((import module ...)
			(use-modules module ...))))
   
   (define-syntax define-library
	 (lambda(x)
	   (syntax-case x ()
					((_ libname (import libs ...) (export funcs ...) body)
					 #'(begin
						 (define-module libname)
						 (import libs ...)
						 (use-modules libs ...)
						 (export funcs ...)))
					((_ libname (export funcs funcs* ...) (import libs ...) body)
					 #'(begin
						 (define-module libname)
						 (import libs ...)
						 (use-modules libs ...)
						 (export funcs funcs* ...)))
					)))

	)
  ((not r7rs)

   (define-syntax import
	 (syntax-rules()
	   ((import lst ...)
		'())))
   
   (define-syntax export
	 (syntax-rules()
	   ((export lst ...)
		'())))

   (define-syntax define-library
	 (syntax-rules ()
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
								(when (not done) 
								  on-error))
							  (lambda (exception  . args)
								(set! done #t)
								on-error)))))))

	(else '()))

(cond-expand
  ((not r7rs)
   (define inexact exact->inexact))
  (else '()))

(cond-expand
  ((or mit gambit)
	(define-syntax when
	  (syntax-rules ()
					((when condition body ...)
					 (if condition
					   (begin
						 body ...)
					   #f))))
	)
	(else '()))

(cond-expand
  (guile (use-modules (srfi srfi-9)))
  (else '()))
