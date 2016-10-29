;-----
;2.52.a
;-----

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

;----- segment utility -----
(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment seg)
  (car seg))

(define (end-segment seg)
  (cadr seg))

;----- segments->painter -----
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

(define (wave->painter frame)
  (define segment-list
    (let ((v0 (make-vect 0.55 1))
          (v1 (make-vect 0.6 0.85))
          (v2 (make-vect 0.55 0.7))
          (v3 (make-vect 1 0.4))
          (v4 (make-vect 1 0.3))
          (v5 (make-vect 0.55 0.5))
          (v6 (make-vect 0.7 0))
          (v7 (make-vect 0.6 0))
          (v8 (make-vect 0.5 0.35))
          (v9 (make-vect 0.4 0))
          (v10 (make-vect 0.3 0))
          (v11 (make-vect 0.45 0.5))
          (v12 (make-vect 0.2 0.35))
          (v13 (make-vect 0 0.5))
          (v14 (make-vect 0 0.6))
          (v15 (make-vect 0.2 0.45))
          (v16 (make-vect 0.45 0.7))
          (v17 (make-vect 0.4 0.85))
          (v18 (make-vect 0.45 1))
          (v19 (make-vect 0.55 0.77))
          (v20 (make-vect 0.53 0.75))
          (v21 (make-vect 0.47 0.75))
          (v22 (make-vect 0.45 0.77)))
      (list (make-segment v0 v1)
            (make-segment v1 v2)
            (make-segment v2 v3)
            (make-segment v3 v4)
            (make-segment v4 v5)
            (make-segment v5 v6)
            (make-segment v6 v7)
            (make-segment v7 v8)
            (make-segment v8 v9)
            (make-segment v9 v10)
            (make-segment v10 v11)
            (make-segment v11 v12)
            (make-segment v12 v13)
            (make-segment v13 v14)
            (make-segment v14 v15)
            (make-segment v15 v16)
            (make-segment v16 v17)
            (make-segment v17 v18)
            (make-segment v18 v0)
            (make-segment v19 v20)
            (make-segment v20 v21)
            (make-segment v21 v22))))
  ((segments->painter segment-list) frame))

(send dc clear)
(wave->painter (make-frame (make-vect 0 0)
                           (make-vect 300 0)
                           (make-vect 0 300)))
(send target save-file "2.52.a.png" 'png)


