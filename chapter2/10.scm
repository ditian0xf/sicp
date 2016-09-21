;-----
;2.10
;-----

(load "7_interval.scm")

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (= 0 (- (upper-bound y) (lower-bound y)))
      (display "undefined: divided by interval that spans zero")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))
                      (/ 1.0 (lower-bound y))))))

#| test

> (define interval1 (make-interval 2 4))
> (define interval2 (make-interval 16 32))
> (div-interval interval1 interval2)
(0.0625 . 0.25)
> (define interval2 (make-interval 16 16))
> (div-interval interval1 interval2)
undefined: divided by interval that spans zero

|#