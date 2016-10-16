;-----
;2.21
;-----

(define (square-list items)
  (if (null? items)
      (list)
      (cons (let ((head (car items))) (* head head)) (square-list (cdr items)))))

; tests
; > (square-list (list 1 2 3 4 5))
; (1 4 9 16 25)
; > (square-list (list))
; ()
; > (square-list (list 1))
; (1)
; > (square-list (list 4))
; (16)
; > (square-list (list 4 0.9 -0.5))
; (16 0.81 0.25)
; >

(define (square-list-map items)
  (map (lambda (x) (* x x)) items))

; tests
; > (square-list-map (list 1 2 3 4 5))
; (1 4 9 16 25)
; > (square-list-map (list))
; ()
; > (square-list-map (list 1))
; (1)
; > (square-list-map (list 4))
; (16)
; > (square-list-map (list 4 0.9 -0.5))
; (16 0.81 0.25)
; >

