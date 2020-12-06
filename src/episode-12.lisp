(in-package #:coding-math)

(defun make-n-particles (n x y)
  (loop for i from 1 to n collect
        (let ((velocity (rand-velocity)))
          (make-particle x y
                         (vec-len velocity)
                         (vec-angle velocity)
                         0.1 0 (+ (random 15) 5)))))

(defun rand-velocity ()
  (make-vec-la (+ 5 (random 8))
               (+ (- (random 0.3) 0.15) (radians 270))))

(defsketch wrap-offscreen ((width 800)
                           (height 800)
                           (sun (make-particle
                                  (/ width 2) (/ height 2) 5 (radians 270) 0 0 50)))
  (particle-screen-wrap! sun width height)
  (particle-update! sun)
  (with-pen (make-pen :fill +yellow+)
            (circle (particle-x sun) (particle-y sun) (particle-radius sun))))

; (make-instance 'wrap-offscreen)

(defsketch fountain ((width 800)
                     (height 800)
                     (ps (make-n-particles 50 (/ width 2) height)))
  (dolist (p ps)
    (particle-update! p)
    (circle (particle-x p) (particle-y p) (particle-radius p))
    ;; detect when they leave on y axis
    (when (> (- (particle-y p) (particle-radius p)) height)
      (setf (particle-x p) (/ width 2)
            (particle-y p) height
            (particle-velocity p) (rand-velocity)))
    ))

; (make-instance 'fountain)

(defsketch bouncing ((width 800)
                     (height 800)
                     (p (make-particle (/ width 2) (/ height 2)
                                       5 (* (random 1) pi 2) 0.1)))
  (setf (particle-bounce p) -0.9)
  (particle-screen-bounce! p width height)
  (particle-update! p)
  (circle (particle-x p) (particle-y p) (particle-radius p)))

; (make-instance 'bouncing)
