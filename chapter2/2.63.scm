;-----
;2.63
;-----

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

; tests
; > (define s (make-tree 2 (make-tree 1 '() '()) (make-tree 3 '() '())))
; > (adjoin-set 1 s)
; (2 (1 () ()) (3 () ()))
; > (adjoin-set 2 s)
; (2 (1 () ()) (3 () ()))
; > (adjoin-set 3 s)
; (2 (1 () ()) (3 () ()))
; > (adjoin-set 0 s)
; (2 (1 (0 () ()) ()) (3 () ()))
; > (adjoin-set 1.5 s)
; (2 (1 () (1.5 () ())) (3 () ()))
; > (adjoin-set 2.5 s)
; (2 (1 () ()) (3 (2.5 () ()) ()))
; > (adjoin-set 4 s)
; (2 (1 () ()) (3 () (4 () ())))
; >

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree) result-list)))))
  (copy-to-list tree '()))

; ----- a -----
; Yes the two procedures produce the same result for every tree.
; For trees in Figure 2.16,
; tree->list-1 produces [1, 3, 5, 7, 9, 11],
; tree->list-2 produces [1, 3, 5, 7, 9, 11].

; ----- b -----
; tree->list-1 takes THETA(nlgn) time.
; Since there are lgn levels,
; and for each level, from top to bottom, the count of "append" steps are:
; n
; n -  1
; n - (1 + 2)
; n - (1 + 2 + 4)
; ...
; n - (1 + 2 + 4 + ... + (n/2 + 1))

; The sum is
; n(lgn + 1) - 1 - (1 + 2) - (1 + 2 + 4) - ... - (1 + 2 + 4 + ... + (n/2 + 1)) :=
; n(lgn + 1) - T :=
; S

; T = lgn + 2(lgn - 1) + 4(lgn - 2) + ... + (n/2 + 1)(lgn - (lgn - 1))
;   = lgn(1 + 2 + 4 + ... + (n/2 + 1)) - (1*2 + 2*4 + ... + (lgn - 1) * (n/2 + 1))
;   = nlgn - (1*2 + 2*4 + ... + (lgn - 1) * (n/2 + 1))
; S = n(lgn + 1) - T = n + (1*2 + 2*4 + ... + (lgn - 1) * (n/2 + 1)) = n + sum_(1)_(lgn-1)_(i*2^i)
; By http://www.wolframalpha.com/input/?i=sum(i*2%5Ei),
; S = n + 2((lgn-1) * 2^(lgn-1) - 2^(lgn-1) + 1) = n + (n(lgn-1) - n + 2) = nlgn - n + 2

; which is THETA(nlgn).

; tree->list-2 takes THETA(n) time.
; This is because it iterates through the tree nodes, which is THETA(n);
; and for each tree node, it just prepends it to the beginning of the result list, which is THETA(1).




