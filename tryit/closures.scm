;; ======================================================================
;; closures.scm
;; ======================================================================

;; (import (scheme base) (println))

(define (println . l)
  (for-each display l)
  (newline))

(define counter
  (lambda (name)
	(let ((count 0))
	  (define closure-counter
		(lambda(method)
		  (case method
			('inc (set! count (+ count 1)) count)
			('dec (set! count (- count 1)) count)
			('get count)
			('reset (set! count 0) count)
			('display (println "Count " name " -> " count))
			(else
			  (raise "ERROR: method must be one of inc, dec, reset, get and display")))))
	  closure-counter)))

(define-syntax defcounter
  (syntax-rules ()
				((defcounter name)
				 (define name (counter 'name)))))
(define-syntax send->counter
  (syntax-rules ()
				((send->counter name method)
				 (name method))))

(define-syntax display->counter
  (syntax-rules ()
				((display->counter name)
				 (send->counter name 'display))))
(define test1
  (lambda()
	(defcounter c++)
	(defcounter c--)
	(display->counter c++)
	(display->counter c--)
	(send->counter c++ 'inc)
	(send->counter c-- 'dec)
	(display->counter c++)
	(display->counter c--)
	(send->counter c++ 'inc)
	(send->counter c-- 'dec)
	(display->counter c++)
	(display->counter c--)
	(send->counter c++ 'inc)
	(send->counter c-- 'dec)
	(display->counter c++)
	(display->counter c--)))

(test1)


