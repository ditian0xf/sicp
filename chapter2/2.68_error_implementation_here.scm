;-----
;2.68
;-----

(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair)
                               (cadr pair))
                    (make-leaf-set (cdr pairs))))))

; ----- error function implementation -----
;;; create binding for error
(define error #f)

;;; capture toplevel continuation
;;;  assign a function to error, allowing a variable number of arguments to
;;;  be passed
(call-with-current-continuation (lambda (k)
              (set! error
                (lambda error-arguments
                  (display ">>>> ERROR ")
                  (newline)
                  (k error-arguments)))
              'done))

; ----- the sample tree from 2.67 -----
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

; the tree should be like:
;       +
;    /     \
;   A       +
;         /   \
;        B     +
;             / \
;            D   C

; ----- solution starts here -----
(define (encode-symbol symbol tree)
  (cond ((leaf? tree) '())
        ((list? (memq symbol (symbols (left-branch tree))))  ; symbol is a member of left branch symbol set
         (cons '0 (encode-symbol symbol (left-branch tree))))
        ((list? (memq symbol (symbols (right-branch tree))))  ; symbol is a member of right branch symbol set
         (cons '1 (encode-symbol symbol (right-branch tree))))
        (else (error "Symbol not found in the tree"))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

; ----- tests -----
(encode '(A D A B B C A) sample-tree)
; (0 1 1 0 0 1 0 1 0 1 1 1 0)
(encode '(A) sample-tree)
; (0)
(encode '(B) sample-tree)
; (1 0)
(encode '(C) sample-tree)
; (1 1 1)
(encode '(D) sample-tree)
; (1 1 0)
(encode '(X) sample-tree)
; >>>> ERROR 
; ("Symbol not found in the tree")
(encode '(B A D) sample-tree)
; (1 0 0 1 1 0)
(encode '(B Y D) sample-tree)
; >>>> ERROR 
; ("Symbol not found in the tree")



