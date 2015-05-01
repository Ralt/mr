(in-package #:mr)


(djula:add-template-directory (asdf:system-relative-pathname "mr" "templates/"))

(defparameter +base.html+ (djula:compile-template* "base.html"))
