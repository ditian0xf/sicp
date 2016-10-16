;-----
;2.15
;-----

; she is right

; two intervals with non-zero error:

;   addition, subtraction:
;   the new width is (width1 + width2)

;   multiplication, division(if two percentage tolerances are small):
;   the new percentage tolerance is (tolerance1 + tolerance2)


; if one interval is with zero error:

;   error of the result remains unchanged


; arithmetic operations between two intervals with non-zero error introduces bigger error
; should minimize these kind of operations
