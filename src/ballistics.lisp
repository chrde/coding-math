(in-package #:coding-math)

(defsketch ballistics ((width 800)
                       (height 800)
                       (aiming nil)
                       (angle 0)
                       (gun '(:x 100 :y 800 :angle (radians 45)))
                       (c '(0 0 10)))
  (let ((color (if aiming +red+ +blue+)))
    (push-matrix)
    (translate (getf gun :x) (getf gun :y))
    (rotate (degrees angle))
    (with-pen (make-pen :fill color)
              (polygon 10 0 -10 7 -10 -7))
    (pop-matrix))
  )

(defmethod kit.sdl2:mousebutton-event ((window ballistics) state ts button x y)
  (with-slots (aiming) window
    (setf aiming (eq state :mousebuttondown))))

(defmethod kit.sdl2:mousemotion-event ((window ballistics) ts mask x y xr yr)
  (with-slots (c r angle aiming gun) window
    (if aiming
        (setf angle (atan (- y (getf gun :y))
                          (- x (getf gun :x))))
      (setf (getf gun :x) x
            (getf gun :y) y))))

; (make-instance 'ballistics)
