(in-package #:coding-math)

(defsketch postcards3d((width 800)
                       (height 800)
                       (focal-length 300)
                       (shapes (loop for x from 1 to 100
                                     collect (list (rand-int -1000 1000)
                                                   (rand-int -1000 1000)
                                                   (rand-int 1 100)))))
  (text (format nil "focal length: ~f" focal-length) 20 20)
  (translate (/ width 2) (/ height 2))
  (dolist (shape shapes)
    (destructuring-bind (x y z) shape
      (let ((persp (/ focal-length (* z focal-length))))
        (push-matrix)
        (translate (* persp x) (* persp y))
        (scale persp)
        (circle 0 0 40)
        (if (> z 100)
            (setf (third shape) 1)
          (incf (third shape) 1))
        (pop-matrix))))
  )

(defmethod kit.sdl2:mousewheel-event ((window postcards3d) ts x y)
  (with-slots (focal-length) window
    (incf focal-length (* 10 y))))

(make-instance 'postcards3d)
