;; ======================================================================
;; application.scm
;; ======================================================================

(declare (unit application))
(require-extension coops)
(require-extension coops-primitive-objects)

(define-class <Application> ()
			  ((exe-name initform: "no-name-app")
			   (version initform: "1.0.0")))

(include "application-inc.scm")

