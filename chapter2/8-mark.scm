;-----
;2.8
;-----

(load "7_interval.scm")

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

; [xL, xH]
; [yL, yH]
; The smallest value possible is xL + yL,
; the largest value possible is  xH + yH,
; therefore the interval is
; [xL + yL, xH + yH]

; When it comes to subtraction,
; the smallest value possible is xL - yH,
; the largest value possible is xH - yL,
; therefore the interval is
; [xL - yH, xH - yL]

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

#| test

> (define interval1 (make-interval 1 8))
> (define interval2 (make-interval 2 6))
> (add-interval interval1 interval2)
(3 . 14)
> (sub-interval interval1 interval2)
(-5 . 6)

|#