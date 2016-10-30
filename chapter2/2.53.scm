;-----
;2.53
;-----

; (list 'a 'b 'c)
; --> (a b c)

; test
; > (list 'a 'b 'c)
; (a b c)
; >

; (list (list 'george))
; --> ((george))

; test
; > (list (list 'george))
; ((george))
; >

; (cdr '((x1 x2) (y1 y2)))
; --> ((y1 y2))

; test
; > (cdr '((x1 x2) (y1 y2)))
; ((y1 y2))
; >

; (cadr '((x1 x2) (y1 y2)))
; --> (y1 y2)

; test
; > (cadr '((x1 x2) (y1 y2)))
; (y1 y2)
; >

; (pair? (car '(a short list)))
; --> #f

; test
; > (pair? (car '(a short list)))
; #f
; >

; (memq 'red '((red shoes) (blue socks)))
; --> #f

; test
; > (memq 'red '((red shoes) (blue socks)))
; #f
; >

; (memq 'red '(red shoes blue socks))
; --> (red shoes blue socks)

; test
; > (memq 'red '(red shoes blue socks))
; (red shoes blue socks)
; >


