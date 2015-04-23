;; ======================================================================
;; sort.scm
;; ======================================================================

(define-library
  (sort)
  (import (scheme base))
  (export merge-sort)
  (begin

	;; cf http://en.literateprograms.org/Merge_sort_%28Scheme%29#chunk def:merge
	(define (merge-sort pred? ls)
	  (define (split ls)
		(letrec ((split-h (lambda (ls ls1 ls2)
							(cond
							  ((or (null? ls) (null? (cdr ls)))
							   (cons (reverse ls2) ls1))
							  (else (split-h (cddr ls)
											 (cdr ls1) (cons (car ls1) ls2)))))))
		  (split-h ls ls '())))

	  (define (merge ls1 ls2)
		(cond
		  ((null? ls1) ls2)
		  ((null? ls2) ls1)
		  ((pred? (car ls1) (car ls2))
		   (cons (car ls1) (merge (cdr ls1) ls2)))
		  (else (cons (car ls2) (merge ls1 (cdr ls2))))))

	  (cond
		((null? ls) ls)
		((null? (cdr ls)) ls)
		(else (let ((splits (split ls)))
				(merge 
				  (merge-sort pred? (car splits))
				  (merge-sort pred? (cdr splits)))))))

	))
