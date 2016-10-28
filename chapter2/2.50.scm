;-----
;2.50
;-----

#lang racket
(require (planet soegaard/sicp:2:1/sicp))

; transform-painter in this package is a little bit different from the text book:
; transform-painter : origin corner1 corner2 -> (painter -> painter)

(define flip-horiz
  (transform-painter (make-vect 1.0 0.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

(define rotate180
  (transform-painter (make-vect 1.0 1.0)
                     (make-vect 0.0 1.0)
                     (make-vect 1.0 0.0)))

(define rotate270
  (transform-painter (make-vect 0.0 1.0)
                     (make-vect 0.0 0.0)
                     (make-vect 1.0 1.0)))

