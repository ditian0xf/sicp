;-----
;1.23
;-----
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b) (= 0 (remainder b a)))
(define (next test-divisor) (if (even? test-divisor) (+ 1 test-divisor) (+ 2 test-divisor)))
(define (even? n) (= 0 (remainder n 2)))

(define (prime? n) (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time) 
  (if (prime? n) (report-time (- (runtime) start-time)) (display " is not a prime.")))
(define (report-time elapsed-time)
  (display "***")
  (display elapsed-time))

(timed-prime-test 961748927)
; 961748927 is a large prime number.
; For the original (+ 1 test-divisor), try 10 times: 931, 995, 1053, 1014, 968, 941, 1051, 1043, 921, 912, 
; average 982.9.
; For the (next test-divisor), try 10 times: 911, 932, 946, 962, 1011, 925, 896, 900, 967, 949, average 939.9.
; The observed ratio is not 2, but near 1.
; The only difference is between (+ 1 test-divisor) and (next test-divisor).
; For (+ 1 test-divisor), for each test-divisor in [2, sqrt(n)], perform an add operation and a remainder operation.
; For (next test-divisor), although the number of test-divisor halved, for each test-divisor, 
; perform a remainder operation (followed by if branch selection), an add operation and another remainder operation.
; If we simply change (+ 1 test-divisor) to (+ 2 test-divisor), the runtime will be approximately 620.
