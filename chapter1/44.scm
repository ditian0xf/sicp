;-----
;1.44
;-----

#lang racket

;----
(define (compose f g)
	(lambda (x) (f (g x))))

(define (even? x) (= 0 (remainder x 2)))

(define (repeated proc times)  ; (repeated proc times) is a procedure taking argument `x`; meaning applying `proc` to `x` for `times` times.
	(lambda (x) (cond ((= times 0) x)
		              ((even? times) (let ((half-repeated (repeated proc (/ times 2)))) 
                                          ((compose half-repeated half-repeated) x)))  ; ffff(ffff(x)) --> F(F(x))
		              (else (let ((half-repeated (repeated proc (/ (- times 1) 2)))) 
                                 ((compose proc (compose half-repeated half-repeated)) x))))))  ; f(ffff(ffff(x))) --> f(F(F(x)))
;----

;----
(define (smooth f)  ; return smoothed f, that is, 1/3 * (f(x-dx) + f(x) + f(x+dx))
	(lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3)))
;----


(define dx 0.00001)
(define (square x) (* x x))
(define (double x) (+ x x))
(define (zero x) 0)
;((smooth square) 3)

;----
; input:  a smooth procedure, how many times for applying the smooth procedure
; output: a procedure that takes a procedure f as its input, and returns times-fold smoothed f 
(define (n-fold-smooth smooth times)  
	(lambda (f) ((repeated smooth times) f)))
;----

(((n-fold-smooth smooth 10) zero) 312123)
