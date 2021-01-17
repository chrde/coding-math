(in-package #:coding-math)

(defsketch cube((width 800)
                (height 800)
                (focal-length 300.0)
                (points (list (make-vec3 :x -500 :y -500 :z 1000)
                              (make-vec3 :x 500 :y -500 :z 1000)
                              (make-vec3 :x 500 :y -500 :z 500)
                              (make-vec3 :x -500 :y -500 :z 500)
                              (make-vec3 :x -500 :y 500 :z 1000)
                              (make-vec3 :x 500 :y 500 :z 1000)
                              (make-vec3 :x 500 :y 500 :z 500)
                              (make-vec3 :x -500 :y 500 :z 500)
                              )))
  (translate (/ width 2) (/ height 2))
  (let ((screen-points (cube-project points focal-length)))
    (cube-draw '(0 1 2 3 0) screen-points)
    (cube-draw '(4 5 6 7 4) screen-points)
    (cube-draw '(0 4) screen-points)
    (cube-draw '(1 5) screen-points)
    (cube-draw '(2 6) screen-points)
    (cube-draw '(3 7) screen-points)))

(defun cube-draw (ps screen-points)
  (loop for (p p1) on ps while p1
        do (draw-line (nth p screen-points) (nth p1 screen-points))))

(defun cube-point-project (point focal-length)
  (let ((scale (/ focal-length (+ (vec3-z point) focal-length))))
    (make-vec (* scale (vec3-x point))
              (* scale (vec3-y point)))))

(defun cube-project (points focal-length)
  (loop for p in points
        collect (cube-point-project p focal-length)))

(defun cube-move (cube offset)
  (dolist (p (slot-value cube 'points))
    (vec3-add! p offset)))

(defmethod kit.sdl2:mousewheel-event ((window cube) ts x y)
  (cube-move window (make-vec3 :x 0 :y 0 :z (* 50 y -1))))

(defmethod kit.sdl2:keyboard-event ((instance cube) state timestamp repeatp keysym)
  (declare (ignorable timestamp repeatp))
  (when (eql state :keydown)
    (let ((key (sdl2:scancode-value keysym)))
      (cond
        ((sdl2:scancode= key :scancode-a) (cube-move instance (make-vec3 :x -50 :y 0 :z 0)))
        ((sdl2:scancode= key :scancode-d) (cube-move instance (make-vec3 :x 50 :y 0 :z 0)))
        ((sdl2:scancode= key :scancode-s) (cube-move instance (make-vec3 :x 0 :y 50 :z 0)))
        ((sdl2:scancode= key :scancode-w) (cube-move instance (make-vec3 :x 0 :y -50 :z 0)))))))

;; (defparameter *cube* (make-instance 'cube))
