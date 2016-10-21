;-----
;2.46
;-----

#lang racket
(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))

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

; tests
; > (define v (make-vect -9 3))
; > (define u (make-vect 4 -2))
; > (xcor-vect v)
; -9
; > (ycor-vect v)
; 3
; > (ycor-vect u)
; -2
; > (xcor-vect u)
; 4
; > (add-vect u v)
; '(-5 1)
; > v
; '(-9 3)
; > u
; '(4 -2)
; > (add-vect v u)
; '(-5 1)
; > (sub-vect v u)
; '(-13 5)
; > (sub-vect u v)
; '(13 -5)
; > (scale-vect 0 v)
; '(0 0)
; > (scale-vect 4 v)
; '(-36 12)
; > (scale-vect -4 v)
; '(36 -12)
; > 
