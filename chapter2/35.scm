;-----
;2.35
;-----

; (define (count-leaves t)
;   (accumulate <??> <??> (map <??> <??>)))

; at first i'm thinking of picking all leaves into a list, then count the number of the items in the list,
; but that sounds like enumerate or filter, not map.

; on a second thought, if i could apply count-leaves to each subtree:
; (leaf, subtree0, leaf, subtree1, subtree2,...)
;                 |
;            map count-leaves
;                 |
;                 v
; (1,    n0,       1,    n1,       n2,...)
; then we accumulate this list, it's done.

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) (if (not (pair? x))  ; if x is a leaf (single number), not a tree
                                         1  ; then the leaf count is 1
                                         (count-leaves x))) t)))  ; else x is a tree, the leaf count is (count-leaves x)

; tests
; > (count-leaves (list))
; 0
; > (count-leaves (list 5))
; 1
; > (count-leaves (list 5 6 7 8 9))
; 5
; > (count-leaves (list 5 (list (list 6 7) 8 9) 10))
; 6
; > (define t (list 1
;                   (list 2 (list 3 4) 5)
;                   (list 6 7)))
; > (count-leaves t)
; 7
; >
