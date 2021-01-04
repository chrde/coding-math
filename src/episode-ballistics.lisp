(in-package #:coding-math)

(defsketch ballistics ((width 800)
                       (height 400)
                       (is-shooting nil)
                       (force-angle 0)
                       (gun '(:x 50 :y 400 :angle 0))
                       (target (make-circle (make-vec (rand-int 200 800) 400) (rand-int 20 50)))
                       (cannonball (make-particle (getf gun :x) (getf gun :y) 0 (getf gun :angle) :gravity-y 0.4 :radius 7)))
  (unless is-shooting
    (if
     (> force-angle (* 2 pi))
     (setf force-angle 0)
     (incf force-angle 0.1)))
  (text (format nil "angle: ~3$" (degrees (getf gun :angle))) 20 20)
  (text (format nil "x: ~,2f" (particle-x cannonball)) 20 40)
  (text (format nil "y: ~,2f" (particle-y cannonball)) 100 40)
  (text (format nil "can shoot: ~a" is-shooting) 20 60)
  (text (format nil "~,2f" (sin force-angle)) 20 80)
  (update-ball *game*)
  (check-collision *game*)
  (draw-ballistics *game*))

(defun check-collision (game)
  (with-slots (target cannonball) game
    (when (collides target
                    (make-circle
                     (make-vec (particle-x cannonball) (particle-y cannonball))
                     (particle-radius cannonball)))
      (text (format nil "collildes") 20 100)
      (setf target (make-circle (make-vec (rand-int 200 800) 400) (rand-int 20 50))))))

(defun draw-ballistics (game)
  (with-slots (is-shooting gun height force-angle cannonball target) game
    (let
        ((color (if is-shooting +red+ +blue+)))
      (with-pen (make-pen :fill color)
        (circle (getf gun :x) (getf gun :y) 24)
        (push-matrix)
        (translate (getf gun :x) (getf gun :y))
        (rotate (degrees (getf gun :angle)))
        (rect 0 -8 40 16)
        (pop-matrix))
      (push-matrix)
      (translate 5 (- height 55))
      (rect 0 0 10 50)
      (with-pen (make-pen :fill color)
        (push-matrix)
        (rotate 180 5 25)
        (rect 0 0 10 (map-to (sin force-angle) -1 1 0 50))
        (pop-matrix))
      (pop-matrix))
    (circle (circle-x target) (circle-y target) (circle-radius target))
    (circle (particle-x cannonball) (particle-y cannonball) (particle-radius cannonball))))

(defun shoot (game)
  (with-slots (cannonball is-shooting gun force-angle) game
    (unless is-shooting
        (progn
          (setf (particle-x cannonball) (+ (getf gun :x) (* 40 (cos (getf gun :angle)))))
          (setf (particle-y cannonball) (+ (getf gun :y) (* 40 (sin (getf gun :angle)))))
          (setf (particle-speed cannonball) (map-to (sin force-angle) -1 1 2 20))
          (setf (particle-heading cannonball) (getf gun :angle))
          (setf is-shooting t)
          ))))

(defun update-ball (game)
  (with-slots (is-shooting cannonball height width) game
    (if (or (> (particle-y cannonball) height)
            (> (particle-x cannonball) width))
        (setf is-shooting nil)
        (particle-update! cannonball))))

(defmethod kit.sdl2:mousebutton-event ((game ballistics) state ts button x y)
  (with-slots (is-shooting) game
    (when (eq state :mousebuttondown)
      (shoot game))
    ))

(defmethod kit.sdl2:mousemotion-event ((game ballistics) ts mask x y xr yr)
  (with-slots (r is-shooting gun) game
    (unless is-shooting
      (let ((new-angle (atan (- y (getf gun :y))
                             (- x (getf gun :x)))))
        (setf (getf gun :angle) (clamp new-angle (radians -80) (radians -25))))
      )))

;; (defmethod kit.sdl2:keyboard-event ((game ballistics) state timestamp repeatp keysym)
;;   (declare (ignorable timestamp repeatp))
;;   (with-slots (is-shooting) game
;;     (when (eql state :keyup)
;;       (let ((key (sdl2:scancode-value keysym)))
;;         (cond
;;           ((sdl2:scancode= key :scancode-up)
;;            (when is-shooting
;;              (shoot game))))
;;         ))))

;; (defparameter *game* (make-instance 'ballistics))
