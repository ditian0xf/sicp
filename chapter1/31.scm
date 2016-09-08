;-----
;1.31
;-----
; a. Recursive
(define (product term a next b) 
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (factorial n)
  (define (term a) a)
  (define (next a) (+ 1 a))
  (product term 1 next n))

(define (a-quarter-of-pi num-iter)
  (define (term i) (if (even? i) (/ (+ 2 i) (+ 1 i))
                                 (/ (+ 1 i) (+ 2 i))))
  (define (next i) (+ 1 i))
  (product term 1 next num-iter))

; b. Iterative
(define (product term a next b)
  (define (iter a result) 
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))
