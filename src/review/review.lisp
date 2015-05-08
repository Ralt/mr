(in-package #:mr.review)


(defparameter +review.html+ (djula:compile-template* "review.html"))

(defun get-one (id)
  (djula:render-template* +review.html+ nil :review (mr:with-db (get-one-review id))))
