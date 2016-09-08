;-----
;1.22
;-----
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ 1 test-divisor)))))
(define (divides? a b) (= 0 (remainder b a)))

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

(define (search-for-primes lower-bound upper-bound) ; [lower-bound, upper-bound], both inclusive. 
  (if (= (remainder lower-bound 2) 1) 
      (search upper-bound lower-bound)  ; if lower-bound is odd, start from it; otherwise start from lower-bound + 1.
      (search upper-bound (+ 1 lower-bound))))
(define (search upper-bound current) 
  (if (> current upper-bound) 
      ((newline) (display "Done.")) 
      ((timed-prime-test current) (search upper-bound (+ current 2)))))

(search-for-primes 2 30)

(search-for-primes 1000 1050)
; the three smallest primes larger than 1000 are 1009(***6), 1013(***5), 1019(***5).
(search-for-primes 10000 10050)
; the three smallest primes larger than 1000 are 10007(***18), 10009(***10), 10037(***10).
(search-for-primes 100000 100050)
; the three smallest primes larger than 1000 are 100003(***35), 100019(***24), 100043(***24).
(search-for-primes 1000000 1000050)
; the three smallest primes larger than 1000 are 1000003(***62), 1000033(***55), 1000037(***57).

; The result is compatible with the notion that programs on your machine
; run in time proportional to the number of steps required for the computation.
; The "steps" here is THETA(sqrt(n)).
