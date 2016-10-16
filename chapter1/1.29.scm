;-----
;1.29
;-----
(define (sum term a next b)
  (if (> a b)
    0
    (+ (term a)
       (sum term (next a) next b))))

(define (cube x) (* x x x))

; Instead of incrementing (a + kh), we increment k.
(define (integral-simpson f a b n)
  (define h (/ (- b a) n))  ; h = (b-a)/n
  (define (y k) (f (+ a (* k h))))  ; yk = f(a + hk)
  (define (inc k) (+ k 1))
  (define (term k) (* (y k) (cond ((or (= 0 k) (= n k)) 1)
                                  ((even? k) 2)
                                  (else 4))))
  (/ (* h (sum term 0 inc n)) 3))

(integral-simpson cube 0 1 1000)
