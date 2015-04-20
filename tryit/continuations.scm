;; ========================================================================
;; continuations.scm
;; ========================================================================

;; exemple pris ici :
;; http://stackoverflow.com/questions/2018008/help-understanding-continuations-in-scheme?rq=1

(define *add-p* 0)
(define *mul-p* 0)

(define (println . lst)
  (for-each (lambda(e) (display e)) lst)
  (newline))

(define reset-compteurs
  (lambda()
    (set! *add-p* 0)
    (set! *mul-p* 0)))

(define show-compteurs
  (lambda()
    (println "add-p : " *add-p*)
    (println "mul-p : " *mul-p*)))

(define add-p
  (lambda (x y)
    (set! *add-p* (+ *add-p* 1))
    (+ x y)))

(define mul-p
  (lambda (x y)
    (set! *mul-p* (+ *mul-p* 1))
    (* x y)))

(define (list-sum l k)
  (if (null? l)
    (k 0)
    (list-sum (cdr l) (lambda (s) (k (add-p s (car l)))))))

(define list-mul
  (lambda(l k)
    (cond
     ((null? l)
      (k 1))
     ((list-mul (cdr l) (lambda (s) (k (mul-p s (car l)))))))))

;; ----------------------------------------------------------------------
(reset-compteurs)

(display "-------- add -------") (newline)
(display (list-sum '(1 2 3 4 0 1 2 3 4) (lambda (x) x)))
(newline)

(display "-------- mul -------") (newline)
(display (list-mul '(1 2 3 4 0 1 2 3 4) (lambda (x) x)))
(newline)

(show-compteurs)


(reset-compteurs)

(display "-------- add -------") (newline)
(display (list-sum '(1 2 3 4 0 1 2 3 4) (lambda (x) (* 2 x))))
(newline)

(display "-------- mul -------") (newline)
(display (list-mul '(1 2 3 4 0 1 2 3 4) (lambda (x) (* 2 x))))
(newline)

(show-compteurs)
