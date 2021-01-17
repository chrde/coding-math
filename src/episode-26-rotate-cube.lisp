(in-package #:coding-math)

(defsketch rotate-cube((width 800)
                       (height 800)
                       (focal-length 300.0)
                       (z-offset 3500)
                       (points (list (make-vec3 :x -500 :y -500 :z 500)
                                     (make-vec3 :x 500 :y -500 :z 500)
                                     (make-vec3 :x 500 :y -500 :z -500)
                                     (make-vec3 :x -500 :y -500 :z -500)
                                     (make-vec3 :x -500 :y 500 :z 500)
                                     (make-vec3 :x 500 :y 500 :z 500)
                                     (make-vec3 :x 500 :y 500 :z -500)
                                     (make-vec3 :x -500 :y 500 :z -500))))
  (translate (/ width 2) (/ height 2))
  (let ((screen-points (rotate-cube-project)))
    (rotate-cube-draw '(0 1 2 3 0) screen-points)
    (rotate-cube-draw '(4 5 6 7 4) screen-points)
    (rotate-cube-draw '(0 4) screen-points)
    (rotate-cube-draw '(1 5) screen-points)
    (rotate-cube-draw '(2 6) screen-points)
    (rotate-cube-draw '(3 7) screen-points)))

(defun rotate-cube-rotate-x (angle)
  ( let ((p-cos (cos angle))
         (p-sin (sin angle)))
   (dolist (p (slot-value *rotate-cube* 'points))
     (with-slots (y z) p
       (setf y (- (* y p-cos) (* z p-sin))
             z (+ (* z p-cos) (* y p-sin)))))))

(defun rotate-cube-rotate-y (angle)
  ( let ((p-cos (cos angle))
         (p-sin (sin angle)))
   (dolist (p (slot-value *rotate-cube* 'points))
     (with-slots (x z) p
       (setf x (- (* x p-cos) (* z p-sin))
             z (+ (* z p-cos) (* x p-sin)))))))

(defun rotate-cube-rotate-z (angle)
  ( let ((p-cos (cos angle))
         (p-sin (sin angle)))
   (dolist (p (slot-value *rotate-cube* 'points))
     (with-slots (x y) p
       (setf x (- (* x p-cos) (* y p-sin))
             y (+ (* y p-cos) (* x p-sin)))))))

(defun rotate-cube-draw (ps screen-points)
  (loop for (p p1) on ps while p1
        do (draw-line (nth p screen-points) (nth p1 screen-points))))

(defun rotate-cube-point-project (point)
  (with-slots (focal-length z-offset) *rotate-cube*
    (let ((scale (/ focal-length (+ z-offset (vec3-z point) focal-length))))
      (make-vec (* scale (vec3-x point))
                (* scale (vec3-y point))))))

(defun rotate-cube-project ()
  (loop for p in (slot-value *rotate-cube* 'points)
        collect (rotate-cube-point-project p)))

(defun rotate-cube-move (cube offset)
  (dolist (p (slot-value cube 'points))
    (vec3-add! p offset)))

(defmethod kit.sdl2:mousewheel-event ((window rotate-cube) ts x y)
  (rotate-cube-move window (make-vec3 :x 0 :y 0 :z (* 50 y -1))))

(defmethod kit.sdl2:keyboard-event ((instance rotate-cube) state timestamp repeatp keysym)
  (declare (ignorable timestamp repeatp))
  (when (eql state :keydown)
    (let ((key (sdl2:scancode-value keysym)))
      (cond
        ((sdl2:scancode= key :scancode-a) (rotate-cube-move instance (make-vec3 :x -50 :y 0 :z 0)))
        ((sdl2:scancode= key :scancode-d) (rotate-cube-move instance (make-vec3 :x 50 :y 0 :z 0)))
        ((sdl2:scancode= key :scancode-s) (rotate-cube-move instance (make-vec3 :x 0 :y 50 :z 0)))
        ((sdl2:scancode= key :scancode-w) (rotate-cube-move instance (make-vec3 :x 0 :y -50 :z 0)))
        ((sdl2:scancode= key :scancode-h) (rotate-cube-rotate-y 0.05))
        ((sdl2:scancode= key :scancode-j) (rotate-cube-rotate-x 0.05))
        ((sdl2:scancode= key :scancode-k) (rotate-cube-rotate-x -0.05))
        ((sdl2:scancode= key :scancode-l) (rotate-cube-rotate-z 0.05))))))

;; (defparameter *rotate-cube* (make-instance 'rotate-cube))
