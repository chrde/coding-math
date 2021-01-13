(in-package #:coding-math)

(defparameter *spiral-radius* 200)
(defparameter *spiral-center-z* 1000)

(defstruct spiral-item
  (angle pi)
  (x 0.0)
  (y 0.0)
  (z 0.0))

(defun spiral-item-update (i base-angle)
  (with-slots (x z angle) i
    (setf x (* *spiral-radius* (cos (+ base-angle angle)))
          z (+ *spiral-center-z* (* *spiral-radius* (sin (+ base-angle angle)))))))


(defsketch spiral((width 800)
                  (height 800)
                  (focal-length 300)
                  (base-angle 0)
                  (points nil)
                  (rotation-speed 0.01)
                  (initialized nil))
  (unless initialized
    (setf points (loop for i from 1 to 201
                       collect (let ((angle (* 0.2 i)))
                                 (make-spiral-item :angle angle
                                                   :y (- (+ 2000 (* (rand) 500))
                                                         (/ 4000 (* i 200)))))))
    (dolist (p points)
      (spiral-item-update p base-angle))
    (setf initialized t))
  (translate (/ width 2) -600)
  (spiral-update)
  (spiral-draw))


(defun spiral-draw ()
  (with-slots (points focal-length) *spiral*
    (loop for (p p1) on points while p1
          do 
          (let ((persp (/ focal-length (+ (spiral-item-z p) focal-length))))
            (push-matrix)
            (scale persp persp)
            (translate (spiral-item-x p) (spiral-item-y p))
            (circle (spiral-item-x p) (spiral-item-y p) 5)
            (line (spiral-item-x p) (spiral-item-y p)
                  (spiral-item-x p1) (spiral-item-y p1))
            (pop-matrix)))))

(defun spiral-update ()
  (with-slots (base-angle rotation-speed points) *spiral*
    (incf base-angle rotation-speed)
    (dolist (p points)
      (spiral-item-update p base-angle))))

(defmethod kit.sdl2:mousemotion-event ((window spiral) ts mask x y xr yr)
  (with-slots (width rotation-speed) window
    (setf rotation-speed(/ (- x (/ width 2)) 7000))))

;; (defparameter *spiral* (make-instance 'spiral))
