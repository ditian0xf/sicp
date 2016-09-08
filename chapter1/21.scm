;-----
;1.21
;-----
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ 1 test-divisor)))))
(define (divides? a b) (= 0 (remainder b a)))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)
