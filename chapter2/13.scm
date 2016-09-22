;-----
;2.13
;-----

; interval 1
; center x, percentage tolerance t1
; [(1 - t1)x, (1 + t1)x]

; interval 2
; center y, percentage tolerance t2
; [(1 - t2)y, (1 + t2)y]

; suppose all four endpoints are positive
; the product is
; [(1 - t1)(1 - t2)xy, (1 + t1)(1 + t2)xy]

; the percentage tolerance of the product is
;   ((1 + t1)(1 + t2)xy - (1 - t1)(1 - t2)xy) / 2xy
; = ((1 + t1)(1 + t2) - (1 - t1)(1 - t2)) / 2
; = (t1 + t2 + t1 + t2) / 2
; = t1 + t2
