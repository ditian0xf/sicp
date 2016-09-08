;-----
;1.18
;-----
; Compute a * b, assume a >= 0 and b >= 0.
; fast-mul iterative version.
; Use idea in 1.16: c is used to keep track of the sum of "extra" (current) as when b is odd.
; For example: 3 * 5
; a    b    c
; 3    5    0
; 3    4    3
; 6    2    3
; 12   1    3
; 12   0    15
(define (fast-mul a b) 
  (fast-mul-iter a b 0))
(define (fast-mul-iter a b c) 
  (if (= b 0) c 
      (if (even? b) (fast-mul-iter (double a) (halve b) c) (fast-mul-iter a (- b 1) (+ c a)))))
(define (even? n) (= (remainder n 2) 0))
(define (halve n) (/ n 2))
(define (double n) (* n 2))

(fast-mul 0 3)
