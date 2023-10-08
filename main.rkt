#lang racket/gui

(define snake-color "green")

(define snake '(0 0))

(define (get-x s) (car s))
(define (get-y s) (car (cdr s)))

(define grid (list 20 20))
(define frame (new frame%
                   [label "Snake Game"]
                   [width 640]
                   [height 640]))

(define direction '(1 0))

(define (handle-key key) 
  (displayln (type key))
  (when (string=? "w" (string key))
    (set! direction '(0 -1)))
  (when (string=? "a" key)
    (set! direction (list -1 0)))
  (when (string=? "s" key)
    (set! direction '(0 1)))
  (when (string=? "d" key)
    (set! direction '(1 0))))

(define game-canvas%
  (class canvas% ; The base class is canvas%
    ; Define overriding method to handle mouse events
    (define/override (on-char event)
      (handle-key (send event get-key-code)))
    ; Call the superclass init, passing on all init args
    (super-new)))

(define canvas (new game-canvas%
                    [parent frame]
                    [paint-callback (lambda (canvas dc) (draw-snake dc))]))

(define square-size (/ 640 (get-x grid)))

(define (draw-snake dc)
  (send dc set-brush snake-color 'solid)
  (send dc draw-rectangle
        (* square-size (get-x snake))
        (* square-size (get-y snake))
        square-size square-size))


(send frame show #t)

(define (update-snake)
  (let* ([x (get-x snake)]
         [y (get-y snake)]
         [dir-x (get-x direction)]
         [dir-y (get-y direction)])

    (when (< x (- (get-x grid) 1))
      (set! snake (list (+ x dir-x) (+ y dir-y))))
  ))

(define (main-loop)
  (update-snake)
  (send canvas refresh))

(define my-timer (new timer%
                      [notify-callback (lambda ()
                                         (main-loop))]
                      [interval 500]))

(send my-timer start)
