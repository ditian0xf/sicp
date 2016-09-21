;-----
;2.11
;-----
#lang racket

(define (make-interval a b) (cons a b))

(define (lower-bound interval)
  (let ((first (car interval)) (second (cdr interval)))
    (if (< first second)
        first
        second)))

(define (upper-bound interval)
  (let ((first (car interval)) (second (cdr interval)))
    (if (< first second)
        second
        first)))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

; about break into 9 cases (- stands for <=0, + stands for >=0):
; [xl xh] <-- [- -], [- +], [+ +]
; [yl yh] <-- [- -], [- +], [+ +]
; 3 * 3 = 9
; [- -] * [- -] --> [xh * yh xl * yl]
; [- -] * [- +] --> [xl * yh xl * yl]
; [- -] * [+ +] --> [xl * yh xh * yl]
; [- +] * [- -] --> [xh * yl xl * yl]
; [- +] * [- +] --> ?
; [- +] * [+ +] --> [xl * yh xh * yh]
; [+ +] * [- -] --> [xh * yl xl * yh]
; [+ +] * [- +] --> [xh * yl xh * yh]
; [+ +] * [+ +] --> [xl * yl xh * yh]

(define (mul-interval-new x y)
  (let ((xl (lower-bound x))
        (xh (upper-bound x))
        (yl (lower-bound y))
        (yh (upper-bound y)))
    (cond ((and (<= xl 0) (<= xh 0)) (cond ((and (<= yl 0) (<= yh 0)) (make-interval (* xh yh) (* xl yl)))
                                           ((and (<= yl 0) (>= yh 0)) (make-interval (* xl yh) (* xl yl)))
                                           (else (make-interval (* xl yh) (* xh yl)))))
          ((and (<= xl 0) (>= xh 0)) (cond ((and (<= yl 0) (<= yh 0)) (make-interval (* xh yl) (* xl yl)))
                                           ((and (>= yl 0) (>= yh 0)) (make-interval (* xl yh) (* xh yh)))
                                           (else (let ((p1 (* xl yl))
                                                       (p2 (* xl yh))
                                                       (p3 (* xh yl))
                                                       (p4 (* xh yh))) (make-interval (min p1 p2 p3 p4)
                                                                                      (max p1 p2 p3 p4))))))
          ((and (>= xl 0) (>= xh 0)) (cond ((and (<= yl 0) (<= yh 0)) (make-interval (* xh yl) (* xl yh)))
                                           ((and (<= yl 0) (>= yh 0)) (make-interval (* xh yl) (* xh yh)))
                                           (else (make-interval (* xl yl) (* xh yh))))))))

; testing procedures
(define (random-integer bound)
  (let ((sign (random 10))
        (abs-value (random bound)))
    (if (>= sign 5)
        (- 0 abs-value)
        abs-value)))

(define (equal-interval x y)
  (and ( = (lower-bound x) (lower-bound y))
       ( = (upper-bound x) (upper-bound y))))

(define (single-test)
  (let ((x (make-interval (random-integer 100) (random-integer 100)))
        (y (make-interval (random-integer 100) (random-integer 100))))
    (equal-interval (mul-interval x y) (mul-interval-new x y))))

(define (batch-test how-many-single-test)
  (if (= 0 how-many-single-test)
      (display "Test succeeded!")
      (if (single-test)
          (batch-test (- how-many-single-test 1))
          (display "An error occured!"))))

#| test results

> (batch-test 0)
Test succeeded!
> (batch-test 1)
Test succeeded!
> (batch-test 10)
Test succeeded!
> (batch-test 100)
Test succeeded!
> (batch-test 1000)
Test succeeded!
> (batch-test 10000)
Test succeeded!
> (batch-test 100000)
Test succeeded!
> 

however, if we change our (mul-interval-new x y) a little bit, say
changing (else (make-interval (* xl yl) (* xh yh)))))))) to
(else (make-interval (* xl yl) (* xh yl))))))))

> (batch-test 0)
Test succeeded!
> (batch-test 1)
Test succeeded!
> (batch-test 10)
Test succeeded!
> (batch-test 100)
An error occured!
> (batch-test 1000)
An error occured!
> (batch-test 10000)
An error occured!
> (batch-test 100000)
An error occured!
>

in conclusion, the new multiplication procedure works well.
|#