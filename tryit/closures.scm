;; ======================================================================
;; closures.scm
;; sagittarius -r 7 -L .. closures.scm
;; ======================================================================

(define-library
  (closures)
  (export test-closures)
  (import (scheme base) (scheme write) (sl-printf println))
  (begin

	(cond-expand
	  ((not r7rs)
	   (define (println . l)
		 (for-each display l)
		 (newline)))
	  (else '()))

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
					((defcounter counter-name)
					 (define counter-name (counter 'counter-name)))))

	(define-syntax send->counter*
	  (syntax-rules ()
					((send->counter counter-name method)
					 (guard (e (else (println "ERROR: " e " !!")))
							(counter-name method)))))

	(define send->counter
	  (lambda (counter-name method)
		(guard (e (else (println "ERROR: " e " !!")))
			   (counter-name method))))

	(define-syntax display->counter
	  (syntax-rules ()
					((display->counter counter-name)
					 (send->counter counter-name 'display))))
	(define test-closures
	  (lambda()
		(defcounter c++)
		(defcounter c--)
		(display->counter c++)
		(display->counter c--)
		(send->counter c++ 'inc)
		(send->counter c-- 'dec)
		(send->counter c-- 'pipo)
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

	(test-closures)

	))
