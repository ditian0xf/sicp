;-----
;2.41
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

(define (three-sum n s)
  (define (sum-s? triple)
  (= s (+ (car triple)
          (cadr triple)
          (caddr triple))))
  (filter sum-s?
          (flatmap (lambda (pair) (map (lambda (k) (append pair (list k)))
                                       (enumerate-interval 1 (- (cadr pair) 1))))  ; for each k in range [1, j-1]
                   (flatmap (lambda (i) (map (lambda (j) (list i j))
                                             (enumerate-interval 1 (- i 1))))  ; for each j in range [1, i-1]
                            (enumerate-interval 1 n)))))  ; for each i in range [1, n]

; tests
; > (three-sum 10 3)
; ()
; > (three-sum 3 10)
; ()
; > (three-sum 10 4)
; ()
; > (three-sum 10 5)
; ()
; > (three-sum 4 10)
; ()
; > (three-sum 5 10)
; ((5 3 2) (5 4 1))
; > (three-sum 6 10)
; ((5 3 2) (5 4 1) (6 3 1))
; > (three-sum 7 10)
; ((5 3 2) (5 4 1) (6 3 1) (7 2 1))
; > (three-sum 8 10)
; ((5 3 2) (5 4 1) (6 3 1) (7 2 1))
; >




