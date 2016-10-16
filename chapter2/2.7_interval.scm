;-----
;2.7
;-----

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

#| test

> (define interval (make-interval 1 5))
> (lower-bound interval)
1
> (upper-bound interval)
5
> (define interval (make-interval 5 1))
> (lower-bound interval)
1
> (upper-bound interval)
5
> (define interval (make-interval 5 5))
> (lower-bound interval)
5
> (upper-bound interval)
5

|#