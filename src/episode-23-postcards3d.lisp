(in-package #:coding-math)

(defstruct carousel-item
  (angle pi)
  (x 0.0)
  (y 0.0)
  (z 0.0)
  (radius 0)
  (alpha 0))

(defun carousel-rand-items (n)
  (let ((items ()))
    (dotimes (i n items)
      (let* ((angle (* 0.5 i))
             (y (- 400 (* 7 (/ *carousel-radius* n) i)))
             (x (* (cos angle) *carousel-radius*))
             (z (+ *carousel-center-z* (* (sin angle) *carousel-radius*))))
        (push (make-carousel-item :angle angle
                                  :x x :y y :z z
                                  :radius 10) items)))))

(defun carousel-update-item (item)
  (with-slots (angle x y z) item
    (incf angle *carousel-rotation-speed*)
    (setf x (* (cos angle) *carousel-radius*)
          z (+ (* (sin angle) *carousel-radius*) *carousel-center-z*))))

(defun carousel-sort ()
  (setf *carousel-items*
        (sort *carousel-items*
              #'(lambda (a b) (>= (carousel-item-z a) (carousel-item-z b))))))

(defsketch carousel((width 800)
                    (height 800)
                    (focal-length 300))
  (text (format nil "focal length: ~f" focal-length) 20 20)
  (text (format nil "rot speed: ~,3f" *carousel-rotation-speed*) 20 40)
  (translate (/ width 2) (/ height 2))
  (carousel-sort)
  (dolist (item *carousel-items*)
    (let ((persp (/ focal-length (+ (carousel-item-z item) focal-length))))
      (push-matrix)
      (scale persp)
      (translate (carousel-item-x item) (carousel-item-y item))
      (circle 0 0 (carousel-item-radius item))
      (carousel-update-item item)
      (pop-matrix))))

(defmethod kit.sdl2:mousewheel-event ((window carousel) ts x y)
  (with-slots (focal-length) window
    (incf focal-length (* 5 y))))

(defmethod kit.sdl2:mousemotion-event ((window carousel) ts mask x y xr yr)
  (with-slots (width) window
    (setf *carousel-rotation-speed* (/ (- x (/ width 2)) 7000))))

;; (defparameter *carousel-rotation-speed* 0.007)
;; (defparameter *carousel-radius* 100)
;; (defparameter *carousel-center-z* 200)
;; (defparameter *carousel-items* (carousel-rand-items 100))
;; (make-instance 'carousel)
