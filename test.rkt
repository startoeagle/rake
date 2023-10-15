#lang racket
(module test racket

  (define (nequal? e a)
    (not (equal? e a)))

  (define (run-test expected expr comp-op)
    (let ([actual expr])
      (displayln (list "Testing:" (quasiquote ((unquote comp-op) expected expr))))
      (if (comp-op expected actual)
          (displayln "Passed")
          (error "Test failed:" "actual was " actual ". expected:" expected))))

  (define-syntax-rule (testing-eq expected expr)
    (run-test expected expr equal?))

  (define-syntax-rule (testing-neq expected expr)
    (run-test expected expr nequal?))

  (define-syntax-rule (testing-expr expr)
    (let ([actual expr])
      (displayln (list "Testing:" (quote expr)))
      (if actual
          (displayln "Passed")
          (error "Test failed:" (syntax->datum expr)))))

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
                     [n n])))

