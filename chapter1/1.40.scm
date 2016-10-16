;-----
;1.40
;-----

#lang racket
;;;;;
(define (newtons-method g guess)
	(fixed-point (newton-transform g) guess))

(define (newton-transform g)
	(lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (deriv g)
	(lambda (x) (/ (- (g (+ x dx)) (g x)) dx)))

(define dx 0.00001)
;;;;;

;;;;;
(define (fixed-point f first-guess)
	(define (close-enough? v1 v2)
		(< (abs (- v1 v2))
			tolerance))
	(define (try guess)
		(let ((next (f guess)))
		(if (close-enough? guess next)
			next
			(try next))))
	(try first-guess))

(define tolerance 0.00001)
;;;;;

;;;;;
(define (cubic a b c) (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))  ; generates a function x^3 + ax^2 + bx + c
; if in Python:
; def cubic(a, b, c):
;     def f(x):
;         return x * x * x + a * x * x + b * x + c
;     return f
;;;;;

(newtons-method (cubic 2 2 2) 1)
