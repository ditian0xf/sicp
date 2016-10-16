;-----
;2.37
;-----

(define (accumulate op init sequence)
  (if (null? sequence)
      init
      (op (car sequence)
          (accumulate op init (cdr sequence)))))

(define (accumulate-n op init seqs)  ; assumption: all sequences have same number of items
  (if (null? (car seqs))
      (list)
      (cons (accumulate op init (map car seqs))  ; the last parameter should be a list containing the first items of each sequence
            (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (row) (dot-product row v)) m))  ; for each row of m, dot product v

; test
; > (define m (list (list 1 2 3) (list 4 5 6)))
; > (define v (list 7 8 9))
; > (matrix-*-vector m v)
; (50 122)
; >

(define (transpose mat)
  (accumulate-n cons (list) mat))

; tests
; > (define m (list (list 1 2 3) (list 4 5 6)))
; > (transpose m)
; ((1 4) (2 5) (3 6))
; > (define m (list (list 1 2) (list 4 5) (list 7 8)))
; > (transpose m)
; ((1 4 7) (2 5 8))
; > (define m (list (list 1 2 3)))
; > (transpose m)
; ((1) (2) (3))
; > (define m (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
; > (transpose m)
; ((1 4 7) (2 5 8) (3 6 9))
; >

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row) (matrix-*-vector cols row))m)))

; test
; > (define m (list (list 1 2 3) (list 4 5 6)))
; > (define n (list (list 7 8) (list 9 10) (list 11 12)))
; > (matrix-*-matrix m n)
; ((58 64) (139 154))
; >

