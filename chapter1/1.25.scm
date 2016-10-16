;-----
;1.25
;-----
; The result is correct, but the execution time is larger.
; For the "fast-expt" method, we are doing (base^exp) mod m, however, evaluating (base^exp) is slow and not necessary.
; For the "expmod" method, we are doing (something) mod m. It can be easily observed that (something) never
; exceeds base^2.
; Althogh (base^exp) mod m is evaluated only once, while (something) mod m is evaluated log(exp) times, 
; the latter case is still much faster, because dealing with huge number arithmatic operations is so slow.
