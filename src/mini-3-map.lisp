(in-package #:coding-math)

(defsketch mini-map ((width 800)
                     (height 800)
                     (radius 0))
  (circle (/ width 2) (/ height 2) radius))

(defmethod kit.sdl2:mousemotion-event ((window mini-map) ts mask x y xr yr)
  (with-slots (radius height) window
    (setf radius (map-to y 0 height 20 340))))

; (make-instance 'mini-map)
