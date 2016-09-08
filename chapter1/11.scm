;-----
;1.11
;-----
(define (f n)  ;recursive 
  (if (< n 3) n (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f n)  ;iterative 
  (if (< n 3) n (f-iter 0 1 2 (- n 2))))

(define (f-iter ppp pp p how-many-left) 
  (if (= how-many-left 0) p (f-iter pp p (+ (* 3 ppp) (* 2 pp) p) (- how-many-left 1))))

(f 20)
