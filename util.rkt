#lang racket

(provide sliding-window)

(define (sliding-window lst #:window-size (window-size 2) #:func (func identity))
    (if (> window-size (length lst))
        (list)
        (append 
          (list (func (take lst window-size)))
          (sliding-window (cdr lst) #:window-size window-size #:func func))))

