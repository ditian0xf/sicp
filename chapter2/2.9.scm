;-----
;2.9
;-----

; [xl, xh] and [yl, yh]

; addition
; result = [xl + yl, xh + yh]
; width_result = ((xh + yh) - (xl + yl))/2 = (xh - xl)/2 + (yh - yl)/2 = width_x + width_y

; subtraction
; result = [xl - yh, xh - yl]
; width_result = ((xh - yl) - (xl - yh))/2 = (xh - xl)/2 + (yh - yl)/2 = width_x + width_y

; multiplication
; for example, [2, 6] * [5, 11] = [10, 66]
; width_x = (6 - 2)/2 = 2
; width_y = (11 - 5)/2 = 3
; width_result = (66 - 10)/2 = 28
; correlation is hard to find

; division
; for example, [4, 6] / [1, 7] = [4, 6] * [1/7, 1] = [4/7, 6]
; width_x = 1
; width_y = 3
; width_result = 19/7
; correlation is hard to find
