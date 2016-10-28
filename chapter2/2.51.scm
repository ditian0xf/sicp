;-----
;2.51
;-----

#lang racket
(require (planet soegaard/sicp:2:1/sicp))

; transform-painter in this package is a little bit different from the text book:
; transform-painter : origin corner1 corner2 -> (painter -> painter)

;----- approach 1 -----
(define (below1 painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-top
           ((transform-painter
            split-point
            (make-vect 1.0 0.5)
            (make-vect 0.0 1.0)) painter1))
          (paint-bottom
           ((transform-painter
             (make-vect 0.0 0.0)
             (make-vect 1.0 0.0)
             split-point) painter2)))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))

; ----- approach 2 -----
(define (below2 painter1 painter2)
  (rotate90 (beside (rotate270 painter1) (rotate270 painter2))))

