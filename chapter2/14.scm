;-----
;2.14
;-----

(load "interval_utility.scm")

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
     one
     (add-interval (div-interval one r1)
                   (div-interval one r2)))))

; test -- parallel resistances
; > (define r (make-interval 7 9))
; > r
; (7 . 9)
; > (par1 r r)
; (2.722222222222222 . 5.785714285714286)
; > (par2 r r)
; (3.5 . 4.5)
; >

; (3.5 . 4.5) is correct. why?
; 7 and 7 is 3.5
; 7 and 9 is 3.9375
; 9 and 9 is 4.5
; so the interval is [3.5, 4.5]

;********************;

; test -- error of interval division
; > (define i1 (make-interval 990 1010))
; > (define div-i1-i1 (div-interval i1 i1))
; > (percent i1)
; 1
; > (percent div-i1-i1)
; 1.9998000199979968
; > (define i2 (make-interval 495 505))
; > (percent i2)
; 1
; > (define div-i1-i2 (div-interval i1 i2))
; > (percent div-i1-i2)
; 1.9998000199979968
; > (define i3 (make-interval 490 510))
; > (percent i3)
; 2
; > (define div-i1-i3 (div-interval i1 i3))
; > (percent div-i1-i3)
; 2.9994001199760123
; > (define i4 (make-interval 900 1100))
; > (percent i4)
; 10
; > (define div-i1-i4 (div-interval i1 i4))
; > (percent div-i1-i4)
; 10.989010989010989
; > 

; we can see that, for intervals with small percentage tolerance, say
; i1 with percentage tolerance t1, i2 with percentage tolerance t2
; the percentage tolerance of (div-interval i1 i2) is
; t1 + t2

; why?
; suppose all following numbers are positive.
; (div-interval i1 i2) is
; [(1 - t1)/(1 + t2) * i1/i2, (1 + t1)/(1 - t2) * i1/i2]
; the percentage tolerance is
; (t1 + t2)/(1 + t1*t2)
; since t1 and t2 are very small, t1 * t2 is even smaller, 1 + t1*t2 is almost 1.
; (t1 + t2)/(1 + t1*t2) is almost (t1 + t2).


