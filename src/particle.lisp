(in-package #:coding-math)

(defstruct (particle
             ; (:print-object (lambda (v out) (format out "[speed: ~A ]")))
             (:constructor make-particle-pv (pos velocity gravity)))
  pos velocity gravity)

(defun make-particle (x y spd direction &optional (gravity-y 0))
  (let* ((pos (make-vec x y))
        (velocity (make-vec-la spd direction))
        (gravity (make-vec 0 gravity-y)))
    (make-particle-pv pos velocity gravity)))

(defun particle-update! (p)
  (vec-add! (particle-pos p)
            (particle-velocity p))
  (vec-add! (particle-velocity p)
            (particle-gravity p))
  )

(defun particle-x (p)
  (vec-x (particle-pos p)))

(defun particle-y (p)
  (vec-y (particle-pos p)))

(defun particle-accelerate! (p accel)
  (vec-add! (particle-velocity p) accel))
