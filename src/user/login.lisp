(in-package #:mr.user)


(defparameter +login.html+ (djula:compile-template* "login.html"))

(defun login ()
  (djula:render-template* +login.html+))

(defun login-user ()
  "Logs in a user since we now have his github access token."
  (mr:with-db
    (let* ((login (mr.github:user-login (h:session-value 'github-access-token)))
           (user-id (user-by-login login)))
      (unless (eq user-id 'null)
        (setf user-id (user-create login)))
      (setf (h:session-value 'id) user-id))))

(defun logout ()
  (h:remove-session h:*session*)
  (h:redirect "/user/login"))
