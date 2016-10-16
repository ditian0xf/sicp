;-----
;1.8
;-----
(define (cubic-root x)
  (cond ((> x 0) (cubic-root-iter 1.0 x)) 
        ((< x 0) (- (cubic-root-iter 1.0 (- x))))
        (else 0)))  ; always guess the cubic root is 1.0 at the beginning
(define (cubic-root-iter guess x) 
  (if (good-enough? guess x) guess  ; if the guess is good enough, return the value guess 
      (cubic-root-iter (improve-guess guess x) x)))  ; otherwise, improve the guess and proceed to the next iteration
(define (abs x) 
  (if (> x 0) x (- x)))
(define (improve-guess guess x)  ; improvement := (x / guess^2 + 2 * guess) / 3 
  (/ (+ (* 2 guess) (/ x (* guess guess))) 3))
(define (good-enough? guess x) 
  (< (abs (- (improve-guess guess x) guess)) (* 0.000001 guess)))

(cubic-root 1)
(cubic-root -1)
(cubic-root 64)
(cubic-root -64)
(cubic-root -0.008)
(cubic-root 0)
;When x = 0, improved_guess = 2/3 * guess, that is, guess(i+1) = 2/3 * guess(i). Therefore |improved_guess - guess| 
;= 1/3 * guess, 
;and is always greater than 0.000001 * guess, resulting in infinite interation here. x = 0 should be specifically 
;taken care of.
