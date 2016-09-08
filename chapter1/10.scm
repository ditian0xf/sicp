;-----
;1.10
;-----
;(A 1 10)
;--> (A 0 (A 1 9))
;--> (A 0 (A 0 (A 1 8)))
;--> ...
;--> {9 "(A 0"s} (A 1 1)
;--> {9 "(A 0"s} 2
;--> {8 "(A 0"s} 2^2
;--> ...
;--> 2^10
;--> 1024

;(A 2 4)
;--> (A 1 (A 2 3))
;--> (A 1 (A 1 (A 2 2)))
;--> (A 1 (A 1 (A 1 (A 2 1))))
;--> (A 1 (A 1 (A 1 2)))
;--> (A 1 (A 1 4)
;--> (A 1 16)
;--> 65536

;(A 3 3)
;--> (A 2 (A 3 2))
;--> (A 2 (A 2 (A 3 1)))
;--> (A 2 (A 2 2))
;--> (A 2 4)
;--> 65536

(define (f n) (A 0 n))  ; 2n

(define (g n) (A 1 n))  ; 2^n

(define (h n) (A 2 n))  ; 2^^n (^^ is Knuth's up-arrow notation)

(define (k n) (* 5 n n))  ; 5n^2

;-------------
;count change
;-------------
(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins) 
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))  ; not use current coin for current amount 
                 (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))  ; use
(define (first-denomination kinds-of-coins) 
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)
