;-----
;2.3
;-----

(load "2_point_and_segment.scm")

; perimeter of rectangle
(define (perimeter rectangle)
  (let ((dim1 (get-dim1 rectangle)) (dim2 (get-dim2 rectangle)))
    (* 2 (+ dim1 dim2))))

; area of rectangle
(define (area rectangle)
  (let ((dim1 (get-dim1 rectangle)) (dim2 (get-dim2 rectangle)))
    (* dim1 dim2)))

; representation 1
; --- seg1 ---
; |      
; |
; seg2
; |
(define (alert)
  ;(newline)
  (display "not a valid rectangle!"))

(define (make-rectangle seg1 seg2)
  (if (or (not (equal-point (start-segment seg1) (start-segment seg2)))  ; not started at the same point
          (not (perpendicular? seg1 seg2)))  ; or not perpendicular to each other
      (alert)
      (cons seg1 seg2)))

(define (get-dim1 rectangle)
  (segment-length (car rectangle)))

(define (get-dim2 rectangle)
  (segment-length (cdr rectangle)))

#| test
> (define seg1 (make-segment (make-point 0 0) (make-point 0 5)))
> (define seg2 (make-segment (make-point 0 0) (make-point 8 0)))
> (define rectangle (make-rectangle seg1 seg2))
> rectangle
(((0 . 0) 0 . 5) (0 . 0) 8 . 0)
> (perimeter rectangle)
26
> (area rectangle)
40
> (define seg2 (make-segment (make-point 0 1) (make-point 8 0)))
> (define rectangle (make-rectangle seg1 seg2))
not a valid rectangle!
> (define seg2 (make-segment (make-point 0 0) (make-point 8 -1)))
> (define rectangle (make-rectangle seg1 seg2))
not a valid rectangle!
>
|#

; representation 2
; origin --- vertex1
;   |
;   |
;   |
; vertex2
(define (make-rectangle origin vertex1 vertex2)
  (if (not (perpendicular? (make-segment origin vertex1) (make-segment origin vertex2)))
      (alert)
      (cons origin (cons vertex1 vertex2))))

(define (get-dim1 rectangle)
  (segment-length (make-segment (car rectangle) (car (cdr rectangle)))))

(define (get-dim2 rectangle)
  (segment-length (make-segment (car rectangle) (cdr (cdr rectangle)))))

#| test
> (define rectangle (make-rectangle (make-point 0 0) (make-point 0 5) (make-point 8 0)))
> (perimeter rectangle)
26
> (area rectangle)
40
> (define rectangle (make-rectangle (make-point 0 0) (make-point 1 5) (make-point 8 0)))
not a valid rectangle!
|#
