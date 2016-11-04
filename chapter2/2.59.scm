;-----
;2.59
;-----

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (union-set set1 set2)  ; let's keep reducing set1 and expanding set2, until set1 is empty.
  (if (null? set1)
      set2
      (let ((x (car set1)))
        (if (element-of-set? x set2)
            (union-set (cdr set1) set2)
            (union-set (cdr set1) (cons x set2))))))

; tests
; > (union-set (list) (list))
; ()
; > (union-set (list) (list 1))
; (1)
; > (union-set (list) (list 1 2 3))
; (1 2 3)
; > (union-set (list 1) (list))
; (1)
; > (union-set (list 1 2 3) (list))
; (3 2 1)
; > (union-set (list 1) (list 1))
; (1)
; > (union-set (list 1 2) (list 1 2))
; (1 2)
; > (union-set (list 1 2) (list 1 2 3))
; (1 2 3)
; > (union-set (list 1 2 3 4) (list 1 2 3))
; (4 1 2 3)
; > (union-set (list 2 5 7) (list 1 3 7 9))
; (5 2 1 3 7 9)
; > 

