;-----
;2.17
;-----

; assume input-list is non-empty
(define (last-pair input-list)
  (if (null? (cdr input-list))  ; reaching the last item
      (car input-list)
      (last-pair (cdr input-list))))

; test
; > (define input-list (list 1))
; > (last-pair input-list)
; 1
; > (define input-list (list 2 1 3))
; > (last-pair input-list)
; 3
; >
