;-----
;2.29
;-----

; === d ===
; only need to change what is in subproblem a.
; specifically, right-branch and branch-structure.
(define (make-mobile left right) (cons left right))
(define (make-branch length structure) (cons length structure))

(define b7 (make-branch 7 107))
(define b10 (make-branch 10 93))
(define m7n10 (make-mobile b7 b10))
(define b5 (make-branch 5 m7n10))
(define b4 (make-branch 4 37))
(define m5n4 (make-mobile b5 b4))
(define b8 (make-branch 8 m5n4))
(define b6 (make-branch 6 100))
(define m6n8 (make-mobile b6 b8))
(define b2 (make-branch 2 m6n8))
(define b3 (make-branch 3 23))
(define m (make-mobile b2 b3))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)  ; change!!
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)  ; change!!
  (cdr branch))

(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((not (pair? mobile)) mobile)  ; a single number weight. although it is not a mobile, we need it as a base case of the recursion.
        (else (+ (total-weight (branch-structure (left-branch mobile)))
                 (total-weight (branch-structure (right-branch mobile)))))))

; > m
; ((2 (6 . 100) 8 (5 (7 . 107) 10 . 93) 4 . 37) 3 . 23)
; > (total-weight m)
; 360
; > m7n10
; ((7 . 107) 10 . 93)
; > b7
; (7 . 107)
; > b10
; (10 . 93)
; > (define a (cons 7 107))
; > a
; (7 . 107)
; > (define b (cons 10 93))
; > b
; (10 . 93)
; > (cons a b)
; ((7 . 107) 10 . 93)
; > (total-weight (cons a b))
; 200
; > (total-weight m7n10)
; 200
; > 
