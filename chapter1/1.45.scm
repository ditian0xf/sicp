;-----
;1.45
;-----

#lang racket

;---- repeated
(define (compose f g)
	(lambda (x) (f (g x))))

(define (repeated proc times)  ; (repeated proc times) is a procedure taking argument `x`; meaning applying `proc` to `x` for `times` times.
	(lambda (x) (cond ((= times 0) x)
		              ((even? times) (let ((half-repeated (repeated proc (/ times 2)))) 
                                          ((compose half-repeated half-repeated) x)))  ; ffff(ffff(x)) --> F(F(x))
		              (else (let ((half-repeated (repeated proc (/ (- times 1) 2)))) 
                                 ((compose proc (compose half-repeated half-repeated)) x))))))  ; f(ffff(ffff(x))) --> f(F(F(x)))
;----

;---- fixed point
(define tolerance 0.00001)

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

(define (fixed-point-of-transform g transform guess)
	(fixed-point (transform g) guess))
;----

;---- average damp
(define (average a b)
	(/ (+ a b) 2))

(define (average-damp f)
	(lambda (x) (average x (f x))))
;----

(define (nth-root-test x n how-many-damp)
	(fixed-point-of-transform (lambda (y) (/ x (expt y (- n 1)))) (repeated average-damp how-many-damp) 1.0))

;(nth-root 16 1 0)

; Experiment n -- how-many-damp relationship
; n             | 1 | 2 3 | 4 5 6 7 | 8 ...
; how-many-damp | 0 | 1 1 | 2 2 2 2 | 3 ...

; how-many-damp = floor(lg(n))

; Redefine nth-root procedure as:

(define (nth-root x n)
	(fixed-point-of-transform (lambda (y) (/ x (expt y (- n 1)))) (repeated average-damp (floor (/ (log n) (log 2)))) 1.0))

(nth-root 123 57)
