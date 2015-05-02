(in-package #:mr)


(defparameter +home.html+ (djula:compile-template* "home.html"))

(h:define-easy-handler (home :uri (method-path :get "/")) ()
  (multiple-value-bind (value present-p)
      (h:session-value 'github-access-token)
    (if present-p
        (djula:render-template* +home.html+)
        (h:redirect "/user/login"))))

(h:define-easy-handler (login-get :uri (method-path :get "/user/login")) ()
  (mr.user:login))

(h:define-easy-handler (login-github :uri (method-path :get "/user/login/github")) ()
  (mr.user:login-github))

(h:define-easy-handler (login-github-authorized
                        :uri (method-path :get "/user/login/github/authorized")) (state code)
  (mr.user:login-github-authorized state code))

(h:define-easy-handler (logout :uri (method-path :get "/user/logout")) ()
  (mr.user:logout))
