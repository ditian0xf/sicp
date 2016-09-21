;-----
;2.1
;-----

(define (make-rat n d)
  (let ((abs-n (abs n)) (abs-d (abs d)) (g (gcd (abs n) (abs d))))
    (if (or (and (> n 0) (> d 0)) (and (< n 0) (< d 0)))  ; if (n > 0 && d > 0) || (n < 0 && d < 0) 
        (cons (/ abs-n g) (/ abs-d g))
        (cons (- (/ abs-n g)) (/ abs-d g)))))

; test
; (make-rat 12 18)
; (make-rat -12 -18)
; (make-rat -12 18)
; (make-rat 12 -18)

