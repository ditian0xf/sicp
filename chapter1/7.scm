;-----
;1.7
;-----
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

(define (good-enough0? guess x) 
  (< (abs (- (improve-guess guess x) guess)) (* 0.001 guess)))

(sqrt 999999999999999999999999999)
;For very small number,
;the old "good-enough?" function converges too fast, resulting in inaccuracy: (sqrt 0.00000005) = 0.031250532810688444;
;while the new version is more accurate: (sqrt 0.00000005) = 0.0002236069910516385.
;For very big number,
;the old version is more accurate, although it takes more iterations to achieve this: (sqrt 999999999999999999999999999) 
;= 31631394972364.664;  
;the new version: (sqrt 999999999999999999999999999) = 31622776601683.793.
