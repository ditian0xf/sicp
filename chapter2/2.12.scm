;-----
;2.12
;-----

(load "7_interval.scm")

(define (make-center-percent center percentage-tolerance)
  (if (= center 0)
      (display "error: center value is zero")
      (let ((tolerance (/ (* (abs center) percentage-tolerance) 100)))
        (make-interval (- center tolerance) (+ center tolerance)))))

; test
; > (make-center-percent 0 112)
; error: center value is zero
; > (make-center-percent 100 13.5)
; (86.5 . 113.5)
; > (make-center-percent -100 13.5)
; (-113.5 . -86.5)

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (let ((center (center i))
        (width (width i)))
    (if (= center 0)
        (display "error: center value is zero")
        (* (/ width (abs center)) 100))))

; test
; > (define i (make-interval -0.47 0.47))
; > (percent i)
; error: center value is zero
; > (define i (make-interval -0.46 0.47))
; > (percent i)
; 9300.000000000042
; > (define i (make-interval 83 117))
; > (percent i)
; 17
; > (define i (make-interval -113 -87))
; > (percent i)
;13

; test
; > (define i (make-center-percent -110 13.47))
; > (percent i)
; 13.470000000000008
