(define-syntax define-library
  (syntax-rules (import export)
				((declare-library (libname) (import libs ...) (export funcs ...) body)
				 body)
				((declare-library (libname) (export funcs ...) (import libs ...) body)
				 body)))



