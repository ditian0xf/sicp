;-----
;2.32
;-----

; generate all subsets
(define (subsets s)
  (if (null? s)
      (list (list))
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x)) rest)))))

; tests
; > (subsets (list))
; (())
; > (subsets (list 1))
; (() (1))
; > (subsets (list 1 2))
; (() (2) (1) (1 2))
; > (subsets (list 1 2 3))
; (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
; > (subsets (list 1 2 3 4))
; (() (4) (3) (3 4) (2) (2 4) (2 3) (2 3 4) (1) (1 4) (1 3) (1 3 4) (1 2) (1 2 4) (1 2 3) (1 2 3 4))
; >

; say, the input is [1,2,3]
; suppose we already have the result to [2,3], which is
; [], [2], [3], [2,3] <-- rest
; then we add 1 to each of them
; [1], [1,2], [1,3], [1,2,3] <-- (map (lambda (x) (cons (car s) x)) rest)
; combine these two parts, yields the result to [1,2,3]
