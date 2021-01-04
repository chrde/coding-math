(in-package #:coding-math)

(defsketch mini-clamp ((width 800)
                       (height 800)
                       (r '(200 150 400 300))
                       (border '(-10 -10 20 20))
                       (c '(0 0 10)))
  (apply #'rect (mapcar #'+ r border))
  (with-pen (make-pen :fill +red+)
            (apply #'circle c)))

(defmethod kit.sdl2:mousemotion-event ((window mini-clamp) ts mask x y xr yr)
  (with-slots (c r) window
    (setf
      (first c) (clamp x (first r) (+ (third r) (first r)))
      (second c) (clamp y (second r) (+ (fourth r) (second r)))
      )))

;; (make-instance 'mini-clamp)
