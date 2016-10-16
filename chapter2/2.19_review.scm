;-----
;2.19
;-----

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount (first-denomination coin-values))
                coin-values)))))

(define (no-more? list) (null? list))
(define (except-first-denomination list) (cdr list))
(define (first-denomination list) (car list))

(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))

; test
; > (cc 100 us-coins)
; 292
; > (cc 100 uk-coins)
; 104561
; > (cc 10 us-coins)
; 4
; > (cc 10 uk-coins)
; 50
; > (define uk-coins-random-order (list 50 20 100 5 10 1 0.5 2))
; > (cc 100 uk-coins-random-order)
; 104561
; > (cc 10 uk-coins-random-order)
; 50
; >

; mark --
; does the order of the list of coin-values affect the answer produced by cc?
; why or why not?

; the order of the list does not affect the answer because
; all combinations are tried regardless.
; sorting the list with the higher values fist does produce a "smaller" process becuase
; it causes the branches to end more quickly.
