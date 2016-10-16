;1.6
(define (new-if predicate then-clause else-clause) 
  (cond (predicate then-clause)
        (else else-clause)))
(new-if (= 3 2) 1 0)
(new-if (= 3 3) 1 0)

(define (sqrt-iter guess x) 
  (new-if (good-enough? guess x) guess  ; if the guess is good enough, return the value guess 
      (sqrt-iter (improve-guess guess x) x)))  ; otherwise, improve the guess and proceed to the next iteration

(sqrt 1)
; Infinite runtime here. As regards customer-defined procedure (new-if predicate then-clause else-clause), when applied,
; the interpreter firstly evaluates all its 3 arguments.
; predicate is (good-enough? guess x), then-clause is guess, both easy to evaluate; however, the else-clause is 
; again a recursive function without termination.
; As a matter of fact, the idea here is that we should only evaluate the predicate to decide what to do next, 
; so we should use the original "if" procedure.
