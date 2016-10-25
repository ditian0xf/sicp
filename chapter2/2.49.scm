;-----
;2.49
;-----

#lang racket

(require (lib "racket/draw"))
(require racket/class)

(define target (make-bitmap 500 500))
(define dc (new bitmap-dc% [bitmap target]))

;----- vect utility -----
(define (make-vect x y)
  (list x y))

(define (xcor-vect v)
  (car v))

(define (ycor-vect v)
  (cadr v))

(define (add-vect u v)
  (make-vect (+ (xcor-vect u) (xcor-vect v))
             (+ (ycor-vect u) (ycor-vect v))))

(define (sub-vect u v)
  (make-vect (- (xcor-vect u) (xcor-vect v))
             (- (ycor-vect u) (ycor-vect v))))

(define (scale-vect s v)
  (make-vect (* s (xcor-vect v)) (* s (ycor-vect v))))

;----- frame utility -----
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))

; ----- segment utility -----
(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cadr seg))

; ----- segments->painter -----
(define (my-draw-line v1 v2)
  (send dc draw-line
        (xcor-vect v1) (ycor-vect v1)
        (xcor-vect v2) (ycor-vect v2)))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (my-draw-line
        ((frame-coord-map frame)
         (start-segment segment))
        ((frame-coord-map frame)
         (end-segment segment))))
     segment-list)))

; ----- the solution -----
; --- a ---
(define (frame-outline->painter frame)
  (define segment-list
    (let ((origin (make-vect 0 0))
          (vertex1 (make-vect 1 0))
          (vertex2 (make-vect 0 1))
          (vertex3 (make-vect 1 1)))
      (list (make-segment origin vertex1)
            (make-segment vertex1 vertex3)
            (make-segment vertex3 vertex2)
            (make-segment vertex2 origin))))
  ((segments->painter segment-list) frame))

(send dc clear)
(frame-outline->painter (make-frame (make-vect 50 50)
                                    (make-vect 250 50)
                                    (make-vect 150 150)))
(send target save-file "2.49.a.png" 'png)
