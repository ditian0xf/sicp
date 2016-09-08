;-----
;1.17
;-----
; Compute a * b. Assume a >= 0 and b >= 0.
; For example, 3 * 5
; (3, 5)
; 3 + (3, 4)
; 3 + 2 * (3, 2)
; 3 + 2 * (2 * (3, 1))
; 3 + 2 * (2 * (3 + (3, 0)))
; -- evaluations above are deferred --
; 3 + 2 * (2 * (3 + 0))
; 3 + 2 * (2 * 3)
; 3 + 2 * 6
; 3 + 12
; 15
; -- deferred evaluations are actually evaluated above --
; We can see "expansion then contraction" and deferred evaluations here, thus this is recursive.
(define (fast-mul a b) 
  (if (= b 0) 0 
      (if (even? b) (double (fast-mul a (halve b))) (+ a (fast-mul a (- b 1))))))
(define (even? n) (= (remainder n 2) 0))
(define (halve n) (/ n 2))
(define (double n) (* n 2))

(fast-mul 98 891)
