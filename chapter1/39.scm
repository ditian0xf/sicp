;-----
;1.39
;-----

; f(1) = N_1 / (D_1 + f(2))
; f(2) = N_2 / (D_2 + f(3))
; ...
; f(k) = N_k / D_k
#lang racket
(define (cont-frac n d k)  ; n and d are functions, each taking one parameter i
	(define (f i) (
		if (= i k) 
		(/ (n i) (d i)) 
		(/ (n i) (+ (d i) (f (+ 1 i))))))
	(f 1))

(define (tan-cf x k) 
	(cont-frac (lambda (i) (if (= i 1) x (- (* x x))))  ; x, -x^2, -x^2,...
		       (lambda (i) (- (* 2 i) 1))  ; 1, 3, 5,...
		       k))
