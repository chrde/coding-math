(in-package #:coding-math)

(defsketch episode-8 ((width 800)
                      (height 800)
                      (pos (loop for i from 1 to 100 collect
                                 (make-particle (/ width 2) (/ height 3) (+ 1 (random 4.0)) (degrees (* (random 1.0) pi 2)) :gravity-y 0.1))))
  (dolist (p pos)
    (particle-update! p)
    (circle (particle-x p) (particle-y p) 10)))

(defsketch episode-9a ((width 800)
                       (height 800)
                       (p (make-particle 100 height 10 (- (/ pi 2))))
                       (velocity (make-vec))
                       (accel (make-vec 0.1 0.1))
                       )
  (particle-accelerate! p accel)
  (particle-update! p)
  (circle (particle-x p) (particle-y p) 10))


(defsketch episode-10 ((width 800)
                       (height 800)
                       (ship (make-particle (/ width 2) (/ height 2) 0 0))
                       (thrust (make-vec))
                       (turning-left nil)
                       (turning-right nil)
                       (thrusting nil)
                       (speed-down nil)
                       (angle 0)
                       )
  (push-matrix)
  (translate (particle-x ship) (particle-y ship))
  (rotate (degrees angle))
  (let ((color (if thrusting +red+ +blue+)))
    (with-pen (make-pen :fill color)
              (polygon 10 0 -10 7 -10 -7)))
  (pop-matrix)
  (setf (vec-angle thrust) angle)
  (setf (vec-x (particle-pos ship)) (wrap (particle-x ship) 0 width))
  (setf (vec-y (particle-pos ship)) (wrap (particle-y ship) 0 height))
  (if thrusting
      (setf (vec-len thrust) 0.01)
    (setf (vec-len thrust) 0.0))
  (when turning-right (incf angle 0.1))
  (when turning-left (decf angle 0.1))
  (particle-accelerate! ship thrust)
  (particle-update! ship)
  )

(defmethod kit.sdl2:keyboard-event ((instance episode-10) state timestamp repeatp keysym)
  (declare (ignorable timestamp repeatp))
  (if (eql state :keyup)
      (keyup keysym instance)
    (keydown keysym instance)))

(defun keydown (keysym instance)
  (let ((key (sdl2:scancode-value keysym)))
    (cond
      ((sdl2:scancode= key :scancode-j) (setf (slot-value instance 'thrusting) t))
      ((sdl2:scancode= key :scancode-h) (setf (slot-value instance 'turning-left) t))
      ((sdl2:scancode= key :scancode-l) (setf (slot-value instance 'turning-right) t))
      )))

(defun keyup (keysym instance)
  (let ((key (sdl2:scancode-value keysym)))
    (cond
      ((sdl2:scancode= key :scancode-j) (setf (slot-value instance 'thrusting) nil))
      ((sdl2:scancode= key :scancode-h) (setf (slot-value instance 'turning-left) nil))
      ((sdl2:scancode= key :scancode-l) (setf (slot-value instance 'turning-right) nil))
      )))
