;1.5
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
(test 0 (p))
; Infinite runtime here. Why?
; --------
; Scheme is an applicative-order language, namely, that all the arguments to Scheme procedures are evaluated
; when the procedure is applied. In contrast, normal-order languages delay evaluation of procedure arguments
; until the actual argument values are needed, which is also called lazy evaluation.
; --------
; Therefore, when applying procedure "test", all the arguments of "test", namely 0 and (p) are evaluated.
; 0 is evaluated to 0 of course.
; (p) is a procedure that keeps calling itself without termination condition, thus the evaluation never ends.
;
; However, if the interpreter uses normal-order/lazy evaluation, when evaluating (test 0 (p)), it will replace
; the evaluation as (if (= 0 0) 0 (p)), the arguments will not be touched until they are needed. As regards "if"
; function, the 1st argument (= 0 0) is firstly evaluated as #t, so the 2nd argument 0 is needed, while the 3rd
; is not. 0 is evaluated as 0. In the end, the procedure "test" is evaluated as 0.

;computing square root of x
(define (sqrt x)
  (sqrt-iter 1.0 x))  ; always guess the square root is 1.0 at the beginning
(define (sqrt-iter guess x) 
  (if (good-enough? guess x) guess  ; if the guess is good enough, return the value guess 
      (sqrt-iter (improve-guess guess x) x)))  ; otherwise, improve the guess and proceed to the next iteration
(define (good-enough? guess x) 
  (< (abs (- (* guess guess) x)) 0.001))  ; |guess * guess - x| < 0.001?
(define (abs x) 
  (if (> x 0) x (- x)))
(define (improve-guess guess x)  ; improvement := (guess + x / guess) / 2 
  (/ (+ guess (/ x guess)) 2))

(sqrt 9)
