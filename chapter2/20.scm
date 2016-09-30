;-----
;2.20
;-----

; (same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
; (same-parity 2 3 4 5 6 7)
; (2 4 6)

(define (same-parity first . rest)  ; dotted-tail notation, indicating that rest is a list
  (define (same-parity? x y)  ; a procedure that checks if two numbers are of the same parity
    (= (modulo x 2) (modulo y 2)))
  (define (generate-list list-so-far list-rest)
    (if (null? list-rest)  ; if the remaining list is empty
        list-so-far  ; the result is list-so-far
        (if (same-parity? (car list-so-far) (car list-rest))  ; if (car list-rest) is of the same parity
            (generate-list (append list-so-far (list (car list-rest))) (cdr list-rest))  ; append it to the tail of list-so-far
            (generate-list list-so-far (cdr list-rest)))))
  (generate-list (list first) rest))

; tests
; > (same-parity 1)
; (1)
; > (same-parity 2)
; (2)
; > (same-parity 1 2 3 4 5 6 7)
; (1 3 5 7)
; > (same-parity 2 3 4 5 6 7)
; (2 4 6)
; >
