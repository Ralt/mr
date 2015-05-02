(in-package #:mr.user)


(defparameter +login.html+ (djula:compile-template* "login.html"))

(defun login ()
  (djula:render-template* +login.html+))


(defun logout ()
  (h:remove-session)
  (h:redirect "/user/login"))
