;-----
;2.33
;-----

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map_my p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) (list) sequence))  ; x <--> (car sequence), y <--> (accumulate op initial (cdr sequence))

; tests
; > (define (double x) (+ x x))
; > (map_my double (list))
; ()
; > (map_my double (list 1))
; (2)
; > (map_my double (list 1 2 3 4 5))
; (2 4 6 8 10)
; >

(define (append_my seq1 seq2)
  (accumulate cons seq2 seq1))

; tests
; > (append_my (list) (list))
; ()
; > (append_my (list) (list 1 2))
; (1 2)
; > (append_my (list 6 7) (list))
; (6 7)
; > (append_my (list 7 6) (list 5 4 3))
; (7 6 5 4 3)
; > (append_my (list 5 4 3) (list 0 1))
; (5 4 3 0 1)
; >

(define (length_my sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

; tests
; > (length_my (list))
; 0
; > (length_my (list 5))
; 1
; > (length_my (list 5 6 7))
; 3
; > (length_my (list 4 1))
; 2
; >

