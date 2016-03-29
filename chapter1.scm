;1.1
(* 6 5)
(+ 5 3 4)
(- 9 1)
(/ 6 2)
(+ (* 2 4) (- 4 6))

(define a 3)
(define b (+ a 1))
(+ a b (* a b))
(not (= a b))
(if (and (> b a) (< b (* a b)))
    b
    a
    )
(cond ((= a 4) 6)
      ((= b 4) (+ 6 7 a))
      (else 25))
(+ 2 (if (> b a) b a))
(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1))

;1.2
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5)))))
   (* 3 (- 6 2) (- 2 7)))

;1.3
(define (square x) (* x x))
(define (sum_of_squares x y) (+ (square x) (square y)))
(define (procedure1_3 a b c)
	(cond ((and (<= a b) (<= a c)) (sum_of_squares b c))
	      ((and (<= b a) (<= b c)) (sum_of_squares a c))
	      (else (sum_of_squares a b))))
(procedure1_3 3 2 1)

;1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
(a-plus-abs-b 3 4)
(a-plus-abs-b 3 -4)
(a-plus-abs-b 3 -4.55)

;1.5
(define (p) (p))
(define (test x y)
  (if (= x 0) 0 y))
(test 0 (p))
;Infinite runtime here. Why? Because to evaluate (test param0 param1), the interpreter
;first has to evaluate param0 and param1, sequentially. 0 is evaluated to 0, of course;
;then function (p) is evaluated. Function (p) is defined as a funtion that calls itself,
;thus this is a recursive function without termination condition. It never ends.

;computing square root of x
(define (sqrt x)
  (sqrt-iter 1.0 x))  ; always guess the square root is 1.0 at the beginning
(define (sqrt-iter guess x) 
  (if (good-enough? guess x) guess  ; if the guess is good enough, return the value guess 
      (sqrt-iter (improve-guess guess x) x)))  ; otherwise, improve the guess and proceed to the next iteration
(define (good-enough? guess x) 
  (< (abs (- (* guess guess) x)) 0.001))  ; |guess * guess - x| < 0.001?
(define (abs x) 
  (if (> x 0) x (- x)))
(define (improve-guess guess x)  ; improvement := (guess + x / guess) / 2 
  (/ (+ guess (/ x guess)) 2))

(sqrt 9)

;1.6
(define (new-if predicate then-clause else-clause) 
  (cond (predicate then-clause)
        (else else-clause)))
(new-if (= 3 2) 1 0)
(new-if (= 3 3) 1 0)

(define (sqrt-iter guess x) 
  (new-if (good-enough? guess x) guess  ; if the guess is good enough, return the value guess 
      (sqrt-iter (improve-guess guess x) x)))  ; otherwise, improve the guess and proceed to the next iteration

(sqrt 1)
;Infinite runtime here. Again, (new-if predicate then-clause else-clause) is a self-defined function. To evaluate
;this function, firstly the interpreter must evaluate predicate, then-clause, else-clause, sequentially. Here
;predicate is (good-enough? guess x), then-clause is guess, both easy to evaluate; however, the else-clause is 
;again a recursive function without termination condition, so it never ends. As a matter of fact, the idea here is
;that we should only evaluate the predicate to decide what to do next.



