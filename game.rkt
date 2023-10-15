#lang racket
(provide snake-init snake-head snake-iter snake-grow get-x get-y)

(define (snake-init) (list (list 0 2) (list 0 1) (list 0 0)))
(define (snake-head snake) (car snake))
(define (snake-front snake)
  (take snake (- (length snake) 1)))
(define (snake-tail snake)
  (cdr snake))
(define (get-x s) (car s))
(define (get-y s) (car (cdr s)))

(define (snake-eat-self? snake)
  (foldl (lambda (a result)
           (or result (equal? a (snake-head snake))))
         #f
         (snake-tail snake)))


(define (snake-iter snake dir grid)
  (let* ([x (+ (get-x (snake-head snake)) (get-x dir))]
         [y (+ (get-y (snake-head snake)) (get-y dir))]
         [head (list x y)]
         [inside? (and (< x (get-x grid))
                       (< y (get-y grid))
                       (>= x 0)
                       (>= y 0))]
         [eat-self? (snake-eat-self? snake)])

    (if (and (not eat-self?) inside?)
      (append (list head) (snake-front snake))
      snake)))

(define (snake-grow s)
  (append s (list (last s))))

(module+ test
  (require "testtools.rkt")
  (testing-eq '((0 2) (0 1)) (snake-front '((0 2) (0 1) (0 0))))
  (testing-eq '((0 1) (0 0)) (snake-tail '((0 2) (0 1) (0 0))))
  (testing-eq #t (not (snake-eat-self? (snake-init))))
  (testing-eq '((1 2) (0 2) (0 1)) (snake-iter (snake-init) '(1 0) '(20 20))))

