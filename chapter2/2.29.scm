;-----
;2.29
;-----

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))  ; length is just a number; structure may be a number (weight), or another mobile

; the binary mobile for testing (image in 29_1.png):
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

; === a ===
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

; tests
; > m
; ((2 ((6 100) (8 ((5 ((7 107) (10 93))) (4 37))))) (3 23))
; > (left-branch m7n10)
; (7 107)
; > (right-branch m7n10)
; (10 93)
; > (left-branch m5n4)
; (5 ((7 107) (10 93)))
; > (right-branch m5n4)
; (4 37)
; > (branch-length b7)
; 7
; > (branch-length b8)
; 8
; > (branch-length b3)
; 3
; > (branch-structure b7)
; 107
; > (branch-structure b3)
; 23
; > (branch-structure b8)
; ((5 ((7 107) (10 93))) (4 37))
; > (branch-length b5)
; 5
; > (branch-structure b5)
; ((7 107) (10 93))
; > 

; === b ===
(define (total-weight mobile)
  (cond ((null? mobile) 0)
        ((not (pair? mobile)) mobile)  ; a single number weight. although it is not a mobile, we need it as a base case of the recursion.
        (else (+ (total-weight (branch-structure (left-branch mobile)))
                 (total-weight (branch-structure (right-branch mobile)))))))

; tests
; > (total-weight m)
; 360
; >

; === c ===
; a mobile is balanced if all three conditions are satisfied:
; 1). (branch-length left) * (total-weight structure_of_left) is equal to (branch-length right) * (total-weight structure_of_right)
; 2). structure_of_left is balanced
; 3). structure_of_right is balanced
; base case:
; a single number of weight is ALWAYS balanced
(define (balanced? mobile)
  (cond ((null? mobile) #t)  ; empty list is balanced (base case)
        ((not (pair? mobile)) #t)  ; a single number weight is balanced (base case)
        ((not (balanced? (branch-structure (left-branch mobile)))) #f)  ; if left branch structure is not balanced, the mobile is not balanced
        ((not (balanced? (branch-structure (right-branch mobile)))) #f)  ; if right branch structure is not balanced, the mobile is not balanced
        (else (let ((left (left-branch mobile)) (right (right-branch mobile)))  ; else, compute if length_left * weight_left == length_right * weight_right
                (= (* (branch-length left) (total-weight (branch-structure left)))
                   (* (branch-length right) (total-weight (branch-structure right))))))))

; tests
; === 1 ===
; > (balanced? (list))
; #t
; > (balanced? 5)
; #t
; > (balanced? m7n10)
; #f
; > (balanced? m5n4)
; #f
; > (balanced? m6n8)
; #f
; > (balanced? m)
; #f
; >
; === 2 ===
; first let's build another binary mobile (image in 29_2):
(define b-4 (make-branch 4 3))
(define b-2 (make-branch 2 6))
(define m-4n-2 (make-branch b-4 b-2))
(define b-8 (make-branch 8 m-4n-2))
(define b-36 (make-branch 36 2))
(define mm (make-branch b-8 b-36))
; > (balanced? m-4n-2)
; #t
; > (balanced? mm)
; #t
; > (define b-36 (make-branch 36 2.1))
; > (define mmm (make-branch b-8 b-36))
; > (balanced? mmm)
; #f
; > (define b-35 (make-branch 35 2))
; > (define mmmm (make-branch b-8 b-35))
; > (balanced? mmmm)
; #f
; >
