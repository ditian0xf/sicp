;-----
;2.55
;-----

; example:
; > '(+ 3 4 5)
; (+ 3 4 5)
; > (car '(+ 3 4 5))
; +
; > (cdr '(+ 3 4 5))
; (3 4 5)
; >

; we can see that
; '(+ 3 4 5) returns a SYMBOL LIST (+ 3 4 5)
; whose first element is symbol +
; the rest elements are contained in the sublist (3 4 5)

; ''abracadabra <==>
; (quote (quote abracadabra)) <==>
; '(quote abracadabra)
; which returns a symbol list (quote abracadabra)
; whose first element is symbol quote


