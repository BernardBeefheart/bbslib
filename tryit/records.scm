;; ======================================================================
;; records.scm
;; ======================================================================

(cond-expand
  (r7rs (import (scheme base) (scheme inexact) (println)))
  (else '()))

(define-record-type <point>
  (make-point x y)           ;; constructeur
  point?                     ;; prédicat
  (x point-x point-x!)       ;; champs x, accesseur, modificateur
  (y point-y point-y!))      ;; champ y ...

(define distance 
  (lambda (p1 p2)
    (when (not (point? p1))
      (raise "distance: p1 must be a point"))
    (when (not (point? p2))
      (raise "distance: p2 must be a point"))
    (let ((dx (- (point-x p2) (point-x p1)))
          (dy (- (point-y p2) (point-y p1))))
      (sqrt (inexact (+ (* dx dx) (* dy dy)))))))

(define origine (make-point 0 0))
(define p1 (make-point 1 1))

(println "distance p1 origine: " (distance p1 origine))
