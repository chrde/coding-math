(in-package #:coding-math)

(defsketch better-random ((width 800)
                          (height 800)
                          (red
                           (loop for x from 1 to 50
                                 collect
                                 (list (rand 0 (* width 0.33))
                                       (rand 0 height)
                                       (rand 10 40))))
                          (green
                           (loop for x from 1 to 50
                                 collect
                                 (list (rand (* width 0.33) (* width 0.66))
                                       (rand 0 height)
                                       (rand 10 40))))
                          (blue
                           (loop for x from 1 to 50
                                 collect
                                 (list (rand (* width 0.66) width)
                                       (rand 0 height)
                                       (rand 10 40)))))
  (with-pen (make-pen :fill +red+)
    (dolist (c red)
      (apply #'circle c)))
  (with-pen (make-pen :fill +green+)
    (dolist (c green)
      (apply #'circle c)))
  (with-pen (make-pen :fill +blue+)
    (dolist (c blue)
      (apply #'circle c))))

;; (make-instance 'better-random)
