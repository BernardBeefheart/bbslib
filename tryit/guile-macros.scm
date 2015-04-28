
(define-syntax display-compile-timestamp
  (lambda (x)
    (syntax-case x ()
      ((_)
       #`(begin
          (display "The compile timestamp was: ")
          (display #,(current-time))
          (newline))))))

(display-compile-timestamp)

#|
(begin 
  (let (m) (m-992) 
	((apply 
	   (@@ (guile) define-module*) 
	   (const (pipo)) 
	   (const #:filename) 
	   (const #f) 
	   (const #:exports) 
	   (const (a)))) 
	(begin 
	  (apply 
		(@@ (guile) set-current-module) 
		(lexical m m-992)) 
	  (lexical m m-992))) 
  (set! (toplevel b) (const 1)) 
  (set! (toplevel a) (const 3)))
|#

(begin
  (define (mp . l)
	(for-each display l)
	(newline))
  (define a 1)
  (define b 2))

(mp "a = " a)
(mp "b = " b)

	#|
   (define-syntax define-library-full
	 (syntax-rules (export import)
				   ((_ (libname) (import libs libs* ...) (export funcs funcs* ...) (begin exp exp* ...))
					(begin
					  (define-module (libname)
									 :export (funcs funcs* ...))
					  exp exp* ...))
				   ((_ (libname) (export funcs funcs* ...) (import libs libs* ...) (begin exp exp* ...))
					(begin
					  (define-module (libname)
									 :export (funcs funcs* ...))
					  exp exp* ...))
				   ))

	(define-macro (define-library libname imports exports . body)
				  `(begin
					 (define-module ,libname)
					 ,body))

   |#


(begin 
  (let (m) (m-809) 
	((apply 
	   (@@ (guile) define-module*) 
	   (const (sl-printf println)) 
	   (const #:filename) 
	   (const #f) 
	   (const #:exports) 
	   (const (println)))) 
	(begin 
	  (apply 
		(@@ (guile) set-current-module) 
		(lexical m m-809)) 
	  (lexical m m-809))) 
  (define println 
	(lambda ((name . println)) 
	  (lambda-case ((() #f args #f () (args-812)) 
					(begin 
					  (apply 
						(@@ (guile-user) for-each) 
						(@@ (guile-user) display) 
						(lexical args args-812)) 
					  (apply (@@ (guile-user) newline))))))))

(begin 
  (let (m) (m-905) 
	((apply (@@ (guile) define-module*) 
			(const (slprintf println)) 
			(const #:filename) 
			(const #f) 
			(const #:exports) 
			(const (println)))) 
	(begin 
	  (apply 
		(@@ (guile) set-current-module) 
		(lexical m m-905)) 
	  (lexical m m-905))) 
  (define println 
	(lambda ((name . println)) 
	  (lambda-case ((() #f args #f () (args-906)) 
					(begin 
					  (apply 
						(toplevel for-each) 
						(toplevel display) 
						(lexical args args-906)) 
					  (apply (toplevel newline))))))))
