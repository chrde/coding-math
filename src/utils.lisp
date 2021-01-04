(in-package #:coding-math)

;; math
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

(defun lerp-point (norm p0 p1)
  (make-vec (lerp norm (vec-x p0) (vec-x p1))
            (lerp norm (vec-y p0) (vec-y p1))))

(defun map-to (n src-min src-max dest-min dest-max)
  (lerp (norm n src-min src-max)
        dest-min dest-max))

(defun distance (v1 v2)
  (vec-len (vec-sub v1 v2)))

(defun in-range-p (n min max)
  (and (> max n)
       (<= min n)))

(defun rand-int (&optional (min 0) (max 1))
  (+ min (random (- max min))))

(defun rand (&optional (min 0) (max 1.0))
  (+ min (* (- max min) (random 1.0))))

(defun rand-distribution (min max iterations)
  (let ((total 0))
    (dotimes (n iterations)
      (incf total (rand-int min max)))
    (floor (/ total iterations))))

(defun round-to-places (value places)
  (let ((mult (expt 10 places)))
    (/ (round (* value mult)) mult)))

(defun round-nearest (value nearest)
  (* nearest (round (/ value nearest))))

(defun quadratic-bezier (p0 p1 p2 norm)
  (+ (* p0 (expt (- 1 norm) 2))
     (* p1 norm 2 (- 1 norm))
     (* p2 (expt norm 2))))

(defun quadratic-bezier-xy (p0 p1 p2 norm)
  (let ((x (quadratic-bezier (vec-x p0) (vec-x p1) (vec-x p2) norm))
        (y (quadratic-bezier (vec-y p0) (vec-y p1) (vec-y p2) norm)))
    (make-vec x y)))

(defun cubic-bezier (p0 p1 p2 p3 norm)
  (+ (* p0 (expt (- 1 norm) 3))
     (* p1 norm 3 (expt (- 1 norm) 2))
     (* p2 3 (- 1 norm) (expt norm 2))
     (* p3 (expt norm 3))))

;; cp = control-point
(defun cp-bezier-xy (p0 p1 p2)
  (let ((x (- (* 2 (vec-x p1)) (/ (+ (vec-x p0) (vec-x p2)) 2)))
        (y (- (* 2 (vec-y p1)) (/ (+ (vec-y p0) (vec-y p2)) 2))))
    (make-vec x y)))

;; other
(defun particle-screen-clamp! (p width height)
  (with-slots (radius) p
    (let ((x (particle-x p))
          (y (particle-y p)))
      (setf (particle-x p) (clamp x radius (- width radius))
            (particle-y p) (clamp y radius (- height radius))
            ))))

(defun particle-screen-wrap! (p width height)
  (let ((radius (particle-radius p))
        (x (particle-x p))
        (y (particle-y p)))
    (when (> (- x radius) width)
      (setf (particle-x p) (- radius)))
    (when (< (+ x radius) 0)
      (setf (particle-x p) (+ radius width)))
    (when (> (- y radius) height)
      (setf (particle-y p) (- radius)))
    (when (< (+ y radius) 0)
      (setf (particle-y p) (+ radius height)))))

(defun particle-screen-bounce! (p width height)
  (let ((radius (particle-radius p))
        (x (particle-x p))
        (y (particle-y p))
        (bounce (particle-bounce p)))
    (with-slots ((vel-x x) (vel-y y)) (particle-velocity p)
      (when (> (+ x radius) width)
        (setf (particle-x p) (- width radius))
        (setf vel-x (* bounce vel-x)))
      (when (< (- x radius) 0)
        (setf (particle-x p) radius)
        (setf vel-x (* bounce vel-x)))
      (when (< (- y radius) 0)
        (setf (particle-y p) radius)
        (setf vel-y (* bounce vel-y)))
      (when (> (+ y radius) height)
        (setf (particle-y p) (- height radius))
        (setf vel-y (* bounce vel-y))))))

;; gui
(defun draw-particle (p)
  (circle (particle-x p) (particle-y p) (particle-radius p)))

(defun draw-point (p &optional (radius 3))
  (circle (vec-x p) (vec-y p) radius))

(defun draw-line (p1 p2)
  (line (vec-x p1) (vec-y p1) (vec-x p2) (vec-y p2)))
