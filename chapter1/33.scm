;-----
;1.33
;-----
; Recursive
(define (filtered-accumulate combiner null-value term a next b predicate)
  (if (> a b)
      null-value
      (combiner (if (predicate a) (term a) null-value)
                (filtered-accumulate combiner null-value term (next a) next b predicate))))

; Iterative
(define (filtered-accumulate combiner null-value term a next b predicate)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (if (predicate a) (term a) null-value)))))
  (iter a null-value))

(define (square-sum-of-even-numbers a b)
  (define (combiner x y) (+ x y))
  (define null-value 0)
  (define (term x) (* x x))
  (define (next x) (+ 1 x))
  (define (predicate x) (even? x))
  (filtered-accumulate combiner null-value term a next b predicate))

(square-sum-of-even-numbers 1 10)

; a.
(define (filtered-accumulate combiner null-value term a next b predicate)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner result (if (predicate a) (term a) null-value)))))
  (iter a null-value))

(define (square-sum-of-prime-numbers a b)
  (define (combiner x y) (+ x y))
  (define null-value 0)
  (define (term x) (* x x))
  (define (next x) (+ 1 x))
  (define (predicate x) (prime? x))
  (filtered-accumulate combiner null-value term a next b predicate))

(square-sum-of-prime-numbers 1 10)

; b.
(define (filtered-accumulate combiner null-value term a next b predicate)
  (if (> a b)
      null-value
      (combiner (if (predicate a) (term a) null-value)
                (filtered-accumulate combiner null-value term (next a) next b predicate))))

(define (f n)
  (define (combiner x y) (* x y))
  (define null-value 1)
  (define (term x) x)
  (define (next x) (+ 1 x))
  (define (predicate x) (= 1 (gcd x n)))
  (filtered-accumulate combiner null-value term 1 next (- n 1) predicate))

(define (gcd a b)
  (if (= b 0)
    a
    (gcd b (modulo a b))))

(f 7)
