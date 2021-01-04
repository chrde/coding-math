(in-package #:coding-math)

(defstruct (circle
            (:constructor make-circle (&optional (center (make-vec)) (radius 0))))
  center radius)

(defmethod collides ((obj1 circle) (obj2 circle))
  (>= (distance (circle-center obj1) (circle-center obj2))
      (+ (circle-radius obj1) (circle-radius obj2))))

(defun circle-x (c)
  (vec-x (circle-center c)))

(defun circle-y (c)
  (vec-y (circle-center c)))

(defun (setf circle-x) (x c)
  (setf (vec-x (circle-center c)) x))

(defun (setf circle-y) (y c)
  (setf (vec-y (circle-center c)) y))
