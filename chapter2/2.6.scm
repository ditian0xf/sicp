;-----
;2.6
;-----

(define zero (lambda (f) (lambda (x) x)))  ; ((zero f) x) ==> x

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))  ; (((add-1 n) f) x) ==> (f ((n f) x))
                                            ;                       can be seen as
                                            ;                       (f (f_n x)) ==> (f_n+1 x)

; (add-1 zero) ==> (((add-1 zero) f) x) ==> (f ((zero f) x)) ==> (f x)
; So,
; ((zero f) x) ==> x
; ((one f) x) ==> (f x)

(define one
  (lambda (f) (lambda (x) (f x))))

; Then two should be ((two f) x) ==> (f (f x))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

; two should be equivalent to (add-1 one). let's check it.
; (((add-1 one) f) x) ==> (f ((one f) x)) ==> (f (f x))

#| test

> (define (f x) (* 2 x))
> ((zero f) 13)
13
> ((one f) 13)
26
> ((two f) 13)
52
> (((add-1 zero) f) 13)
26
> (((add-1 one) f) 13)
52

|#