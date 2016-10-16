;-----
;1.38
;-----

#lang racket
(define (cont-frac n d k)  ; n and d are functions, each taking one parameter i
	(define (f i)
		(if (= i k) (/ (n i) (d i))
		(/ (n i) (+ (d i) (f (+ i 1))))))
	(f 1))

(define (compute-k k)
	(cont-frac (lambda (i) 1.0) 
		       (lambda (i) (if (= 0 (remainder (- i 2) 3)) (* 2.0 (+ (/ (- i 2) 3) 1)) 1.0))  ; 1,2,1,1,4,1,1,6,1,1,8,... 
		       k))

(compute-k 100)
