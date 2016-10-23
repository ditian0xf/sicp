;-----
;2.47
;-----

(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

; test
; > (define frame (make-frame 1 2 3))
; > (origin-frame frame)
; 1
; > (edge1-frame frame)
; 2
; > (edge2-frame frame)
; 3
; >

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (cddr frame))

; test
; > (define f (make-frame 1 2 3))
; > (origin-frame f)
; 1
; > (edge1-frame f)
; 2
; > (edge2-frame f)
; 3
; >
