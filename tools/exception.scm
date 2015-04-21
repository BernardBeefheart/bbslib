;; ======================================================================
;; execption.scm
;; ======================================================================

(define-library
 (exception)
 (import (scheme base) (println))
 (export raise-exception print-exception)
 (begin
   
   (define-record-type <exception>
     (make-exception type     ;; error, fatal error, warning...
                     source   ;; file, function
                     text)
     exception?
     (type exception-type)
     (source exception-source)
     (text exception-text))
   
   (define raise-exception
     (lambda (type source text)
       (raise (make-exception type source text))))
   
   (define print-exception
     (lambda (exception)
       (cond
        ((string? exception) (println "ERROR: " exception))
        ((exception? exception) (println (exception-type exception) ": " 
                                         (exception-source exception) " - " 
                                         (exception-text exception)))
        (else (println "ERROR of unexpected type: " exception)))))
   
   ))
 
