(in-package #:mr)


(h:define-easy-handler (home :uri (method-path :get "/")) ()
  "home")

(h:define-easy-handler (login-get :uri (method-path :get "/user/login")) ()
  (mr.user:login-get))

(h:define-easy-handler (login-post :uri (method-path :post "/user/login")) ()
  (mr.user:login-post))
