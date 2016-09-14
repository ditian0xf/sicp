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
	(lambda (x) (average x (f x)))
;----

