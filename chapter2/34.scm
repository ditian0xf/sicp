;-----
;2.34
;-----

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ this-coeff
                                                   (* x higher-terms)))
              0
              coefficient-sequence))

; (acc op 0 [a0 a1 a2 a3])
; |--> this-coeff <--> a0
; |--> higher-terms <--> (acc op 0 [a1 a2 a3])
; should return (acc op 0 [a1 a2 a3]) * x + a0
; that is higher-terms * x + this-coeff

; tests
; > (horner-eval 2 (list))
; 0
; > (horner-eval 2 (list 0.35))
; 0.35
; > (horner-eval 2 (list 0.35 0.43))
; 1.21
; > (horner-eval 2 (list 0.35 0.43 0.57))
; 3.4899999999999998
; > (horner-eval 2 (list 1 3 0 5 0 1))
; 79
; > 



