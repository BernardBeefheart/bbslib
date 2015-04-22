(import (scheme base) (println))
(define-syntax defmethod
  (syntax-rules (call-next-method)
				((_ class method-name (args ...) (body ...))
				 '(begin
					(defgeneric method-name)
					(println "args : <" (args ...) ">")
					(add-method method-name
								(make-method (list class)
											 (lambda (call-next-method args ...)
											   body ...)))))))

(define r (defmethod <pos> move (pos new-x new-y)
			((set-x! pos new-x)
			 (set-y! pos new-y))))

(define-syntax deffunction
  (syntax-rules ()
				((deffunction name (args ...) (body ...))
				 (define name
				   (lambda (args ...)
					 body ...)))))

(deffunction add (x y)
			 ((println "add " x " " y " -> " (+ x y))))
