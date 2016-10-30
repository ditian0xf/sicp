;-----
;2.54
;-----

; before wrting solution, a few experiments:
; > (pair? 3)
; #f
; > (pair? (list))
; #f
; > (pair? (list 3))
; #t
; > (pair? (list 3 4))
; #t
; > (eq? 3 4)
; #f
; > (eq? (list) (list))
; #t
; > (eq? (list 1 2) (list 1 2))
; #f
; > (eq? (list 1) (list 1))
; #f
; > 

(define (equal? list1 list2)
  (cond ((and (not (pair? list1)) (not (pair? list2))) (eq? list1 list2))
        ((and (pair? list1) (pair? list2)) (and (equal? (car list1) (car list2))
                                                (equal? (cdr list1) (cdr list2))))
        (else #f)))

; tests
; > (equal? 3 3)
; #t
; > (equal? 3 4)
; #f
; > (equal? 3 (list))
; #f
; > (equal? 3 (list 1))
; #f
; > (equal? 3 (list 1 2 3))
; #f
; > (equal? (list) 3)
; #f
; > (equal? (list) (list))
; #t
; > (equal? (list) (list 1))
; #f
; > (equal? (list) (list 1 2))
; #f
; > (equal? (list 1) (list))
; #f
; > (equal? (list 1) 3)
; #f
; > (equal? (list 1) (list 1))
; #t
; > (equal? (list 1) (list 1 2))
; #f
; > (equal? (list 1 2) (list 1))
; #f
; > (equal? (list 1 2) (list 1 2))
; #t
; > (equal? (list 1 2) (list 2 1))
; #f
; > (equal? (list 1 2) (list 1 2 3))
; #f
; > (equal? (list 1 2 3) (list 1 2 3))
; #t
; > (equal? (list 1 2 3) (list 1 3 2))
; #f
; >

