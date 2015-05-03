(in-package #:mr)


(defparameter +home.html+ (djula:compile-template* "home.html"))

(h:define-easy-handler (home :uri (method-path :get "/")) ()
  (multiple-value-bind (value present-p)
      (h:session-value 'mr.user:id)
    (declare (ignore value))
    (if present-p
        (djula:render-template* +home.html+)
        (h:redirect "/user/login"))))

(h:define-easy-handler (user-login-get :uri (method-path :get "/user/login")) ()
  (mr.user:login))

(h:define-easy-handler (user-login-github :uri (method-path :get "/user/login/github")) ()
  (mr.user:login-github))

(h:define-easy-handler (user-login-github-authorized
                        :uri (method-path :get "/user/login/github/authorized")) (code state)
  (mr.user:login-github-authorized code state))

(h:define-easy-handler (user-logout :uri (method-path :get "/user/logout")) ()
  (mr.user:logout))
