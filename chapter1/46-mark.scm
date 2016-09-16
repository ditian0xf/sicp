;-----
;1.46
;-----

#lang racket

; input:  a procedure for telling whether a guess is good enough
;         a procedure for improving a guess
; output: a procedure that takes a guess as argument and keeps improving the guess until it is good enough
(define (iterative-improve good-enough? improve)
  (lambda (guess)  ; returns a procedure that takes one argument -- guess
    (if (good-enough? guess)
        guess  ; if guess is good enough, return guess, of course
        ((iterative-improve good-enough? improve) (improve guess)))))  ; otherwise, use improved guess for next guess

; sqrt procedure in terms of iterative-improve
(define (sqrt x)
  ((iterative-improve (lambda (guess) (< (abs (- (* guess guess) x)) 0.001))
                      (lambda (guess) (/ (+ guess (/ x guess)) 2))) 1.0))

(sqrt 169)  ; 13.000000070110696

; fixed-point procedure in terms of iterative-improve
(define (fixed-point f)
  (let ((guess 1.0) (tolerance 0.00001))  ; bind constants locally
    (f ((iterative-improve (lambda (guess) (< (abs (- guess (f guess))) tolerance))  ; why (f result) again? on page 92, if close enough, next is returned, not current guess
                           (lambda (guess) (f guess))) guess))))

(fixed-point cos)  ; 0.7390822985224023

(fixed-point (lambda (x) (+ (sin x) (cos x))))  ; 1.2587315962971173



