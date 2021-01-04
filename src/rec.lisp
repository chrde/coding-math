(in-package #:coding-math)

(defstruct (rec
            (:constructor make-rec-wh (&optional (min (make-vec)) (width 0) (height 0))))
  min width height)

;; (defun make-rec-wh (min width height)
;;   )

(defun make-rec-mm (min max)
  (let ((size (vec-sub max min)))
    (make-rec-wh min (vec-x size) (vec-y size))))

(defun rec-min-x (c)
  (vec-x (rec-min c)))

(defun rec-max-x (c)
  (+ (rec-min-x c) (rec-width c)))

(defun rec-min-y (c)
  (vec-y (rec-min c)))

(defun rec-max-y (c)
  (+ (rec-min-y c) (rec-height c)))

(defun (setf rec-center) (center r)
  (with-slots (min width height) r
    (setf (vec-x min) (- (vec-x center) (/ width 2))
          (vec-y min) (- (vec-y center) (/ height 2)))))

;; (defun (setf rec-x) (x c)
;;   (setf (vec-x (rec-center c)) x))

;; (defun (setf rec-y) (y c)
;;   (setf (vec-y (rec-center c)) y))
