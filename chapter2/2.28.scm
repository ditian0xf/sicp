;-----
;2.28
;-----

(define (fringe x)
  (cond ((null? x) x)  ; if input is (), output will be ().
        ((not (pair? x)) (list x))  ; if input is a single number (NOT a one-item list), output will be (the single number).
        (else (append (fringe (car x)) (fringe (cdr x))))))  ; combine the results from the first subtree and the rest subtrees.

; tests
; > (fringe (list))
; ()
; > (fringe (list 6))
; (6)
; > (fringe (list 6 7))
; (6 7)
; > (fringe (list (list 1 2) (list 3 4)))
; (1 2 3 4)
; > (fringe (list (list 3 (list 4)) 5 (list (list 6))))
; (3 4 5 6)
; > (define x (list (list 1 2) (list 3 4)))
; > (fringe x)
; (1 2 3 4)
; > (fringe (list x x))
; (1 2 3 4 1 2 3 4)
; > (fringe (list x x 5 x))
; (1 2 3 4 1 2 3 4 5 1 2 3 4)
; >
