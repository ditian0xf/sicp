;-----
;2.2
;-----

; point
(define (make-point x y)
  (cons x y))

(define (x-point p)
  (car p))

(define (y-point p)
  (cdr p))

(define (equal-point p1 p2)
  (and (= (x-point p1) (x-point p2))
       (= (y-point p1) (y-point p2))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ", ")
  (display (y-point p))
  (display ")"))

; line segment
(define (make-segment start end)  ; start and end are points
  (cons start end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (midpoint-segment segment)
  (define (average x y) (/ (+ x y) 2))
  (let ((start (start-segment segment)) (end (end-segment segment)))
    (let ((x-start (x-point start))
          (y-start (y-point start))
          (x-end (x-point end))
          (y-end (y-point end)))
      (make-point (average x-start x-end) (average y-start y-end)))))

(define (perpendicular?　seg1 seg2)
  (let ((start1 (start-segment seg1))
        (end1 (end-segment seg1))
        (start2 (start-segment seg2))
        (end2 (end-segment seg2)))
    (let ((vector1 (cons (- (x-point end1) (x-point start1))
                         (- (y-point end1) (y-point start1))))
          (vector2 (cons (- (x-point end2) (x-point start2))
                         (- (y-point end2) (y-point start2)))))
      (= 0 (+ (* (car vector1) (car vector2))
              (* (cdr vector1) (cdr vector2)))))))

(define (segment-length seg)
  (let ((start (start-segment seg))
        (end (end-segment seg)))
    (sqrt (+ (expt (- (x-point start) (x-point end)) 2)
             (expt (- (y-point start) (y-point end)) 2)))))


; test
;(define p1 (make-point 0.5 -1.8))
;(define p2 (make-point 32 47))
;(define segment (make-segment p1 p2))
;(define midpoint (midpoint-segment segment))
;(print-point midpoint)
