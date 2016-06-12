;; ======================================================================
;; tester.scm
;; unit tester
;; ======================================================================

(define-library
 (tester)
 (import (scheme base) (scheme write) (scheme time) (sl-printf println))
 (export test-begin test-end test-equal)
 (begin

   (define *pass* 0)
   (define *fail* 0)
   (define *start* 0)

   (define current-milliseconds
     (lambda()
       (* 1000.0 (current-second))))

   (define (run-test name thunk expect eq pass-msg fail-msg)
     (guard (except (else
                     (begin
                       (set! *fail* (+ *fail* 1))
                       (format-result fail-msg name expect except))))

      (let ((result (thunk)))
        (cond
         ((eq expect result)
          (set! *pass* (+ *pass* 1))
          (format-result pass-msg name expect result))
         (else
          (set! *fail* (+ *fail* 1))
          (format-result fail-msg name expect result))))))

   (define (format-result ls name expect result)
     (let inner-format ((ls ls))
       (cond
        ((null? ls)
         (newline))
        ((eq? (car ls) 'expect)
         (display expect)
         (inner-format (cdr ls)))
        ((eq? (car ls) 'result)
         (display result)
         (inner-format (cdr ls)))
        ((eq? (car ls) 'name)
         (when name
           (begin (display #\space) (display name)))
         (inner-format (cdr ls)))
        (else
         (display (car ls))
         (inner-format (cdr ls))))))

   (define (format-float n prec)
     (let* ((str (number->string n))
            (len (string-length str)))
       (let inner-format ((i (- len 1)))
         (cond
          ((negative? i)
           (string-append str "." (make-string prec #\0)))
          ((eqv? #\. (string-ref str i))
           (let ((diff (+ 1 (- prec (- len i)))))
             (cond
              ((positive? diff)
               (string-append str (make-string diff #\0)))
              ((negative? diff)
               (substring str 0 (+ i prec 1)))
              (else
               str))))
          (else
           (inner-format (- i 1)))))))

   (define (format-percent num denom)
     (let ((x (if (zero? denom) num (inexact (/ num denom)))))
       (format-float (* 100 x) 2)))

   (define-syntax test-assert
     (syntax-rules ()
       ((_ name expr) (run-assert name (lambda () expr)))
       ((_ expr) (run-assert 'expr (lambda () expr)))))

   (define (run-equal name thunk expect eq)
     (run-test name thunk expect eq
      '("(PASS)" name)
      '("(FAIL)" name ": expected " expect " but got " result)))

   (define (test-begin . o)
     (for-each display o)
     (newline)
     (set! *pass* 0)
     (set! *fail* 0)
     (set! *start* (current-milliseconds)))

   (define (test-end . o)
     (let ((end (current-milliseconds))
           (total (+ *pass* *fail*)))
       (println "  " total " tests completed in " (format-float (inexact (/ (- end *start*) 1000)) 3) " seconds")
       (println "  " *pass* " (" (format-percent *pass* total) "%) tests passed")
       (println "  " *fail* " (" (format-percent *fail* total) "%) tests failed")))

   (define-syntax test-equal
     (syntax-rules ()
       ((_ name expr value eq) (run-equal name (lambda () expr) value eq))
       ((_ name expr value) (run-equal name (lambda () expr) value equal?))
       ((_ expr value) (run-assert 'expr (lambda () expr) value equal?))))


   ))
