;-----
;2.30
;-----

(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) (list))
        ((not (pair? tree)) (square tree))  ; a single number, just square
        (else (cons (square-tree (car tree))  ; recursively apply this procedure to left subtree
                    (square-tree (cdr tree))))))  ; recursively apply this procedure to right subtree

(define (square-tree-using-map tree)  ; view tree as a list of subtrees; apply the map procedure to each list item
  (map (lambda (x) (if (not (pair? x))  ; if x is a single number
                       (square x)  ; just square it
                       (square-tree-using-map x)))  ; otherwise recursively apply square-tree-using-map to it
       tree))

(define tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7)))

; tests
; > (square-tree tree)
; (1 (4 (9 16) 25) (36 49))
; > (square-tree-using-map tree)
; (1 (4 (9 16) 25) (36 49))
; > (define empty-tree (list))
; > (square-tree empty-tree)
; ()
; > (square-tree-using-map empty-tree)
; ()
; > (define one-node-tree (list 4))
; > (square-tree one-node-tree)
; (16)
; > (square-tree-using-map one-node-tree)
; (16)
; >
