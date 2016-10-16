;-----
;1.19
;-----
; T_pq is:
; a <-- bq + aq + ap
; b <-- bp + aq
;
; If we used T_pq on <a, b> twice, we get:
; a <-- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p ==> b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2)
; b <-- (bp + aq)p + (bq + aq + ap)q ==> b(p^2 + q^2) + a(2pq + q^2)
;
; This is equivalent to use T_p'q' on <a, b> once, where
; p' = p^2 + q^2
; q' = 2pq + q^2
(define (fib n) 
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count) 
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))  ; p' = p^2 + q^2
                   (+ (* 2 p q) (* q q)) ; q' = 2pq + q^2
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))
(define (even? n) (= (remainder n 2) 0))
  
(fib 19)
