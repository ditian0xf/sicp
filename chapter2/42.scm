;-----
;2.42
;-----

(define (filter predicate seq)
  (if (null? seq)
      (list)
      (let ((head (car seq)) (rest (cdr seq)))
        (if (predicate head)
            (cons head (filter predicate rest))
            (filter predicate rest)))))

(define (enumerate-interval low high)
  (if (> low high)
      (list)
      (cons low (enumerate-interval (+ 1 low) high))))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(define (flatmap proc seq)
  (accumulate append (list) (map proc seq)))

; ======
; it seems the form of one possible solution should be
; ((row, col), (row, col),..., (row, col))

(define empty-board (list))

(define (adjoin-position new-row col rest-of-queens)
  (append rest-of-queens (list (list new-row col))))

(define (get-position-at-col col positions)
  (if (= 1 col)
      (car positions)
      (get-position-at-col (- col 1) (cdr positions))))

(define (safe-horizontal? new-position positions)
  (= 1 (length (filter
                (lambda (position) (= (car position) (car new-position)))
                positions))))

(define (safe-diagonal? new-position positions)
  (= 1 (length (filter
                (lambda (position) (= (abs (- (car position) (car new-position)))
                                      (abs (- (cadr position) (cadr new-position)))))
                positions))))

(define (safe? col positions)
  (let ((position-at-col (get-position-at-col col positions)))
    (and (safe-horizontal? position-at-col positions)
         (safe-diagonal? position-at-col positions))))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

; tests
; > (queens 0)
; (())
; > (queens 1)
; (((1 1)))
; > (queens 2)
; ()
; > (queens 3)
; ()
; > (queens 4)
; (((2 1) (4 2) (1 3) (3 4)) ((3 1) (1 2) (4 3) (2 4)))
; > (queens 5)
; (((1 1) (3 2) (5 3) (2 4) (4 5))
;  ((1 1) (4 2) (2 3) (5 4) (3 5))
;  ((2 1) (4 2) (1 3) (3 4) (5 5))
;  ((2 1) (5 2) (3 3) (1 4) (4 5))
;  ((3 1) (1 2) (4 3) (2 4) (5 5))
;  ((3 1) (5 2) (2 3) (4 4) (1 5))
;  ((4 1) (1 2) (3 3) (5 4) (2 5))
;  ((4 1) (2 2) (5 3) (3 4) (1 5))
;  ((5 1) (2 2) (4 3) (1 4) (3 5))
;  ((5 1) (3 2) (1 3) (4 4) (2 5)))
; > (length (queens 5))
; 10
; > (queens 6)
; (((2 1) (4 2) (6 3) (1 4) (3 5) (5 6)) ((3 1) (6 2) (2 3) (5 4) (1 5) (4 6)) ((4 1) (1 2) (5 3) (2 4) (6 5) (3 6)) ((5 1) (3 2) (1 3) (6 4) (4 5) (2 6)))
; > (length (queens 6))
; 4
; > (length (queens 7))
; 40
; > (length (queens 8))
; 92
; > (length (queens 9))
; 352
; > (length (queens 10))
; 724
; > (length (queens 11))
