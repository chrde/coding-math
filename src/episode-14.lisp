(in-package #:coding-math)

(defsketch collision-circle((width 800)
                            (height 800)
                            (color +green+)
                            (c1 (make-circle (make-vec 40 40) 100))
                            (c2 (make-circle (make-vec 200 200) 100)))
  (if (collides c1 c2)
      (setf color +red+)
      (setf color +green+))
  (with-pen (make-pen :fill color)
    (circle (circle-x c1) (circle-y c1) (circle-radius c1))
    (circle (circle-x c2) (circle-y c2) (circle-radius c2))))

(defmethod kit.sdl2:mousemotion-event ((window collision-circle) ts mask x y xr yr)
  (with-slots (c1) window
    (setf
     (circle-x c1) x
     (circle-y c1) y)))
;; (defparameter *game* (make-instance 'collision-circle))

(defsketch collision-circle-point((width 800)
                                  (height 800)
                                  (color +green+)
                                  (c1 (make-circle (make-vec 40 40) 100))
                                  (p1 (make-vec 200 200)))
  (if (collides c1 p1)
      (setf color +red+)
      (setf color +green+))
  (with-pen (make-pen :fill color)
    (circle (circle-x c1) (circle-y c1) (circle-radius c1))
    (circle (vec-x p1) (vec-y p1) 3)))

(defmethod kit.sdl2:mousemotion-event ((window collision-circle-point) ts mask x y xr yr)
  (with-slots (c1) window
    (setf
     (circle-x c1) x
     (circle-y c1) y)))
;; (defparameter *game* (make-instance 'collision-circle-point))

(defsketch collision-rec-rec((width 800)
                                  (height 800)
                                  (color +green+)
                                  (r1 (make-rec-wh (make-vec 40 40) 100 150))
                                  (r2 (make-rec-wh (make-vec 400 400) 100 150)))
  (if (collides r1 r2)
      (setf color +red+)
      (setf color +green+))
  (with-pen (make-pen :fill color)
    (rect (rec-min-x r1) (rec-min-y r1) (rec-width r1) (rec-height r1))
    (rect (rec-min-x r2) (rec-min-y r2) (rec-width r2) (rec-height r2))))

(defmethod kit.sdl2:mousemotion-event ((window collision-rec-rec) ts mask x y xr yr)
  (with-slots (r1) window
    (setf (rec-center r1) (make-vec x y))))
;; (defparameter *game* (make-instance 'collision-rec-rec))
