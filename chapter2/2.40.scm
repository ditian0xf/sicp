;-----
;2.40
;-----

(define (enumerate-interval low high)
  (if (> low high)
      (list)
      (cons low (enumerate-interval (+ 1 low) high))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append (list) (map proc seq)))

(define (unique-pairs n)
  (flatmap (lambda (i) (map (lambda (j) (list i j))  ; form a pair (i, j)
                            (enumerate-interval 1 (- i 1))))  ; for each j in [1, n-1]
           (enumerate-interval 2 n)))  ; for each i in [2, n]

; tests
; > (unique-pairs 0)
; ()
; > (unique-pairs 1)
; ()
; > (unique-pairs 2)
; ((2 1))
; > (unique-pairs 3)
; ((2 1) (3 1) (3 2))
; > (unique-pairs 4)
; ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3))
; >

; prime-sum-pairs turns into
(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))






