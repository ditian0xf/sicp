;-----
;2.56
;-----

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))

(define (addend s) (cadr s))

(define (augend s) (caddr s))

(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))

(define (base exp) (cadr exp))

(define (exponent exp) (caddr exp))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? b 0) 0)
        ((=number? e 1) b)
        ((=number? b 1) 1)
        (else (list '** b e))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp) (make-sum (make-product (multiplier exp)
                                                (deriv (multiplicand exp) var))
                                  (make-product (deriv (multiplier exp) var)
                                                (multiplicand exp))))
        ((exponentiation? exp) (let ((b (base exp))
                                     (e (exponent exp)))
                                 (make-product (make-product e
                                                             (make-exponentiation b (make-sum e -1)))
                                               (deriv b var))))
        (else error "unknow expression type: DERIV" exp)))

; tests
; > (deriv '(+ x 3) 'y)
; 0
; > (deriv '(+ x 3) 'x)
; 1
; > (deriv '(* x y) 'x)
; y
; > (deriv '(* (* x y) (+ x 3)) 'x)
; (+ (* x y) (* y (+ x 3)))
; >

; > (deriv '(** x 5) 'y)
; 0
; > (deriv '(** x 5) 'x)
; (* 5 (** x 4))
; > (deriv '(** x 1) 'x)
; 1
; > (deriv '(** x 2) 'x)
; (* 2 x)
; > (deriv '(** x -4) 'x)
; (* -4 (** x -5))
; > (deriv '(+ (* 6 (** x 5)) (* 2 x)) 'x)
; (+ (* 6 (* 5 (** x 4))) 2)
; > (deriv '(** 0 5) 'x)
; 0
; > (deriv '(** 0 x) 'x)
; 0
; > (deriv '(** x k) 'x)
; (* k (** x (+ k -1)))
; > (deriv '(** u n) 'x)
; 0
; > (deriv '(** (* 2 x) n) 'x)
; (* (* n (** (* 2 x) (+ n -1))) 2)
; > (deriv '(** x x) 'x)
; (* x (** x (+ x -1)))  ; OBVIOUSLY WRONG!!!
; > (deriv '(** (* r (** x p)) n) 'x)
; (* (* n (** (* r (** x p)) (+ n -1))) (* r (* p (** x (+ p -1)))))
; > (deriv '(** (+ (* r (** x p)) (* x q)) n) 'x)
; (* (* n (** (+ (* r (** x p)) (* x q)) (+ n -1))) (+ (* r (* p (** x (+ p -1)))) q))
; > 


