#lang racket/gui

(require "game.rkt")

(define snake (snake-init))

(define (direction-init) (list 1 0))

(define (game-init)
  (displayln "game inine")
  (set! snake (snake-init))
  (set! direction (direction-init)))

(define direction (direction-init))

(define grid (list 20 20))
(define snake-color "green")

(define (handle-key key)
  (when (char? key)
    (when (char=? #\w key)
      (set! direction '(0 -1)))
    (when (char=? #\a key)
      (set! direction (list -1 0)))
    (when (char=? #\s key)
      (set! direction '(0 1)))
    (when (char=? #\d key)
      (set! direction '(1 0)))))

(define game-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-char event)
      (handle-key (send event get-key-code)))
    ; Call the superclass init, passing on all init args
    (super-new)))

(define frame (new frame%
                   [label "Snake Game"]
                   [width 640]
                   [height 640]))
(define canvas (new game-canvas%
                    [parent frame]
                    [paint-callback (lambda (canvas dc) (draw-snake dc))]))

(define square-size (/ 640 (get-x grid)))

(define (draw-snake dc)
  (send dc set-brush snake-color 'solid)
  (for ([s snake])
    (send dc draw-rectangle
          (* square-size (get-x s))
          (* square-size (get-y s))
          square-size square-size)))

(send frame show #t)

(require "maybe.rkt")

(define (update-snake)
  (let ([new-snake (snake-iter snake direction grid)])
    (if (equal? new-snake snake)
        none
        (Maybe new-snake))))


(define (main-loop)
  (match (update-snake)
    ['none (eval (lambda ()
                   (send frame create-status-line)
                   (send frame set-status-text "TODO; Game over")))]
    [(Maybe new-snake)
     (set! snake new-snake)
     (send canvas refresh)]))

(define my-timer (new timer%
                      [notify-callback (lambda ()
                                         (main-loop))]
                      [interval 500]))

(module+ main
  (send my-timer start))
