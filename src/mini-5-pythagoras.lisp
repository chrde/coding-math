(in-package #:coding-math)

(defsketch pythagorean-theorem ((width 800)
                                (height 800)
                                (color +white+)
                                (radius 100)
                                (center-x (/ width 2))
                                (center-y (/ height 2)))
  (with-pen (make-pen :fill color)
            (circle center-x center-y radius)))

(defmethod kit.sdl2:mousemotion-event ((window pythagorean-theorem) ts mask x y xr yr)
  (with-slots (center-x center-y color radius) window
    (let ((close-enough (< (distance (make-vec center-x center-y)
                                  (make-vec x y)) radius)))
      (if close-enough
          (setf color +red+)
        (setf color +white+)))))

;; (make-instance 'pythagorean-theorem)
