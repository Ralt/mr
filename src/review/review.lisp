(in-package #:mr.review)


(defparameter +review.html+ (djula:compile-template* "review.html"))
(defparameter +diff-add.html+ (djula:compile-template* "diff-add.html"))

(defun get-one (id)
  (djula:render-template* +review.html+ nil :review (mr:with-db (get-one-review id))))

(defun add-diff-get (review-id)
  ;; Use mr.form:create to handle CSRF creation.
  (djula:render-template* +diff-add.html+))
