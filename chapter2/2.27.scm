;-----
;2.27
;-----

; example walk throughs in 27.png

(define (deep-reverse x)
  (cond ((null? x) x)  ; input is an empty list
        ((not (pair? x)) x)  ; input is a single number (NOT a one-item list); this happens near the end of recursion
        (else (append (deep-reverse (cdr x)) (list (deep-reverse (car x)))))))

; tests
; > (deep-reverse (list))
; ()
; > (deep-reverse (list 3))
;(3)
; > (deep-reverse (list (list 3) (list)))
; (() (3))
; > (deep-reverse (list (list 1 2) (list)))
; (() (2 1))
; > (deep-reverse (list (list 3 4) (list 5)))
; ((5) (4 3))
; > (deep-reverse (list (list 1 2) (list 3 4)))
; ((4 3) (2 1))
; > (deep-reverse (list (list 1 2) (list 3 (list 4 5)) 6))
; (6 ((5 4) 3) (2 1))
; >
