(in-package #:coding-math)

(defgeneric collides (obj1 obj2)
  (:documentation "Detect collision between two objects"))

(defmethod collides ((obj1 circle) (obj2 circle))
  (< (distance (circle-center obj1) (circle-center obj2))
      (+ (circle-radius obj1) (circle-radius obj2))))

(defmethod collides ((obj1 circle) (obj2 vec))
  (< (distance (circle-center obj1) obj2)
      (circle-radius obj1)))

(defmethod collides ((r rec) (p vec))
  (and (in-range-p (vec-x p) (rec-min-x r) (+ (rec-min-x r) (rec-width r)))
       (in-range-p (vec-y p) (rec-min-y r) (+ (rec-min-y r) (rec-height r)))))

(defmethod collides ((r1 rec) (r2 rec))
  (and
   (and (<= (rec-min-x r1) (rec-max-x r2))
        (<= (rec-min-x r2) (rec-max-x r1)))
   (and (<= (rec-min-y r1) (rec-max-y r2))
        (<= (rec-min-y r2) (rec-max-y r1)))))

(random 5)
