;-----
;2.38
;-----

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

; the value of 
; (fold-right / 1 (list 1 2 3)) is
; (1 / (2 / (3 / 1))) = (1 / (2 / 3)) = (1 / 2/3) = 3/2
;
; > (fold-right / 1 (list 1 2 3))
; 3/2

; the value of
; (fold-left / 1 (list 1 2 3)) is
; (((1 / 1) / 2) / 3) = ((1 / 2) / 3) = (1/2 / 3) = 1/6
; > (fold-left / 1 (list 1 2 3))
; 1/6

; the value of
; (fold-right list nil (list 1 2 3)) is
; (list 1 (list 2 (list 3 ()))) = (list 1 (list 2 (3, ()))) = (list 1 (2, (3, ()))) = (1, (2, (3, ())))
;
; > (fold-right list (list) (list 1 2 3))
; (1 (2 (3 ())))

; the value of
; (fold-left list nil (list 1 2 3)) is
; (list (list (list () 1) 2) 3) = (list (list ((), 1) 2) 3) = (list (((), 1), 2) 3) = ((((), 1), 2), 3)
;
; > (fold-left list (list) (list 1 2 3))
; (((() 1) 2) 3)
; >

; op needs to have commutativity and associativity.
; first take a look at the evaluation process for fold-right and fold-left.
; fold-right: (op E_0 ... (op E_n-2 (op E_n-1 initial)))
; fold-left:  (op (op (op initial E_0) E_1) ... E_n-1)
;
; commutativity --
; say the input sequence has only one element.
; fold-right: (op E_0 initial)
; fold-left:  (op initial E_0)
; if (op E_0 initial) == (op initial E_0), commutativity is needed.
;
; associativity --
; since op has commutativity, we could rewrite the evaluation process like this.
; fold-right: {E_0 ... {E_n-2 {E_n-1 initial}}}
; fold-left:  {{{initial E_0} E_1} ... E_n-1}
; take 2 elements as example:
; fold-right: {E_0 {E_1 initial}}
; fold-left:  {{Initial E_0} E_1}
; {E_0 {E_1 Initial}} -- if E_0 could associate with Initial first, this turns into fold-left --> {{E_0 Initial} E_1}, so associativity is needed.
; 


