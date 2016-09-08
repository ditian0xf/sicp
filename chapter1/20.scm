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
