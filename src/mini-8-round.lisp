(in-package #:coding-math)

;; mini 8
(defsketch mini-round ((width 800)
                       (height 800)
                       (grid-size 40)
                       (p (make-vec)))
  (draw-game *game*))

(defun draw-game (game)
  (with-slots (width height grid-size p) game
    (loop for x from 0 to width by grid-size
          do (line x 0 x height))
    (loop for y from 0 to height by grid-size
          do (line 0 y width y))
    (circle (vec-x p) (vec-y p) 15)))

(defmethod kit.sdl2:mousemotion-event ((window mini-round) ts mask x y xr yr)
  (with-slots (p grid-size) window
    (setf
      (vec-x p) (round-nearest x grid-size)
      (vec-y p) (round-nearest y grid-size))))

;; (defparameter *game* (make-instance 'mini-round))
