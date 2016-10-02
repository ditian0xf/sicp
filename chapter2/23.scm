;-----
;2.23
;-----

; observe:
; > (define (g x)
;     (/ x 4)
;     (/ x 5))
; > (g 1)
; 1/5
; > (g 4)
; 4/5
; > (g 5)
; 1
; >
; therefore (g x) evaluates to (/ x 5)

(define (for-each proc list)
  (define (apply-then-move-on proc list)
    (proc (car list))
    (for-each proc (cdr list)))
  (if (null? list)
      #t
      (apply-then-move-on proc list)))

; > (for-each (lambda (x) (newline) (display x)) (list))
; #t
; > (for-each (lambda (x) (newline) (display x)) (list 1 2 3 4 5))
;
; 1 
; 2
; 3
; 4
; 5#t
; > (for-each (lambda (x) (newline) (display x)) (list 57 321 88))
; 
; 57
; 321
; 88#t
; >
