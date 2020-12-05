(in-package #:coding-math)

(defun clamp (n min max)
  (max (min max n) min))

(defun wrap (n min max)
  (cond 
    ((> n max) min)
    ((< n min) max)
    (t n)))

(defun norm (n min max)
  (/ (- n min)
     (- max min)))

(defun lerp (norm min max)
  (+ min (* norm (- max min))))
