(in-package #:coding-math)

;; episode 15
(defsketch spring1((width 800)
                   (height 800)
                   (k 0.1)
                   (color +green+)
                   (point (make-vec))
                   (spring (make-spring :pos (make-vec) :k 0.1))
                   (p (make-particle (/ width 2) (/ height 2) 0 0 :radius 20 :bounce 0 :friction 0.9))
                   )
  ;; sketch bug https://github.com/vydd/sketch/issues/33
  (unless (particle-springs p)
    (particle-spring-add p spring))
  (particle-update! p)
  (line (vec-x (spring-pos spring)) (vec-y (spring-pos spring)) (particle-x p) (particle-y p))
  (with-pen (make-pen :fill color)
    (circle (particle-x p) (particle-y p) 10)
    (circle (vec-x (spring-pos spring)) (vec-y (spring-pos spring)) 3))
  )

(defmethod kit.sdl2:mousemotion-event ((window spring1) ts mask x y xr yr)
  (with-slots (spring) window
    (setf
     (vec-x (spring-pos spring)) x
     (vec-y (spring-pos spring)) y)))
;; (defparameter *game* (make-instance 'spring1))

(defsketch spring2((width 800)
                   (height 800)
                   (color +green+)
                   (spring (make-spring :pos (make-vec) :k 0.1 :length 50.0))
                   (p (make-particle 400 400 0 0
                                     :gravity-y 0.4 :radius 20 :bounce 0 :friction 0.92))
                   )
  ;; sketch bug https://github.com/vydd/sketch/issues/33
  (unless (particle-springs p)
    (particle-spring-add p spring))
  (particle-update! p)
  (line (vec-x (spring-pos spring)) (vec-y (spring-pos spring)) (particle-x p) (particle-y p))
  (with-pen (make-pen :fill +green+)
    (circle (particle-x p) (particle-y p) 10)
    (circle (vec-x (spring-pos spring)) (vec-y (spring-pos spring)) 3)))

(defmethod kit.sdl2:mousemotion-event ((window spring2) ts mask x y xr yr)
  (with-slots (spring) window
    (setf
     (vec-x (spring-pos spring)) x
     (vec-y (spring-pos spring)) y)))
;; (defparameter *game* (make-instance 'spring2))

(defsketch spring3((width 800)
                   (height 800)
                   (k 0.1)
                   (color +green+)
                   (spring-length 100)
                   (p1 (make-particle (rand-int 0 800)
                                      (rand-int 0 800)
                                      (rand-int 0 50)
                                      (rand 0 (* pi 2))
                                      :radius 20 :friction 0.9))
                   (p2 (make-particle (rand-int 0 800)
                                      (rand-int 0 800)
                                      (rand-int 0 50)
                                      (rand 0 (* pi 2))
                                      :radius 20 :friction 0.9))
                   (p3 (make-particle (rand-int 0 800)
                                      (rand-int 0 800)
                                      (rand-int 0 50)
                                      (rand 0 (* pi 2))
                                      :radius 20 :friction 0.9)))
  (update3 *game*)
  (line (particle-x p1) (particle-y p1) (particle-x p2) (particle-y p2))
  (line (particle-x p1) (particle-y p1) (particle-x p3) (particle-y p3))
  (line (particle-x p3) (particle-y p3) (particle-x p2) (particle-y p2))
  (with-pen (make-pen :fill color)
    (circle (particle-x p1) (particle-y p1) (particle-radius p1))
    (circle (particle-x p2) (particle-y p2) (particle-radius p2))
    (circle (particle-x p3) (particle-y p3) (particle-radius p3))))

(defun bounce (p1 p2 spring-length k)
  (let ((distance (vec-sub (particle-pos p1) (particle-pos p2))))
    (decf (vec-len distance) spring-length)
    (let ((force (vec-mul distance k)))
      (particle-accelerate! p2 force)
      (particle-decelerate! p1 force)
      )))

(defun update3 (game)
  (with-slots (p1 p2 p3 spring-length k) game
    (bounce p1 p2 spring-length k)
    (bounce p1 p3 spring-length k)
    (bounce p2 p3 spring-length k)
    (particle-update! p1)
    (particle-update! p2)
    (particle-update! p3)
    (particle-screen-clamp! p1 800 800)
    (particle-screen-clamp! p2 800 800)
    (particle-screen-clamp! p3 800 800)
    ))

(defmethod kit.sdl2:mousemotion-event ((window spring3) ts mask x y xr yr)
  (with-slots (p1) window
    (setf
     (particle-x p1) x
     (particle-y p1) y)))
;; (defparameter *game* (make-instance 'spring3))

(defsketch spring4((width 800)
                   (height 800)
                   (color +green+)
                   (spring (make-spring :pos (make-vec) :k 0.1 :length 50.0))
                   (p (make-particle 400 400 0 0
                                     :gravity-y 0.4 :radius 20 :bounce 0 :friction 0.92))
                   )
  ;; sketch bug https://github.com/vydd/sketch/issues/33
  (text (format nil "~a" (length (particle-springs p))) 20 20)
  (unless (particle-springs p)
    (particle-spring-add p spring)
    (particle-spring-add p (make-spring :pos (make-vec 350 350) :k 0.5 :length 100.0)))
  (particle-update! p)
  (with-pen (make-pen :fill +green+)
    (dolist (spring (particle-springs p))
      (let ((spring (cdr spring)))
        (with-pen (make-pen :stroke +black+)
          (line (vec-x (spring-pos spring)) (vec-y (spring-pos spring)) (particle-x p) (particle-y p)))
        (circle (vec-x (spring-pos spring)) (vec-y (spring-pos spring)) 3)))
    (circle (particle-x p) (particle-y p) 10)))

(defmethod kit.sdl2:mousemotion-event ((window spring4) ts mask x y xr yr)
  (with-slots (spring) window
    (setf
     (vec-x (spring-pos spring)) x
     (vec-y (spring-pos spring)) y)))
;; (defparameter *game* (make-instance 'spring4))
