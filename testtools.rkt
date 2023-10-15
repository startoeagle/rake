#lang racket

(provide nequal? testing-expr testing-eq testing-neq)

(define (nequal? e a)
  (not (equal? e a)))

(define (run-test expected expr comp-op)
  (let ([actual expr])
    (displayln (list "Testing:" comp-op actual expected))
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
