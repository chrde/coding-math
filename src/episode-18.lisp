(in-package #:coding-math)

(defun ep-18-generator ()
  (loop
    for i from 1 to 100
    collect
    (make-particle 0 0
                   (rand 7 8)
                   (+ (rand -0.1 0.1) (/ pi 2))
                   :radius 3)))

(defun ep-18-reset-particle (p)
  (let ((screen (make-rec-wh (make-vec) 800 800)))
    (unless (collides screen (particle-pos p))
      (setf (particle-x p) 0
            (particle-y p) 0
            (particle-speed p) (rand 7 8)
            (particle-heading p) (+ (rand -0.1 0.1) (/ pi 2))
            ))))

;; episode 18
(defsketch multi-gravity ((width 800)
                          (height 800)
                          (initialized)
                          (particles (ep-18-generator))
                          (p-pen (make-pen :fill +blue+))
                          (sun1 (make-particle 200 100 0 0 :mass 10000 :radius 10))
                          (sun2 (make-particle 450 600 0 0 :mass 20000 :radius 20)))
  ;; (text (format nil "mass: ~f, pos: ~A" (particle-mass sun2) (particle-pos sun2)) 200 20)
  (unless initialized
    (dolist (p particles)
      (particle-gravitation-add p sun1)
      (particle-gravitation-add p sun2)
      )
    (setf initialized t))
  (with-pen p-pen
    (dolist (p particles)
      (ep-18-reset-particle p)
      (particle-update! p)
      (draw-particle p)))
  (with-pen (make-pen :fill +red+)
    (draw-particle sun1))
  (with-pen (make-pen :fill +yellow+)
    (draw-particle sun2)))

;; (defmethod kit.sdl2:mousewheel-event ((window multi-gravity) ts x y)
;;   (with-slots (sun2) window
;;     (incf (particle-mass sun2) (* 50 y))))

;; (defmethod kit.sdl2:mousemotion-event ((window multi-gravity) ts mask x y xr yr)
;;   (with-slots (sun2) window
;;     (setf
;;      (particle-x sun2) x
;;      (particle-y sun2) y)))

;; (make-instance 'multi-gravity)
