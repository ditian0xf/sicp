;-----
;2.39
;-----

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; remember the fold-right evaluation process:
; {E_0 ... {E_n-2 {E_n-1 Initial}}}
(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) (list) sequence))  ; example: (op 1 (5 4 3 2))

; tests
; > (reverse (list))
; ()
; > (reverse (list 1))
; (1)
; > (reverse (list 1 2))
; (2 1)
; > (reverse (list 1 2 3))
; (3 2 1)
; >

; remember the fold-left evaluation process:
; {{{Initial E_0} E_1} ... E_n-1}
(define (reverse-fold-left sequence)
  (fold-left (lambda (x y) (cons y x)) (list) sequence))  ; example: (op (4 3 2 1) 5)

; tests
; > (reverse-fold-left (list))
; ()
; > (reverse-fold-left (list 1))
; (1)
; > (reverse-fold-left (list 1 2))
; (2 1)
; > (reverse-fold-left (list 1 2 3))
; (3 2 1)
; >

; the fold-left version is better.
