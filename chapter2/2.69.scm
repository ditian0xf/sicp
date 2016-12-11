;-----
;2.69
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

; ----- solution starts here -----
(define (successive-merge subtrees)
  (if (= 1 (length subtrees))
      (car subtrees)
      (successive-merge (adjoin-set (make-code-tree (car subtrees) (cadr subtrees))
                                    (cddr subtrees)))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; ----- tests -----
; > (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1)))
; ((leaf a 4) ((leaf b 2) ((leaf d 1) (leaf c 1) (d c) 2) (b d c) 4) (a b d c) 8)
; > 
; the tree looks like:
;        +
;    /       \
;  (A 4)      +
;          /     \
;       (B 2)     +
;               /   \
;            (D 1)  (C 1)

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

; > (define sample-tree (generate-huffman-tree '((A 4) (B 2) (C 1) (D 1))))
; > (encode '(A D A B B C A) sample-tree)
; (0 1 1 0 0 1 0 1 0 1 1 1 0)
; >
