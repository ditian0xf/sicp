;-----
;1.37
;-----

; a. 
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

(define (compute-k k)
	(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k))

(define (how-large-k)
	(define (close-enough? current golden accuracy)
		(and (> current golden)
             (< (abs (- current golden)) accuracy)))
	(define (try i)
		(let ((current (compute-k i)))
		(if (close-enough? current 0.6180 0.0001)
                    i
                    (try (+ 1 i)))))
	(try 1))

(how-large-k)

; b.
; (cont-frac n d k) is recursive in a., let's make it iterative.
(define (cont-frac n d k) 
	(define (f i result) 
		(cond ((= i k) (f (- i 1) (/ (n i) (d i)))) 
              ((= i 0) result)
              (else (f (- i 1) (/ (n i) (+ result (d i)))))))
	(f k 0))
