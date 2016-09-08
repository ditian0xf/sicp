;-----
;1.9
;-----
;(+ 4 5)
;--> (+ 3 5) + 1
;--> (+ 2 5) + 1 + 1
;--> (+ 1 5) + 1 + 1 + 1
;--> (+ 0 5) + 1 + 1 + 1 + 1
;--> 5 + 1 + 1 + 1 + 1
;--> 6 + 1 + 1 + 1
;--> 7 + 1 + 1
;--> 8 + 1
;--> 9
; There are deferred evaluations, which are "inc (+ 3 5)", "inc (+ 2 5)", "inc (+ 1 5)" and "inc (+ 0 5)", therefore 
; this process is recursive.
; Expansion then contraction; a chain of deferred operations.

;(+ 4 5)
;--> (+ 3 6)
;--> (+ 2 7)
;--> (+ 1 8)
;--> (+ 0 9)
;--> 9
; No expansion then contraction. All we need to keep track of are the current values of the variables a and b.
; The state of the process can be summarized by a fixed number of state variables, together with the updating rule.
