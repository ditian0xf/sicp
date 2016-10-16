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
