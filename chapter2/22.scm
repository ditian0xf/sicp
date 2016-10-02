;-----
;2.22
;-----

; (square (1 2 3)) ==>
; (iter (1 2 3) nil) ==>
; (iter (2 3) (1)) ==>
; (iter (3) (4 1)) ==>
; (iter () (9 4 1)) ==>
; (9 4 1)

(define (square x) (* x x))

(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items (list)))

; test
; > (square-list (list 1 2 3 4))
; ((((() . 1) . 4) . 9) . 16)
; >

; (cons x y) does not work that way
; (cons number list) ==> an expanded list with number as the first item
; > (cons 1 (list 2))
; (1 2)
; (cons list number) ==> a pair (list, number)
; > (cons (list 1) 2)
; ((1) . 2)
