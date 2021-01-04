(in-package #:coding-math)

(defsketch real-friction((width 800)
                         (height 800)
                         (color +green+)
                         (friction (make-vec 0.15 0))
                         (p (make-particle
                              (/ width 2) (/ height 2) 10 (* (random 1.0) pi 2))))
  ; vec-angle and vec-len involve lots of trigs and sqr = slow
  (setf (vec-angle friction) (vec-angle (particle-velocity p)))
  (if (> (vec-len (particle-velocity p)) (vec-len friction))
      (vec-sub! (particle-velocity p) friction)
    (progn
      (setf color +red+)
      (particle-stop! p)))
  (particle-update! p)
  (with-pen (make-pen :fill color)
            (circle (particle-x p) (particle-y p) 10)))
; (make-instance 'real-friction)

(defsketch cheap-friction((width 800)
                         (height 800)
                         (color +green+)
                         (p (make-particle
                              (/ width 2) (/ height 2) 10 (* (random 1.0) pi 2) :friction 0.97)))
  (particle-update! p)
  (with-pen (make-pen :fill color)
            (circle (particle-x p) (particle-y p) 10)))
; (make-instance 'cheap-friction)
