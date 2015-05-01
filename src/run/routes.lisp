(in-package #:mr)


(defparameter +home.html+ (djula:compile-template* "home.html"))

(h:define-easy-handler (home :uri (method-path :get "/")) ()
  (djula:render-template* +home.html+))

(h:define-easy-handler (login-get :uri (method-path :get "/user/login")) ()
  (mr.user:login))

(h:define-easy-handler (login-github :uri (method-path :get "/user/login/github")) ()
  (mr.user:login-github))
