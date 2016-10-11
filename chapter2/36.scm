;-----
;2.36
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

; tests
; > (define x (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
; > (accumulate-n + 0 x)
; (22 26 30)
; > (accumulate-n cons (list) x)
; ((1 4 7 10) (2 5 8 11) (3 6 9 12))
; >


