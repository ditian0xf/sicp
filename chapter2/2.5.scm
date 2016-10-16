;-----
;2.5
;-----

; Given nonnegative a, b, we get 2^a * 3^b.
; Suppose there is some nonnegative x, y, where 2^x * 3^y = 2^a * 3^b, that is, same integer,
; then can x, y be different from a, b?
; 2^x * 3^y = 2^a * 3^b ==> 2^(x - a) = 3^(b - y) ==> x = a and y = b.
; Therefore, once we have integer 2^a * 3^b, a and b must be unique.
; That is, 2^a * 3^b can represent pair a and b.

(define (how-many base value)
  (if (not (= 0 (remainder value base)))
      0
      (+ 1 (how-many base (/ value base)))))

(define (cons x y)
  (* (expt 2 x) (expt 3 y)))

(define (car z)
  (how-many 2 z))

(define (cdr z)
  (how-many 3 z))

#| test
> (define pair (cons 32 0))
> (car pair)
32
> (cdr pair)
0
> (define pair (cons 0 0))
> (car pair)
0
> (cdr pair)
0
> (define pair (cons 0 17))
> (car pair)
0
> (cdr pair)
17
> (define pair (cons 123 99))
> (car pair)
123
> (cdr pair)
99
|#

