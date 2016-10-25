;-----
;2.48
;-----

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

;----- actual solution -----
(define (make-segment v1 v2)
  (list v1 v2))

(define (start-segment seg)
  (cadar seg))

(define (end-segment seg)
  (cadadr seg))

; tests
; > (define s (make-segment (make-vect (list 0 0) (list 5 -3)) (make-vect (list 0 0) (list -5 10))))
; > s
; (((0 0) (5 -3)) ((0 0) (-5 10)))
; > (start-segment s)
; (5 -3)
; > (end-segment s)
; (-5 10)
; >


