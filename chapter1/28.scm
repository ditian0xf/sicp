;-----
;1.28
;-----
(define (square-check x m) 
  (if (and (not (= x 1)) (not (= x (- m 1))) (= (remainder (* x x) m) 1)) 0 (remainder (* x x) m)))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp) (square-check (expmod base (/ exp 2) m) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n) 
  (define (try-it a) (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(miller-rabin-test 6601)

; 6601 is one of the Carmichael numbers; it is composite.
; If we (fermat-test 6601), the result is always true, meaning fermat-test considers 6601 as a prime number.
; If we (miller-rabin-test 6601), the results are mainly false (very, very rare chance that the result is true; 
; while prime numbers always result in true).
