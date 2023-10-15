#lang racket
(provide snake-init snake-iter get-x get-y)

(define (snake-init) (list (list 0 2) (list 0 1) (list 0 0)))
(define (snake-head snake) (car snake))
(define (get-x s) (car s))
(define (get-y s) (car (cdr s)))

(define (snake-iter snake dir grid)
  (let* ([x (get-x (snake-head snake))]
         [y (get-y (snake-head snake))]
         [new-x (+ x (get-x dir))]
         [new-y (+ y (get-y dir))]
         [inside? (and (< new-x (get-x grid))
                     (< new-y (get-y grid))
                     (>= new-x 0)
                     (>= new-y 0))])

    (when inside?
      (let* ([head (list new-x new-y)]
             [tail (take snake (- (length snake) 1))])
        (append (list head) tail)))))
