#lang racket

(provide Maybe maybe? none? none)

(struct Maybe (value))

(define (maybe? maybe)
  (Maybe? maybe))

(define (none? maybe)
  (eq? maybe 'none))

(define none 'none)
