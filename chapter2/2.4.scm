;-----
;2.4
;-----

(define (cons x y)
  (lambda (m) (m x y)))  ; returns a procedure A. A's input parameter is a procedure B;
                         ; B's input parameters are x and y.

(define (car z)
  (z (lambda (p q) p)))

; now z is procedure A.
; A's input parameter (lambda (p q) p), is procedure B.
; B takes two arguments p and q, and returns the first one, which is p.
; Therefore,
; (z (lambda (p q) p)) evaluates to
; ((lambda (p q) p) x y), which evaluates to
; x

(define (cdr z)
  (z (lambda (p q) q)))

#| test
> (define pair (cons 1 2))
> pair
#<procedure:...p/chapter2/4.scm:6:2>
> (car pair)
1
> (cdr pair)
2
|#