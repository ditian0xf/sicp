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
; Infinite runtime here. Why?
; --------
; Scheme is an applicative-order language, namely, that all the arguments to Scheme procedures are evaluated
; when the procedure is applied. In contrast, normal-order languages delay evaluation of procedure arguments
; until the actual argument values are needed, which is also called lazy evaluation.
; --------
; Therefore, when applying procedure "test", all the arguments of "test", namely 0 and (p) are evaluated.
; 0 is evaluated to 0 of course.
; (p) is a procedure that keeps calling itself without termination condition, thus the evaluation never ends.
;
; However, if the interpreter uses normal-order/lazy evaluation, when evaluating (test 0 (p)), it will replace
; the evaluation as (if (= 0 0) 0 (p)), the arguments will not be touched until they are needed. As regards "if"
; function, the 1st argument (= 0 0) is firstly evaluated as #t, so the 2nd argument 0 is needed, while the 3rd
; is not. 0 is evaluated as 0. In the end, the procedure "test" is evaluated as 0.

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
; Infinite runtime here. As regards customer-defined procedure (new-if predicate then-clause else-clause), when applied,
; the interpreter firstly evaluates all its 3 arguments.
; predicate is (good-enough? guess x), then-clause is guess, both easy to evaluate; however, the else-clause is 
; again a recursive function without termination.
; As a matter of fact, the idea here is that we should only evaluate the predicate to decide what to do next, 
; so we should use the original "if" procedure.

;-----
;1.7
;-----
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

(define (good-enough0? guess x) 
  (< (abs (- (improve-guess guess x) guess)) (* 0.001 guess)))

(sqrt 999999999999999999999999999)
;For very small number,
;the old "good-enough?" function converges too fast, resulting in inaccuracy: (sqrt 0.00000005) = 0.031250532810688444;
;while the new version is more accurate: (sqrt 0.00000005) = 0.0002236069910516385.
;For very big number,
;the old version is more accurate, although it takes more iterations to achieve this: (sqrt 999999999999999999999999999) = 31631394972364.664;  
;the new version: (sqrt 999999999999999999999999999) = 31622776601683.793.

;-----
;1.8
;-----
(define (cubic-root x)
  (cond ((> x 0) (cubic-root-iter 1.0 x)) 
        ((< x 0) (- (cubic-root-iter 1.0 (- x))))
        (else 0)))  ; always guess the cubic root is 1.0 at the beginning
(define (cubic-root-iter guess x) 
  (if (good-enough? guess x) guess  ; if the guess is good enough, return the value guess 
      (cubic-root-iter (improve-guess guess x) x)))  ; otherwise, improve the guess and proceed to the next iteration
(define (abs x) 
  (if (> x 0) x (- x)))
(define (improve-guess guess x)  ; improvement := (x / guess^2 + 2 * guess) / 3 
  (/ (+ (* 2 guess) (/ x (* guess guess))) 3))
(define (good-enough? guess x) 
  (< (abs (- (improve-guess guess x) guess)) (* 0.000001 guess)))

(cubic-root 1)
(cubic-root -1)
(cubic-root 64)
(cubic-root -64)
(cubic-root -0.008)
(cubic-root 0)
;When x = 0, improved_guess = 2/3 * guess, that is, guess(i+1) = 2/3 * guess(i). Therefore |improved_guess - guess| = 1/3 * guess, 
;and is always greater than 0.000001 * guess, resulting in infinite interation here. x = 0 should be specifically taken care of.

;-----
;1.9
;-----
(+ 4 5)
--> (+ 3 5) + 1
--> (+ 2 5) + 1 + 1
--> (+ 1 5) + 1 + 1 + 1
--> (+ 0 5) + 1 + 1 + 1 + 1
--> 5 + 1 + 1 + 1 + 1
--> 6 + 1 + 1 + 1
--> 7 + 1 + 1
--> 8 + 1
--> 9
; There are deferred evaluations, which are "inc (+ 3 5)", "inc (+ 2 5)", "inc (+ 1 5)" and "inc (+ 0 5)", therefore this process is recursive.
; Expansion then contraction; a chain of deferred operations.

(+ 4 5)
--> (+ 3 6)
--> (+ 2 7)
--> (+ 1 8)
--> (+ 0 9)
--> 9
; No expansion then contraction. All we need to keep track of are the current values of the variables a and b.
; The state of the process can be summarized by a fixed number of state variables, together with the updating rule.

;-----
;1.10
;-----
(A 1 10)
--> (A 0 (A 1 9))
--> (A 0 (A 0 (A 1 8)))
--> ...
--> {9 "(A 0"s} (A 1 1)
--> {9 "(A 0"s} 2
--> {8 "(A 0"s} 2^2
--> ...
--> 2^10
--> 1024

(A 2 4)
--> (A 1 (A 2 3))
--> (A 1 (A 1 (A 2 2)))
--> (A 1 (A 1 (A 1 (A 2 1))))
--> (A 1 (A 1 (A 1 2)))
--> (A 1 (A 1 4)
--> (A 1 16)
--> 65536

(A 3 3)
--> (A 2 (A 3 2))
--> (A 2 (A 2 (A 3 1)))
--> (A 2 (A 2 2))
--> (A 2 4)
--> 65536

(define (f n) (A 0 n))  ; 2n

(define (g n) (A 1 n))  ; 2^n

(define (h n) (A 2 n))  ; 2^^n (^^ is Knuth's up-arrow notation)

(define (k n) (* 5 n n))  ; 5n^2

;-------------
;count change
;-------------
(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins) 
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))  ; not use current coin for current amount 
                 (cc (- amount (first-denomination kinds-of-coins)) kinds-of-coins)))))  ; use current coin for current amount
(define (first-denomination kinds-of-coins) 
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)

;-----
;1.11
;-----
(define (f n)  ;recursive 
  (if (< n 3) n (+ (f (- n 1)) (* 2 (f (- n 2))) (* 3 (f (- n 3))))))

(define (f n)  ;iterative 
  (if (< n 3) n (f-iter 0 1 2 (- n 2))))

(define (f-iter ppp pp p how-many-left) 
  (if (= how-many-left 0) p (f-iter pp p (+ (* 3 ppp) (* 2 pp) p) (- how-many-left 1))))

(f 20)

;-----
;1.12
;-----
;assume row >= col
;1
;1 1
;1 2 1
;1 3 3 1
;...
(define (pascal-element row col) 
  (if (or (= col 0) (= row col)) 1 
      (+ (pascal-element (- row 1) (- col 1)) (pascal-element (- row 1) col))))

;-----
;1.13
;-----
; Step 1. Prove by induction.
; Step 2. To prove Fib(n) = (a^n - b^n) / sqrt(5) is the closest integer to a^n / sqrt(5),
;         that is, to prove |(a^n - b^n) / sqrt(5) - a^n / sqrt(5)| <= 0.5.

;-----
;1.14
;-----
; Draw the recursion tree -- done.
; Space complexity: max depth of the recursion tree, which is O(n).
; Time complexity: number of nodes in the recursion tree, which has the same order of the
; number of leaves, which is O(2^n) (since the tree is binary).

;-----
;1.15
;-----
; a. 5 times. log_(3)_(12.5 / 0.1) = 4.37.
; b. Time complexity: O(log_(3)_(a / 0.1)) --> O(lg(a)).
;    Space complexity: 
;      (sine 12.15)
;      (p (sine 4.05))  --------------------- (1)
;      (p (p (sine 1.35)))  ----------------- (2)
;      (p (p (p (sine 0.45))))  ------------- (3)
;      (p (p (p (p (sine 0.15)))))  --------- (4)
;      (p (p (p (p (p (sine 0.05))))))  ----- (5)
;
;      (p (p (p (p (p 0.05)))))  ------------ (6)
;      (p (p (p (p 0.1495))))  -------------- (7)
;      (p (p (p 0.4351345505)))  ------------ (8)
;      (p (p 0.9758465331678772))  ---------- (9)
;      (p -0.7895631144708228)  ------------- (10)
;      -0.39980345741334
;        We can see that there is "expansion then contraction".
;        (1) - (5) are all deferred evaluations (as regards function p).
;        (6) - (10) are the steps where actual evaluations happen.
;        Therefore this is a recursive process.
;        The space complexity is therefore O(lg(a)).

;-----
;1.16
;-----
; Use idea in hint: a is used to keep track of the product of "extra" (current) bs when n is odd.
; For example: 3^12
; n   b     a
; 12  3     1
; 6   9     1
; 3   81    1
; 2   81    81
; 1   6561  81
; 0   6561  81*6561
(define (expt b n) 
  (fast-expt-iter b n 1))
(define (fast-expt-iter b n a) 
  (if (= n 0) a 
      (if (even? n) (fast-expt-iter (* b b) (/ n 2) a) (fast-expt-iter b (- n 1) (* a b)))))
(define (even? n) (= (remainder n 2) 0))

(expt 3 12)

;-----
;1.17
;-----
; Compute a * b. Assume a >= 0 and b >= 0.
; For example, 3 * 5
; (3, 5)
; 3 + (3, 4)
; 3 + 2 * (3, 2)
; 3 + 2 * (2 * (3, 1))
; 3 + 2 * (2 * (3 + (3, 0)))
; -- evaluations above are deferred --
; 3 + 2 * (2 * (3 + 0))
; 3 + 2 * (2 * 3)
; 3 + 2 * 6
; 3 + 12
; 15
; -- deferred evaluations are actually evaluated above --
; We can see "expansion then contraction" and deferred evaluations here, thus this is recursive.
(define (fast-mul a b) 
  (if (= b 0) 0 
      (if (even? b) (double (fast-mul a (halve b))) (+ a (fast-mul a (- b 1))))))
(define (even? n) (= (remainder n 2) 0))
(define (halve n) (/ n 2))
(define (double n) (* n 2))

(fast-mul 98 891)

;-----
;1.18
;-----
; Compute a * b, assume a >= 0 and b >= 0.
; fast-mul iterative version.
; Use idea in 1.16: c is used to keep track of the sum of "extra" (current) as when b is odd.
; For example: 3 * 5
; a    b    c
; 3    5    0
; 3    4    3
; 6    2    3
; 12   1    3
; 12   0    15
(define (fast-mul a b) 
  (fast-mul-iter a b 0))
(define (fast-mul-iter a b c) 
  (if (= b 0) c 
      (if (even? b) (fast-mul-iter (double a) (halve b) c) (fast-mul-iter a (- b 1) (+ c a)))))
(define (even? n) (= (remainder n 2) 0))
(define (halve n) (/ n 2))
(define (double n) (* n 2))

(fast-mul 0 3)

;-----
;1.19
;-----
; T_pq is:
; a <-- bq + aq + ap
; b <-- bp + aq
;
; If we used T_pq on <a, b> twice, we get:
; a <-- (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p ==> b(2pq + q^2) + a(2pq + q^2) + a(p^2 + q^2)
; b <-- (bp + aq)p + (bq + aq + ap)q ==> b(p^2 + q^2) + a(2pq + q^2)
;
; This is equivalent to use T_p'q' on <a, b> once, where
; p' = p^2 + q^2
; q' = 2pq + q^2
(define (fib n) 
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count) 
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q))  ; p' = p^2 + q^2
                   (+ (* 2 p q) (* q q)) ; q' = 2pq + q^2
                   (/ count 2)))
         (else (fib-iter (+ (* b q) (* a q) (* a p))
                         (+ (* b p) (* a q))
                         p
                         q
                         (- count 1)))))
(define (even? n) (= (remainder n 2) 0))
  
(fib 19)

;-----
;1.20
;-----
; normal-order/lazy
(gcd 206 40)
(if (= 40 0) 206 (gcd 40 R1)  ; R1 <==> (remainder 206 40)
(gcd 40 R1)
(if (= R1 0) 40 (gcd R1 R2))  ; R2 <==> (remainder 40 R1). (= R1 0) needs to be evaluated. curCount = 1.
(gcd R1 R2)
(if (= R2 0) R1 (gcd R2 R3))  ; R3 <==> (remainder R1 R2). (= R2 0) needs to be evaluated. curCount = 3.
(gcd R2 R3)
(if (= R3 0) R2 (gcd R3 R4))  ; R4 <==> (remainder R2 R3). (= R3 0) needs to be evaluated. curCount = 7.
(gcd R3 R4)
(if (= R4 0) R3 (gcd R4 R5))  ; R5 <==> (remainder R3 R4). (= R4 0) needs to be evaluated. curCount = 14.
R3  ; curCount = 18.
2
; 18 times of applying remainder for normal-order/lazy evaluation.

; applicative-order
(gcd 206 40)
; 206, 40 are both primitive type. substitute.
(if (= 40 0) 206 (gcd 40 (remainder 206 40)))
; for if-procedure, the interpreter first evaluate the predicate (= 40 0), whose result is #f, therefore next 
; evaluate
(gcd 40 (remainder 206 40))
; for gcd-procedure, the interpreter first evaluate all its arguments, namely 40 and (remainder 206 40).
; (remainder 206 40) is evaluated as 6. curCount = 1.
(gcd 40 6)
; 40, 6 are both primitive type. substitute.
(if (= 6 0) 40 (gcd 6 (remainder 40 6)))
; (= 6 0) is #f, therefore next evaluate
(gcd 6 (remainder 40 6))
; first evalute arguments 6 and (remainder 40 6)
; (remainder 40 6) is evaluated as 4. curCount = 2.
(gcd 6 4)
; 6 and 4 are both primitive type. substitute.
(if (= 4 0) 6 (gcd 4 (remainder 6 4)))
; (= 4 0) is #f, therefore next evaluate
(gcd 4 (remainder 6 4))
; first evaluate arguments 4 and (remainder 6 4)
; (remainder 6 4) is evaluated as 2. curCount = 3.
(gcd 4 2)
; 4 and 2 are both primitive type. substitute.
(if (= 2 0) 4 (gcd 2 (remainder 4 2)))
; (= 2 0) is #f, therefore next evaluate
(gcd 2 (remainder 4 2))
; first evaluate arguments 2 and (remainder 4 2)
; (remainder 4 2) is evaluated as 0. curCount = 4.
(gcd 2 0)
; 4 and 0 are both primitive type. substitute.
(if (= 0 0) 2 (gcd 0 (remainder 2 0)))
; (= 0 0) is #t, therefore next evaluate
2
; 4 times of applying remainder for applicative-order evaluation.

;-----
;1.21
;-----
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ 1 test-divisor)))))
(define (divides? a b) (= 0 (remainder b a)))

(smallest-divisor 199)
(smallest-divisor 1999)
(smallest-divisor 19999)

;-----
;1.22
;-----
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ 1 test-divisor)))))
(define (divides? a b) (= 0 (remainder b a)))

(define (prime? n) (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time) 
  (if (prime? n) (report-time (- (runtime) start-time)) (display " is not a prime.")))
(define (report-time elapsed-time)
  (display "***")
  (display elapsed-time))

(define (search-for-primes lower-bound upper-bound) ; [lower-bound, upper-bound], both inclusive. 
  (if (= (remainder lower-bound 2) 1) 
      (search upper-bound lower-bound)  ; if lower-bound is odd, start from it; otherwise start from lower-bound + 1.
      (search upper-bound (+ 1 lower-bound))))
(define (search upper-bound current) 
  (if (> current upper-bound) 
      ((newline) (display "Done.")) 
      ((timed-prime-test current) (search upper-bound (+ current 2)))))

(search-for-primes 2 30)

(search-for-primes 1000 1050)
; the three smallest primes larger than 1000 are 1009(***6), 1013(***5), 1019(***5).
(search-for-primes 10000 10050)
; the three smallest primes larger than 1000 are 10007(***18), 10009(***10), 10037(***10).
(search-for-primes 100000 100050)
; the three smallest primes larger than 1000 are 100003(***35), 100019(***24), 100043(***24).
(search-for-primes 1000000 1000050)
; the three smallest primes larger than 1000 are 1000003(***62), 1000033(***55), 1000037(***57).

; The result is compatible with the notion that programs on your machine
; run in time proportional to the number of steps required for the computation.
; The "steps" here is THETA(sqrt(n)).

;-----
;1.23
;-----
(define (smallest-divisor n) (find-divisor n 2))
(define (find-divisor n test-divisor) 
  (cond ((> (* test-divisor test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))
(define (divides? a b) (= 0 (remainder b a)))
(define (next test-divisor) (if (even? test-divisor) (+ 1 test-divisor) (+ 2 test-divisor)))
(define (even? n) (= 0 (remainder n 2)))

(define (prime? n) (= (smallest-divisor n) n))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time) 
  (if (prime? n) (report-time (- (runtime) start-time)) (display " is not a prime.")))
(define (report-time elapsed-time)
  (display "***")
  (display elapsed-time))

(timed-prime-test 961748927)
; 961748927 is a large prime number.
; For the original (+ 1 test-divisor), try 10 times: 931, 995, 1053, 1014, 968, 941, 1051, 1043, 921, 912, average 982.9.
; For the (next test-divisor), try 10 times: 911, 932, 946, 962, 1011, 925, 896, 900, 967, 949, average 939.9.
; The observed ratio is not 2, but near 1.
; The only difference is between (+ 1 test-divisor) and (next test-divisor).
; For (+ 1 test-divisor), for each test-divisor in [2, sqrt(n)], perform an add operation and a remainder operation.
; For (next test-divisor), although the number of test-divisor halved, for each test-divisor, 
; perform a remainder operation (followed by if branch selection), an add operation and another remainder operation.
; If we simply change (+ 1 test-divisor) to (+ 2 test-divisor), the runtime will be approximately 620.

;-----
;1.24
;-----
(define (square x) (* x x))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n) 
  (define (try-it a) (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time) 
  (if (fast-prime? n 500) (report-time (- (runtime) start-time)) (display " is not a prime.")))
(define (report-time elapsed-time)
  (display "***")
  (display elapsed-time))

(timed-prime-test 278)
; Run (timed-prime-test 1019) five times: 412, 460, 396, 409, 421, average 419.6.
; Run (timed-prime-test 1000037) five times: 622, 677, 620, 630, 636, average 637.
; Since the time complexity is THETA(logn), the time growth is indeed very slow.
; The running time of (timed-prime-test 1000037) is supposed to be 2x as the running time of (timed-prime-test 1019).
; However, the actual ratio is 637 / 4119.6 = 1.52.
; Note that the "expmod" function is not strictly logarithmic, and it is not easy to tell the actual random number distribution.
; These two reasons could lead to the discrepancy between theory and observation.

;-----
;1.25
;-----
; The result is correct, but the execution time is larger.
; For the "fast-expt" method, we are doing (base^exp) mod m, however, evaluating (base^exp) is slow and not necessary.
; For the "expmod" method, we are doing (something) mod m. It can be easily observed that (something) never exceeds base^2.
; Althogh (base^exp) mod m is evaluated only once, while (something) mod m is evaluated log(exp) times, 
; the latter case is still much faster, because dealing with huge number arithmatic operations is so slow.

;-----
;1.26
;-----
; The new process is THETA(n).
; The height of the recursion tree is THETA(logn).
; At each node where exp is even, there are two branches.
; Therefore the number of nodes in the recursion tree is THETA(n).

;-----
;1.27
;-----
(define (square x) (* x x))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp) (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (test-carmichael-number n) (if (< n 2) #f (test-iter (- n 1) n)))

(define (test-iter i n) 
  (cond ((= i 1) #t)
        ((= i (expmod i n n)) (test-iter (- i 1) n))
        (else #f))) 

(test-carmichael-number 6601)

;-----
;1.28
;-----
(define (square-check x m) 
  (if (and (not (= x 1)) (not (= x (- m 1))) (= (remainder (* x x) m) 1)) 0 (remainder (* x x) m)))

(define (expmod base exp m) 
  (cond ((= exp 0) 1)
        ((even? exp) (square-check (expmod base (/ exp 2) m) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))

(define (miller-rabin-test n) 
  (define (try-it a) (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(miller-rabin-test 6601)

; 6601 is one of the Carmichael numbers; it is composite.
; If we (fermat-test 6601), the result is always true, meaning fermat-test considers 6601 as a prime number.
; If we (miller-rabin-test 6601), the results are mainly false (very, very rare chance that the result is true; while prime numbers always result in true).