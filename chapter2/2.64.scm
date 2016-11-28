;-----
;2.64
;-----

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
          (let ((this-entry (car non-left-elts))
                (right-result (partial-tree (cdr non-left-elts) right-size)))
            (let ((right-tree (car right-result))
                  (remaining-elts (cdr right-result)))
              (cons (make-tree this-entry
                               left-tree
                               right-tree)
                    remaining-elts))))))))

; ----- a -----
; partial-tree builds a binary search tree from the first n elements in an ordered list.
; It takes the middle element of the first n elements as the root,
; and recursively builds the left subtree using the elements at the left of the middle element,
; and the right subtree using the elements at the right, from the successor of the middle element to the nth element.

; The result tree is the first element of the result list, the list of unused elements is the second.

; The tree produced by list->tree for list (1 3 5 7 9 11) is
;              5
;            /   \
;           1     9
;            \   / \
;             3 7   11

; ----- b -----
; THETA(n)
; This is because each element in the list is treated as root for only once,
; and make-tree takes constant time.
