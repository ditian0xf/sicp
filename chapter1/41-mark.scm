;-----
;1.41
;-----

#lang racket

(define (double proc-one-arg)
	(lambda (x) (proc-one-arg (proc-one-arg x))))

(define (inc x) (+ 1 x))

(((double double) inc) 1)
; The result is 5.
; Procedure "double" takes one-argument procedure f(x) as its input parameter.
; (double double) ==> (double (double f))
;                             (double f) applies its input procedure, which is f, 2 times.
;                     (double (double f)) applies its input procedure, which is (double f), 2 times; thus applies f 4 times.
; Therefore, (double double) as a whole, applies its input procedure f 4 times.

(((double (double double)) inc) 5)
; The result is 21.
; (double (double double)) ==> ((double double) ((double double) f)) 
;                          ===(double double) as D===> (D (D f))
;                          ==> (D f), applies f 4 times; (D (D f)), applies (D f) 4 times, f 16 times.


