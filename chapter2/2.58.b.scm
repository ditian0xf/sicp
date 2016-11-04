;-------
;2.58.b
;-------

; !!YES!!
; ----- b -----
(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (sum? x)  ; as long as there is one + sign in the list
  (cond ((number? x) #f)
        ((null? x) #f)
        ((eq? (car x) '+) #t)
        (else (sum? (cdr x)))))

; tests for (sum? x)
; > (sum? 3)
; #f
; > (sum? '3)
; #f
; > (sum? '())
; #f
; > (sum? '(3))
; #f
; > (sum? '(3 + 4))
; #t
; > (sum? '(3 * 4 + 5))
; #t
; > (sum? '(3 * 4 * 5))
; #f

(define (addend s)  ; 1. (sum? s) has to be true; 2. (exp0 * exp1 * exp2 + exp3 * exp4 + exp5) -- break by first + --> (exp0 * exp1 * exp2) and (exp3 * exp4 + exp5)
  (define (first-half s first)
    (if (eq? (car s) '+)
        first
        (first-half (cdr s) (append first (list (car s))))))
  (if (eq? (cadr s) '+)
      (car s)
      (first-half s (list))))

; tests for (addend s)
; > (addend '(3 + 4))
; 3
; > (addend '(3 + 4 + 5))
; 3
; > (addend '(3 + 4 * 5))
; 3
; > (addend '(3 * 4 + 5))
; (3 * 4)
; > (addend '(1 * 2 * 3 + 3 * 4 + 5))
; (1 * 2 * 3)
; > 

(define (augend s)
  (if (eq? (car s) '+)
      (if (null? (cddr s))
          (cadr s)
          (cdr s))
      (augend (cdr s))))

; tests for (augend s)
; > (augend '(3 + 4))
; 4
; > (augend '(3 + 4 + 5))
; (4 + 5)
; > (augend '(3 + 4 * 5))
; (4 * 5)
; > (augend '(3 * 4 + 5))
; 5
; > (augend '(1 * 2 * 3 + 3 * 4 + 5))
; (3 * 4 + 5)
; >

(define (product? x) ; no + operator; all operators must be *
  (cond ((number? x) #f)
        ((null? x) #t)
        ((eq? (car x) '+) #f)
        (else (product? (cdr x)))))

; tests for (product? x)
; > (product? 3)
; #f
; > (product? '3)
; #f
; > (product? '())
; #t
; > (product? '(3))
; #t
; > (product? '(3 + 4))
; #f
; > (product? '(3 * 4 + 5))
; #f
; > (product? '(3 * 4 * 5))
; #t
; > 

(define (multiplier p) (car p))

(define (multiplicand p)
  (if (null? (cdddr p))
      (caddr p)
      (cddr p)))

; tests for (multiplicand p)
; > (multiplicand '(1 * 2))
; 2
; > (multiplicand '(1 * 2 * 3))
; (2 * 3)
; > (multiplicand '(1 * 2 * 3 * 4))
; (2 * 3 * 4)
; > 

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp) (make-sum (make-product (multiplier exp)
                                                (deriv (multiplicand exp) var))
                                  (make-product (deriv (multiplier exp) var)
                                                (multiplicand exp))))
        (else error "unknow expression type: DERIV" exp)))

; tests
; > (deriv '(x + 3 * (x + y + 2)) 'x)
; 4
; > (deriv '(x + 3 * (x + y + 2)) 'y)
; 3
; > (deriv '(x * 3 + (x + y + 2)) 'x)
; 4
; > (deriv '(x * 3 + (x + y + 2)) 'y)
; 1
; > (deriv '(3 * y * x + z * z * x + a * y) 'x)
; ((3 * y) + (z * z))
; > (deriv '(x * 3 + 5 * (x + y + 2)) 'x)
; 8
; > 

; > (deriv '(x + 3) 'y)
; 0
; > (deriv '(x + 3) 'x)
; 1
; > (deriv '(x * y) 'x)
; y
; > (deriv '((x * y) * (x + 3)) 'x)
; ((x * y) + (y * (x + 3)))
; > (deriv '(x + (3 * (x + (y + 2)))) 'x)
; 4
; > (deriv '(x + (3 * (x + (y + 2)))) 'y)
; 3
; >


