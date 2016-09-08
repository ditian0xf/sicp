;-----
;1.32
;-----
; a. Recursive
(define (accumulate combiner null-value term a next b) 
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (factorial n)
  (define (combiner a b) (* a b))
  (define null-value 1)
  (define (term a) a)
  (define (next b) (+ 1 b))
  (accumulate combiner null-value term 1 next n))

(factorial 10)

; b. Iterative
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b) 
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))
