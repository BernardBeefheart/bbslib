;; ========================================================================
;; tests.scm
;; testing tinyclos
;; ========================================================================


(import (scheme base) (tinyclos-support) (more-clos) (tester) (println))

(test-begin "\n\n" "*** testing tinyclos ***")

;***
;
; A simple class, just an instance of <class>.  Note that we are using
; make and <class> rather than make-class to make it.  See Section 2.4
; of AMOP for more on this.
;
;

#|
(define <pos> (make <class>                          ;[make-class 
					'direct-supers (list <object>)   ;  (list <object>) 
					'direct-slots  (list 'x 'y)))    ;  (list 'x 'y)]

(define <pos-3d> (make <class>
					   'direct-supers (list <pos>)
					   'direct-slots (list 'z)))
|#

(defclass <pos> (<object>) 
  ('x 'y))
(defclass <pos-3d> (<pos>) 
  ('z))


(define p1 (make <pos> 'x 1 'y 2))
(define p2 (make <pos> 'x 3 'y 5))
(define p3 (make <pos-3d> 'x 0 'y 1 'z 2))

(defgeneric pos-x)
(defgeneric pos-y)
(defgeneric move)
(defgeneric reset-to-origin)

(defgetter <pos> 'x get-x)
(defgetter <pos> 'y get-y)
(defgetter <pos-3d> 'z get-z)

(defsetter <pos> 'x set-x!)
(defsetter <pos> 'y set-y!)
(defsetter <pos-3d> 'z set-z!)
(defsetter <pos> 'y set-y!)

(add-method pos-x
			(make-method (list <pos>)
						 (lambda (call-next-method pos) (slot-ref pos 'x))))
(add-method pos-y
			(make-method (list <pos>)
						 (lambda (call-next-method pos) (slot-ref pos 'y))))


(defmethod <pos> move #f (pos new-x new-y)
  (set-x! pos new-x)
  (set-y! pos new-y))

(defmethod <pos-3d> move #f (pos new-x new-y new-z)
  (set-x! pos new-x)
  (set-y! pos new-y)
  (set-z! pos new-z))



(defmethod <pos> reset-to-origin #f (self)
  (set-x! self 0)
  (set-y! self 0))

#|
;; error on load (as expected) :
;; ERROR on line XX of file ./more-clos.sld: call-next? must be #t or #f, got : 1
(defmethod <pos-3d> reset-to-origin 1 (self)
  (set-z! self 0))
|#

(defmethod <pos-3d> reset-to-origin #t (self)
  ;; l'appel à call-next-method provoque un :
  ;; undefined variable: call-next-method
  ;; (call-next-method)
  (set-x! self 0)
  (set-y! self 0)
  (set-z! self 0))


(test-equal "(pos-x p1) -> 1" (pos-x p1) 1)
(test-equal "(pos-y p1) -> 2" (pos-y p1) 2)
(test-equal "(pos-x p2) -> 3" (pos-x p2) 3)
(test-equal "(pos-y p2) -> 5" (pos-y p2) 5)

(test-equal "(get-x p1) -> 1" (get-x p1) 1)
(test-equal "(get-y p1) -> 2" (get-y p1) 2)
(test-equal "(get-x p2) -> 3" (get-x p2) 3)
(test-equal "(get-y p2) -> 5" (get-y p2) 5)
(test-equal "(get-x p3) -> 0" (get-x p3) 0)
(test-equal "(get-y p3) -> 1" (get-y p3) 1)
(test-equal "(get-z p3) -> 2" (get-z p3) 2)
(move p3 3 4 5)
(test-equal "(get-x p3) -> 3" (get-x p3) 3)
(test-equal "(get-y p3) -> 4" (get-y p3) 4)
(test-equal "(get-z p3) -> 5" (get-z p3) 5)
(move p1 -1 0)
(test-equal "(get-x p1) -> -1" (get-x p1) -1)
(test-equal "(get-y p1) -> 0" (get-y p1) 0)
(reset-to-origin p3)
(test-equal "(get-x p3) -> 0" (get-x p3) 0)
(test-equal "(get-y p3) -> 0" (get-y p3) 0)
(test-equal "(get-z p3) -> 0" (get-z p3) 0)


(test-end "*** testing tinyclos ***")
