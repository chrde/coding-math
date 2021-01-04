(in-package #:coding-math)

;; mini-9
(defsketch mini-chart-distribution ((width 800)
                                     (height 800)
                                     (pen (make-pen :fill +white+))
                                     (results (make-array 100))
                                     (max-value (length results))
                                     (visual-speed 100)
                                     (random-picks 2)
                                     (initialized))
  (unless initialized
    (loop for i from 1 to visual-speed
          do
             (let ((v (rand-distribution 0 max-value random-picks)))
               (incf (aref results v) 1)
               (when (>= (aref results v) max-value)
                 (setf initialized t)))))
  (draw-mini-chart-distribution *game*))

(defun draw-mini-chart-distribution (game)
  (push-matrix)
  (with-slots (width height max-value results) game
    (rotate 180 (/ width 2) (/ height 2))
    (let ((bar-w (/ width max-value))
          (bar-h (/ height max-value)))
      (loop for r across results
            for i from 0 to (length results)
            do (progn (rect (* bar-w i) 0 bar-w (* r bar-h))))))
  (pop-matrix))

;; (defmethod kit.sdl2:mousemotion-event ((window mini-clamp) ts mask x y xr yr)
;;   (with-slots (c r) window
;;     (setf
;;       (first c) (clamp x (first r) (+ (third r) (first r)))
;;       (second c) (clamp y (second r) (+ (fourth r) (second r)))
;;       )))

;; (defparameter *game* (make-instance 'mini-chart-distribution))

(defsketch mini-map-distribution ((width 800)
                                  (height 800)
                                  (results (loop for x from 1 to 1000 collect
                                                                      (make-vec (rand-distribution 0 800 2)
                                                                                (rand-distribution 0 800 2)))))
  (dolist (r results)
    (circle (vec-x r) (vec-y r) 5))
  )

;; (defparameter *game* (make-instance 'mini-map-distribution))
