#lang racket
(module test racket

  (require "testtools.rkt")

  (testing-eq '(1 2 3) ((lambda (lst)
                          (take lst (- (length lst) 1)))
                        '(1 2 3 4)))

  ;; testing if we can use sum types
  (require "maybe.rkt")
  (testing-expr (maybe? (Maybe 123)))
  (testing-expr (none? none))
  (testing-neq none (Maybe 123))
  (testing-eq 123 (match (Maybe 123)
                    [(Maybe v) v]
                    ['none 321]))
  (testing-eq none (match none
                     [(Maybe v) v]
                     [n n]))
  (require "game.rkt")
  (testing-eq (list (list 0 1) (list 0 1)) (snake-grow (list (list 0 1)))))

