;-----
;2.31
;-----

(define (tree-map f tree)
  (cond ((null? tree) (list))  ; empty-tree
        ((not (pair? tree)) (f tree))  ; single-number leaf node, just apply f
        (else (cons (tree-map f (car tree))  ; recursively apply tree-map to left subtree and right subtree
                    (tree-map f (cdr tree))))))

(define (square x) (* x x))
(define (square-tree tree) (tree-map square tree))

(define tree (list 1
                   (list 2 (list 3 4) 5)
                   (list 6 7)))

; tests
; > (square-tree tree)
; (1 (4 (9 16) 25) (36 49))
; > (square-tree (list))
; ()
; > (square-tree 5.5)
; 30.25
; >

(define (tree-map-using-list-map f tree)
  (map (lambda (x) (if (not (pair? x))  ; single-number leaf node
                       (f x)  ; just apply f
                       (tree-map-using-list-map f x)))  ; else if current item is a tree, recursively apply tree-map-using-list-map to it 
       tree))

(define (square-tree-using-map tree) (tree-map-using-list-map square tree))

; tests
; > (square-tree-using-map tree)
; (1 (4 (9 16) 25) (36 49))
;;> (square-tree-using-map (list))
; ()
; > (square-tree-using-map 5.5)
; --> contract violation
; > (square-tree-using-map (list 5.5))
; (30.25)
; >

