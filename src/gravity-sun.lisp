(in-package #:coding-math)

;; episode 11
(defsketch gravity-sun ((width 800)
                        (height 800)
                        (sun (make-particle
                              (/ width 2) (/ height 2) 0 0 :mass 40000))
                        (planet (make-particle
                                 (+ 200 (/ width 2)) (/ height 2) 10 (/ (- pi) 2))))
  (unless (particle-gravitations planet)
    (particle-gravitation-add planet sun))
  ;; (particle-gravitate-to planet sun)
  (particle-update! planet)
  (with-pen (make-pen :fill +yellow+)
    (circle (particle-x sun) (particle-y sun) 50))
  (with-pen (make-pen :fill +blue+)
    (circle (particle-x planet) (particle-y planet) 10))
  )

;; (make-instance 'gravity-sun)
