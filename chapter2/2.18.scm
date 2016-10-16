;-----
;2.18
;-----

; reverse a list

; (1 2 3 4 5)
; suppose cdr is reversed: (5 4 3 2)
; then (append (5 4 3 2) (1))

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (reverse input-list)
  (if (null? (cdr input-list))
      input-list
      (append (reverse (cdr input-list)) (list (car input-list)))))

; test
; > (reverse (list 1))
; (1)
; > (reverse (list 1 2 3 4 5))
; (5 4 3 2 1)
; > (reverse (list 1 4 9 16 25))
; (25 16 9 4 1)
; >
