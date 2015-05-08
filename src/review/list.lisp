(in-package #:mr.review)


(defun list-reviews ()
  (mr:with-db
    (list-open-reviews)))
