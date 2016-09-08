;-----
;1.16
;-----
; Use idea in hint: a is used to keep track of the product of "extra" (current) bs when n is odd.
; For example: 3^12
; n   b     a
; 12  3     1
; 6   9     1
; 3   81    1
; 2   81    81
; 1   6561  81
; 0   6561  81*6561
(define (expt b n) 
  (fast-expt-iter b n 1))
(define (fast-expt-iter b n a) 
  (if (= n 0) a 
      (if (even? n) (fast-expt-iter (* b b) (/ n 2) a) (fast-expt-iter b (- n 1) (* a b)))))
(define (even? n) (= (remainder n 2) 0))

(expt 3 12)
