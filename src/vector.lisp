(in-package #:coding-math)

(defstruct (vec (:print-object pprint-vec)
                (:constructor make-vec (&optional (x 0) (y 0))))
  x y)

(defun pprint-vec (v out)
  (format out "[~A ~A]" (vec-x v) (vec-y v)))


(defun make-vec-la (len angle)
  (let ((v (make-vec)))
    (setf (vec-len v) len
          (vec-angle v) angle)
    v))

(defun (setf vec-angle) (angle vec)
  (let ((len (vec-len vec)))
    (with-slots (x y) vec
      (setf  x (* len (cos angle)))
      (setf  y (* len (sin angle))))))

(defun vec-angle (vec)
  (with-slots (x y) vec
    (atan y x)))

(defun (setf vec-len) (len vec)
  (let ((angle (vec-angle vec)))
    (with-slots (x y) vec
      (setf  x (* len (cos angle)))
      (setf  y (* len (sin angle))))))

(defun vec-len (vec)
  (with-slots (x y) vec
    (sqrt (+ (* x x)
             (* y y)))))

;;TODO https://stackoverflow.com/questions/25152029/override-overload-the-operator-to-operate-on-common-lisp-vectors
(defun vec-add (v1 v2)
  (make-vec (+ (vec-x v1) (vec-x v2))
            (+ (vec-y v1) (vec-y v2))))

(defun vec-sub (v1 v2)
  (make-vec (- (vec-x v1) (vec-x v2))
            (- (vec-y v1) (vec-y v2))))

(defun vec-mul (v s)
  (make-vec (* (vec-x v) s)
            (* (vec-y v) s)))

(defun vec-div (v s)
  (make-vec (/ (vec-x v) s)
            (/ (vec-y v) s)))

(defun vec-add! (v1 v2)
  (incf (vec-x v1) (vec-x v2))
  (incf (vec-y v1) (vec-y v2)))

(defun vec-sub! (v1 v2)
  (decf (vec-x v1) (vec-x v2))
  (decf (vec-y v1) (vec-y v2)))

(defun vec-mul! (v s)
  (setf (vec-x v) (* (vec-x v) s)
        (vec-y v) (* (vec-y v) s)))

(defun vec-div! (v s)
  (setf (vec-x v) (/ (vec-x v) s)
        (vec-y v) (/ (vec-y v) s)))
;; end vec

