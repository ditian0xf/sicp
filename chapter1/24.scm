;-----
;1.24
;-----
(define (square x) (* x x))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n) 
  (define (try-it a) (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time) 
  (if (fast-prime? n 500) (report-time (- (runtime) start-time)) (display " is not a prime.")))
(define (report-time elapsed-time)
  (display "***")
  (display elapsed-time))

(timed-prime-test 278)
; Run (timed-prime-test 1019) five times: 412, 460, 396, 409, 421, average 419.6.
; Run (timed-prime-test 1000037) five times: 622, 677, 620, 630, 636, average 637.
; Since the time complexity is THETA(logn), the time growth is indeed very slow.
; The running time of (timed-prime-test 1000037) is supposed to be 2x as the running time of (timed-prime-test 1019).
; However, the actual ratio is 637 / 4119.6 = 1.52.
; Note that the "expmod" function is not strictly logarithmic, and it is not easy to tell the actual random number
; distribution.
; These two reasons could lead to the discrepancy between theory and observation.
