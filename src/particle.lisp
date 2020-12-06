(in-package #:coding-math)

(defstruct (particle
             ; (:print-object (lambda (v out) (format out "[speed: ~A ]")))
             (:constructor make-particle-pv (pos velocity gravity mass)))
  pos velocity gravity mass)

(defun make-particle (x y spd direction &optional (gravity-y 0) (mass 1))
  (let* ((pos (make-vec x y))
         (velocity (make-vec-la spd direction))
         (gravity (make-vec 0 gravity-y)))
    (make-particle-pv pos velocity gravity mass)))

(defun particle-update! (p)
  (vec-add! (particle-pos p)
            (particle-velocity p))
  (vec-add! (particle-velocity p)
            (particle-gravity p))
  )

(defun particle-angle-to (p1 p2)
  (atan (- (particle-y p2) (particle-y p1))
        (- (particle-x p2) (particle-x p1))))

(defun particle-distance-to (p1 p2)
  (vec-len (vec-sub (particle-pos p2) (particle-pos p1))))

(defun particle-gravitate-to (p1 p2)
  (let* ((angle (particle-angle-to p1 p2))
         (dist (particle-distance-to p1 p2))
         (len (/ (particle-mass p2) (* dist dist))))
    (particle-accelerate! p1 (make-vec-la len angle))))

(defun particle-x (p)
  (vec-x (particle-pos p)))

(defun particle-y (p)
  (vec-y (particle-pos p)))

(defun particle-accelerate! (p accel)
  (vec-add! (particle-velocity p) accel))
