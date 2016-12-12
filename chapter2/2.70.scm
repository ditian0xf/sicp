;-----
;2.70
;-----

; ----- tree building -----

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

(define (successive-merge subtrees)
  (if (= 1 (length subtrees))
      (car subtrees)
      (successive-merge (adjoin-set (make-code-tree (car subtrees) (cadr subtrees))
                                    (cddr subtrees)))))

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

; ----- message encoding -----

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

; tests
; > (define rock-songs-tree (generate-huffman-tree '((a 2) (get 2) (sha 3) (wah 1) (boom 1) (job 2) (na 16) (yip 9))))
; > rock-songs-tree
; ((leaf na 16)
;  ((leaf yip 9)
;   (((leaf a 2) ((leaf boom 1) (leaf wah 1) (boom wah) 2) (a boom wah) 4)
;    ((leaf sha 3) ((leaf job 2) (leaf get 2) (job get) 4) (sha job get) 7)
;    (a boom wah sha job get)
;    11)
;   (yip a boom wah sha job get)
;   20)
;  (na yip a boom wah sha job get)
;  36)
; >
; > (define rock-songs-tree (generate-huffman-tree '((a 2) (get 2) (sha 3) (wah 1) (boom 1) (job 2) (na 16) (yip 9))))
; > (define encoded-message (encode '(get a job sha na na na na na na na na get a job sha na na na na na na na na wah yip yip yip yip yip yip yip yip yip sha boom) rock-songs-tree))
; > encoded-message
; (1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 0 0 0 0 0 0 1 1 0 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 0 1 0)
; >
; > (length encoded-message)
; 84
; >

; 84 bits are required for the encoding.
; Since there are 8 unique symbols, at least 3 bits are needed for encoding them.
; The message has 36 symbols, so 3 * 36 = 108 bits are required for the fixed-length code.
