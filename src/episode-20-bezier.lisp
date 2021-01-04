(in-package #:coding-math)

(defun make-points (n &optional (width 800) (height 800)) 
  (loop for x from 1 to n
        collect (list :circle (make-circle
                                (make-vec (rand-int 0 width) (rand-int 0 height))
                                3)
                      :color +white+
                      :selected nil)))

(defun connect-points ()
  (loop for (p0 p1) on *points* while p1
        do (draw-line (circle-center (getf p0 :circle)) (circle-center (getf p1 :circle)))))

(defun draw-points (game)
  (with-slots (curve-points pen-selected pen-default pen-curve) game
    (dolist (p *points*)
      (let ((pos (circle-center (getf p :circle)))
            (pen (if (getf p :selected)
                     pen-selected
                   pen-default)))
        (with-pen pen
                  (circle (vec-x pos) (vec-y pos) 5))))
    (dolist (p curve-points)
      (with-pen pen-curve
                (circle (vec-x p) (vec-y p) 3)))))

(defun refine-points (curve-points)
  (let ((result '())
        (ps (mapcar #'(lambda (p) (circle-center (getf p :circle))) curve-points)))
    (push (first ps) result)
    (loop for (p0 p1 p2) on (rest ps) while p1
          do (let ((middle-p (vec-div (vec-add p0 p1) 2)))
               (push p0 result)
               (push middle-p result)))
    (pop result)
    (push (car (last ps)) result)
    (nreverse result)))

(defun draw-lerps (curve-points n)
  (let ((skip nil))
    (loop for (p0 p1 p2) on curve-points while p2
          do (if skip
                 (setf skip nil)
               (progn
                 (draw-curve-between p0 p1 p2 n)
                 (setf skip t))))))

(defun draw-curve-between (p0 p1 p2 norm)
  (let ((p (quadratic-bezier-xy p0 p1 p2 norm)))
    (circle (vec-x p) (vec-y p) 2)
    ))

(defsketch more-bezier ((width 800)
                        (height 800)
                        (curve-points)
                        (pen-selected (make-pen :fill +red+))
                        (pen-default (make-pen :fill +white+))
                        (pen-curve (make-pen :fill +blue+))
                        (updating nil)
                        (initialized nil)
                        (norm 100.0))
  (unless initialized
    (setf curve-points (refine-points *points*))
    (setf initialized t))
  (text (format nil "Press <Enter> to restart.") 20 20)
  (with-pen (make-pen :fill +green+)
            (dotimes (n (floor norm))
              (draw-lerps curve-points (/ n 100.0))))
  (connect-points)
  (draw-points *game*)
  )

(defmethod kit.sdl2:mousemotion-event ((window more-bezier) ts mask x y xr yr)
  (with-slots (updating curve-points) window
    (unless updating
      (let ((mouse (make-circle (make-vec x y) 3)))
        (dolist (p *points*)
          (setf (getf p :selected) (collides (getf p :circle) mouse)))))
    (when updating
      (let ((new-pos (make-vec x y)))
        (dolist (p *points*)
          (when (getf p :selected)
            (setf (circle-center (getf p :circle)) new-pos)
            (setf curve-points (refine-points *points*))))))))

(defmethod kit.sdl2:mousebutton-event ((game more-bezier) state ts button x y)
  (with-slots (updating) game
    (setf updating (eq state :mousebuttondown))))

(defmethod kit.sdl2:keyboard-event ((game more-bezier) state timestamp repeatp keysym)
  (declare (ignorable timestamp repeatp))
  (with-slots (initialized) game
    (when (sdl2:scancode= (sdl2:scancode-value keysym) :scancode-return)
      (setf *points* (make-points 6)
            initialized nil))))

;; (defparameter *points* (make-points 6))
;; (defparameter *game* (make-instance 'more-bezier))
