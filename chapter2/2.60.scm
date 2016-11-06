;-----
;2.60
;-----

(define (element-of-set? x set)  ; THETA(N)
  (cond ((null? set) #f)
        ((equal? x (car set)) #t)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)  ; THETA(1), improved from THETA(N)
  (cons x set))

(define (intersection-set set1 set2)  ; THETA(N^2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

(define (union-set set1 set2)  ; THETA(N), improved from THETA(N^2)
  (append set1 set2))

; This representation would be preferred over the original in cases where 
; we don't care about that added memory overhead, and where 
; most of our operations are either adjoin-set or union-set.









