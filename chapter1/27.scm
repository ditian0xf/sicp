;-----
;1.27
;-----
(define (square x) (* x x))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (test-carmichael-number n) (if (< n 2) #f (test-iter (- n 1) n)))

(define (test-iter i n) 
  (cond ((= i 1) #t)
        ((= i (expmod i n n)) (test-iter (- i 1) n))
        (else #f))) 

(test-carmichael-number 6601)
