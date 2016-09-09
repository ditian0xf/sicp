;-----
;1.36
;-----

; x --> log(1000)/log(x)
#lang racket
(define (print x)
	(display x)
	(newline))
(define (print-then-return x)
	(print x)
	x)
(define tolerance 0.00001)
(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2))
			tolerance))
	(define (try guess)
		(print guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
			(print-then-return next)
			(try next))))
	(try first-guess))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)
