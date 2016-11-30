;-----
;2.65
;-----

; ----- tree utils -----
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

; ----- tree to list in linear time -----
(define (tree->list-linear tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree) result-list)))))
  (copy-to-list tree '()))

;----- list to tree in linear time -----
(define (list->tree-linear elements)
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

; ----- union-set in linear time -----
(define (union-set-as-list set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((head1 (car set1))
                    (head2 (car set2)))
                (cond ((= head1 head2) (cons head1 (union-set-as-list (cdr set1) (cdr set2))))
                      ((< head1 head2) (cons head1 (union-set-as-list (cdr set1) set2)))
                      (else (cons head2 (union-set-as-list set1 (cdr set2)))))))))

(define (union-set set1 set2)
  (let ((list1 (tree->list-linear set1))
        (list2 (tree->list-linear set2)))
    (list->tree-linear (union-set-as-list list1 list2))))

; tests
(define set1 (list->tree-linear '(0 2 4 6)))
(define set2 (list->tree-linear '(1 3 5 7)))
(tree->list-linear (union-set set1 set2))
; (0 1 2 3 4 5 6 7)
(define set1 (list->tree-linear '()))
(define set2 (list->tree-linear '()))
(tree->list-linear (union-set set1 set2))
; ()
(define set1 (list->tree-linear '(1 2)))
(define set2 (list->tree-linear '()))
(tree->list-linear (union-set set1 set2))
; (1 2)
(define set1 (list->tree-linear '()))
(define set2 (list->tree-linear '(2 3)))
(tree->list-linear (union-set set1 set2))
; (2 3)
(define set1 (list->tree-linear '(0 2 5 6)))
(define set2 (list->tree-linear '(1 3 5 7)))
(tree->list-linear (union-set set1 set2))
; (0 1 2 3 5 6 7)
(define set1 (list->tree-linear '(0 2 5 6)))
(define set2 (list->tree-linear '(2 3 5 7)))
(tree->list-linear (union-set set1 set2))
; (0 2 3 5 6 7)

;----- intersection-set in linear time -----
(define (intersection-set-as-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((head1 (car set1))
            (head2 (car set2)))
        (cond ((< head1 head2) (intersection-set-as-list (cdr set1) set2))
              ((> head1 head2) (intersection-set-as-list set1 (cdr set2)))
              (else (cons head1 (intersection-set-as-list (cdr set1) (cdr set2))))))))

(define (intersection-set set1 set2)
  (let ((list1 (tree->list-linear set1))
        (list2 (tree->list-linear set2)))
    (list->tree-linear (intersection-set-as-list list1 list2))))

; tests
(define set1 (list->tree-linear '()))
(define set2 (list->tree-linear '()))
(tree->list-linear (intersection-set set1 set2))
; ()

(define set1 (list->tree-linear '()))
(define set2 (list->tree-linear '(1)))
(tree->list-linear (intersection-set set1 set2))
; ()

(define set1 (list->tree-linear '(1)))
(define set2 (list->tree-linear '()))
(tree->list-linear (intersection-set set1 set2))
; ()

(define set1 (list->tree-linear '(1)))
(define set2 (list->tree-linear '(1)))
(tree->list-linear (intersection-set set1 set2))
; (1)

(define set1 (list->tree-linear '(1)))
(define set2 (list->tree-linear '(2)))
(tree->list-linear (intersection-set set1 set2))
; ()

(define set1 (list->tree-linear '(1 2)))
(define set2 (list->tree-linear '(1)))
(tree->list-linear (intersection-set set1 set2))
; (1)

(define set1 (list->tree-linear '(1 2)))
(define set2 (list->tree-linear '(2)))
(tree->list-linear (intersection-set set1 set2))
; (2)

(define set1 (list->tree-linear '(1 2)))
(define set2 (list->tree-linear '(3)))
(tree->list-linear (intersection-set set1 set2))
; ()

(define set1 (list->tree-linear '(1 2)))
(define set2 (list->tree-linear '(2 3 5)))
(tree->list-linear (intersection-set set1 set2))
; (2)

(define set1 (list->tree-linear '(1 3 5 6)))
(define set2 (list->tree-linear '(2 3 6 7)))
(tree->list-linear (intersection-set set1 set2))
; (3 6)
