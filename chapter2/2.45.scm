;-----
;2.45
;-----

#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

(define (split first then)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller (split painter (- n 1))))
          (first painter (then smaller smaller))))))

(define (r-split) (split beside below))



