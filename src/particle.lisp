(in-package #:coding-math)

(defstruct (particle
             ;; (:print-object (lambda (v out) (format out "[speed: ~A ]")))
             (:constructor make-particle-pv (pos velocity gravity mass radius bounce friction springs gravitations)))
  pos velocity gravity mass radius bounce friction springs gravitations)

(defstruct spring
  (pos (make-vec) :type vec)
  (k 0.0 :type single-float)
  (length 0.0 :type single-float))

(defun make-particle (x y spd direction &key
                                          (gravity-y 0)
                                          (mass 1)
                                          (radius 10)
                                          (bounce -1)
                                          (friction 1)
                                          (springs)
                                          (gravitations))
  (let* ((pos (make-vec x y))
         (velocity (make-vec-la spd direction))
         (gravity (make-vec 0 gravity-y)))
    (make-particle-pv pos velocity gravity mass radius bounce friction springs gravitations)))

(defun particle-update! (p)
  (dolist (spring (particle-springs p))
    (particle-spring-to p (cdr spring)))
  (dolist (grav (particle-gravitations p))
    (particle-gravitate-to p grav))
  (vec-mul! (particle-velocity p)
            (particle-friction p))
  (vec-add! (particle-velocity p)
            (particle-gravity p))
  (vec-add! (particle-pos p)
            (particle-velocity p))
  )

(defun particle-speed (p)
  (vec-len (particle-velocity p)))

(defun particle-gravitation-add (p g)
  (push g (particle-gravitations p)))

(defun particle-spring-add (p spring)
  (push (cons (spring-pos spring) spring) (particle-springs p)))

;; (defun particle-spring-remove (p spring-pos)
;;   (with-slots (springs) p
;;     (setf springs (remove spring-pos springs :test #'equalp :key 'car))))

(defun (setf particle-speed) (speed p)
  (with-slots (velocity) p
    (setf (vec-len velocity) speed)))

(defun particle-heading (p)
  (vec-angle (particle-velocity p)))

(defun (setf particle-heading) (heading p)
  (with-slots (velocity) p
    (setf (vec-angle velocity) heading)))

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

(defun particle-spring-to (p1 spring)
  (let ((distance (vec-sub (spring-pos spring) (particle-pos p1))))
    (decf (vec-len distance) (spring-length spring))
    (particle-accelerate! p1 (vec-mul distance (spring-k spring)))))

(defun (setf particle-x) (x p)
  (setf (vec-x (particle-pos p)) x))

(defun (setf particle-y) (y p)
  (setf (vec-y (particle-pos p)) y))

(defun particle-x (p)
  (vec-x (particle-pos p)))

(defun particle-y (p)
  (vec-y (particle-pos p)))

(defun particle-decelerate! (p accel)
  (vec-sub! (particle-velocity p) accel))

(defun particle-accelerate! (p accel)
  (vec-add! (particle-velocity p) accel))

(defun particle-stop! (p)
  (setf (vec-len (particle-velocity p)) 0))
