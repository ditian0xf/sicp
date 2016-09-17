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

; test
;(define p1 (make-point 0.5 -1.8))
;(define p2 (make-point 32 47))
;(define segment (make-segment p1 p2))
;(define midpoint (midpoint-segment segment))
;(print-point midpoint)
