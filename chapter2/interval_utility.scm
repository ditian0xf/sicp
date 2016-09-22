(define (make-interval a b) (cons a b))

(define (lower-bound interval)
  (let ((first (car interval)) (second (cdr interval)))
    (if (< first second)
        first
        second)))

(define (upper-bound interval)
  (let ((first (car interval)) (second (cdr interval)))
    (if (< first second)
        second
        first)))

(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (if (and (<= (lower-bound y) 0) (>= (upper-bound y) 0))
      (display "undefined: divided by interval that spans zero")
      (mul-interval
       x
       (make-interval (/ 1.0 (upper-bound y))      ; spans 0: 1/upper-bound > 1/lower-bound
                      (/ 1.0 (lower-bound y))))))  ; meaningless

(define (mul-interval-new x y)
  (let ((xl (lower-bound x))
        (xh (upper-bound x))
        (yl (lower-bound y))
        (yh (upper-bound y)))
    (cond ((and (<= xl 0) (<= xh 0)) (cond ((and (<= yl 0) (<= yh 0)) (make-interval (* xh yh) (* xl yl)))
                                           ((and (<= yl 0) (>= yh 0)) (make-interval (* xl yh) (* xl yl)))
                                           (else (make-interval (* xl yh) (* xh yl)))))
          ((and (<= xl 0) (>= xh 0)) (cond ((and (<= yl 0) (<= yh 0)) (make-interval (* xh yl) (* xl yl)))
                                           ((and (>= yl 0) (>= yh 0)) (make-interval (* xl yh) (* xh yh)))
                                           (else (let ((p1 (* xl yl))
                                                       (p2 (* xl yh))
                                                       (p3 (* xh yl))
                                                       (p4 (* xh yh))) (make-interval (min p1 p2 p3 p4)
                                                                                      (max p1 p2 p3 p4))))))
          ((and (>= xl 0) (>= xh 0)) (cond ((and (<= yl 0) (<= yh 0)) (make-interval (* xh yl) (* xl yh)))
                                           ((and (<= yl 0) (>= yh 0)) (make-interval (* xh yl) (* xh yh)))
                                           (else (make-interval (* xl yl) (* xh yh))))))))

(define (make-center-percent center percentage-tolerance)
  (if (= center 0)
      (display "error: center value is zero")
      (let ((tolerance (/ (* (abs center) percentage-tolerance) 100)))
        (make-interval (- center tolerance) (+ center tolerance)))))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (percent i)
  (let ((center (center i))
        (width (width i)))
    (if (= center 0)
        (display "error: center value is zero")
        (* (/ width (abs center)) 100))))
