;-----
;1.43
;-----

#lang racket

(define (compose f g)
	(lambda (x) (f (g x))))

(define (even? x) (= 0 (remainder x 2)))

(define (repeated proc times)  ; (repeated proc times) is a procedure taking argument `x`; meaning applying `proc` to `x` for `times` times.
	(lambda (x) (cond ((= times 0) x)
		              ((even? times) (let ((half-repeated (repeated proc (/ times 2)))) 
                                          ((compose half-repeated half-repeated) x)))  ; ffff(ffff(x)) --> F(F(x))
		              (else (let ((half-repeated (repeated proc (/ (- times 1) 2)))) 
                                 ((compose proc (compose half-repeated half-repeated)) x))))))  ; f(ffff(ffff(x))) --> f(F(F(x)))

(define (square x) (* x x))
((repeated square 2) 5)
