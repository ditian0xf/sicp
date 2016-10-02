;-----
;2.27
;-----

(define (deep-reverse x)
  (cond ((null? x) x)  ; input is an empty list
        ((not (pair? x)) x)  ; input is a single number (NOT a one-item list); this happens near the end of recursion
        (else (list (deep-reverse (cdr x)) (deep-reverse (car x))))))
