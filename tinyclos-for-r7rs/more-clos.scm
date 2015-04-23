;; ========================================================================
;; more-clos.scm
;; a set of fonctions and macros which helps declarations
;; of class, generic and method
;; ========================================================================

(define-library
  (more-clos)
  (import (scheme base) (tinyclos-support) (tiny-clos))
  (export initialize-slots defclass defgeneric defgetter defsetter defmethod)
  (begin

	;***
	;
	; This is a useful sort of helper function.  Note how it uses the
	; introspective part of the MOP.  The first few pages of chapter
	; two of the AMOP discuss this.
	;
	; Note that this introspective MOP doesn't support back-links from
	; the classes to methods and generic functions.  Is that worth adding?
	;
	;
	(define initialize-slots
	  (lambda (object initargs)
		(let ((not-there (list 'shes-not-there)))
		  (for-each (lambda (slot)
					  (let ((name (car slot)))
						(let ((value  (getl initargs name not-there)))
						  (if (eq? value not-there)
							'do-nothing
							(slot-set! object name value)))))
					(class-slots (class-of object))))))

	;***
	;
	(define-syntax defclass
	  (syntax-rules ()
					((defclass class (parents ...) (fields ...))
					 (begin
					   (define class
						 (make <class>
							   'direct-supers (list parents ...)
							   'direct-slots (list fields ...)))
					   (add-method initialize
								   (make-method 
									 (list class)
									 (lambda (call-next-method self initargs)
									   (call-next-method)
									   (initialize-slots self initargs))))
					   ))))

	;***
	;
	(define-syntax defgeneric
	  (syntax-rules ()
					((_ fgeneric)
					 (begin
					   (define fgeneric 
						 (guard (exception (make-generic))
								(begin
								  (if (procedure? fgeneric)
									(begin
									  ;; (println "WARNING: " 'fgeneric " already defined as a generic function!")
									  fgeneric)
									(make-generic)))))))))

	;***
	;
	(define-syntax defgetter
	  (syntax-rules ()
					((_ class slot-name getter-name)
					 (begin
					   (defgeneric getter-name)
					   (add-method getter-name
								   (make-method (list class)
												(lambda (call-next-method obj) 
												  (slot-ref obj slot-name))))))))

	;***
	;
	(define-syntax defsetter
	  (syntax-rules ()
					((_ class slot-name setter-name)
					 (begin
					   (defgeneric setter-name)
					   (add-method setter-name
								   (make-method (list class)
												(lambda (call-next-method obj value) 
												  (slot-set! obj slot-name value))))))))

	;***
	;
	(define-syntax defmethod
	  (syntax-rules (call-next-method)
					((defmethod class method-name #t (args ...) body ...)
					 (begin
					   (defgeneric method-name)
					   (add-method method-name
								   (make-method (list class)
												(lambda (call-next-method args ...)
												  (call-next-method)
												  body ...)))))
					((defmethod class method-name #f (args ...) body ...)
					 (begin
					   (defgeneric method-name)
					   (add-method method-name
								   (make-method (list class)
												(lambda (call-next-method args ...)
												  body ...)))))
					((defmethod class method-name my-call-next-method (args ...) body ...)
					 (begin
					   (defgeneric method-name)
					   (add-method method-name
								   (make-method (list class)
												(lambda (my-call-next-method args ...)
												  body ...)))))
					))

	)
  )
