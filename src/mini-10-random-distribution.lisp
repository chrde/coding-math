(in-package #:coding-math)

;; mini-10
(defsketch random-square-centered ((width 800)
                                   (height 800)
                                   (result (loop for i from 1 to 2000
                                                 collect (make-circle (make-vec (rand-int 50 750)
                                                                                (rand-int 50 750))
                                                                      2)))
                                   )
  (dolist (c result)
    (circle (circle-x c) (circle-y c) (circle-radius c))))
;; (make-instance 'random-square-centered)

(defsketch random-circle-centered ((width 800)
                                   (height 800)
                                   (result (loop for i from 1 to 2000
                                                 collect (let ((radius (rand 0 350))
                                                               (angle (rand 0 (* pi 2))))
                                                           (make-circle (make-vec (+ 400 (* (cos angle) radius))
                                                                                  (+ 400 (* (sin angle) radius)))
                                                                        2)))))
  (dolist (c result)
    (circle (circle-x c) (circle-y c) (circle-radius c))))
;; (make-instance 'random-circle-centered)

(defsketch evenly-circle-centered ((width 800)
                                   (height 800)
                                   (result (loop for i from 1 to 2000
                                                 collect (let ((radius (* (sqrt (rand)) 350))
                                                               (angle (rand 0 (* pi 2))))
                                                           (make-circle (make-vec (+ 400 (* (cos angle) radius))
                                                                                  (+ 400 (* (sin angle) radius)))
                                                                        2)))))
  (dolist (c result)
    (circle (circle-x c) (circle-y c) (circle-radius c))))
;; (make-instance 'evenly-circle-centered)


(defsketch random-ellipsis-centered ((width 800)
                                     (height 800)
                                     (result (loop for i from 1 to 2000
                                                   collect (let (
                                                                 (x-radius (rand 0 350))
                                                                 (y-radius (rand 0 200))
                                                                 (angle (rand 0 (* pi 2)))
                                                                 )
                                                             (make-circle (make-vec (+ 400 (* (cos angle) x-radius))
                                                                                    (+ 400 (* (sin angle) y-radius)))
                                                                          2)))))
  (dolist (c result)
    (circle (circle-x c) (circle-y c) (circle-radius c))))
;; (make-instance 'random-ellipsis-centered)

(defsketch random-square-explosion ((width 800)
                                    (height 800)
                                    (result (loop for i from 1 to 200
                                                  collect (let ((velocity (make-vec (rand -1 1)
                                                                                    (rand -1 1)))
                                                                (particle (make-particle 400 400 0 0)))
                                                            (setf (particle-velocity particle) velocity)
                                                            particle))))
  (dolist (c result)
    (particle-update! c)
    (circle (particle-x c) (particle-y c) 3)))
;; (make-instance 'random-square-explosion)

(defsketch random-circle-explosion ((width 800)
                                    (height 800)
                                    (result (loop for i from 1 to 200
                                                  collect (let ((particle (make-particle 400 400 0 0)))
                                                            (setf (particle-speed particle) (rand -1 1)
                                                                  (particle-heading particle) (rand 0 (* pi 2)))
                                                            particle))))
  (dolist (c result)
    (particle-update! c)
    (circle (particle-x c) (particle-y c) 3)))
;; (make-instance 'random-circle-explosion)
