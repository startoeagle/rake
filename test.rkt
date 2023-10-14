#lang racket
(module test racket
    (require "util.rkt")

    (define-syntax-rule (testing expected expr)
      (let ([actual expr])
          (displayln (list "Testing:" (quote (equal? expected expr))))
          (if (equal? expected actual)
              (displayln "Passed")
              (error "Test failed:" "actual was " actual ". expected:" expected))))

    (testing (list (list 1 2)) (sliding-window '(1 2)))
    (testing (list (list 1 2) (list 2 3)) (sliding-window '(1 2 3)))
    (testing '(1) (sliding-window '(1 2) #:func (lambda (w) (car w))))
    (testing '(1 2 3) (sliding-window '(1 2 3 4) #:func (lambda (w) (car w)))))
