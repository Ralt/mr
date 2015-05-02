(in-package #:mr.user)


(defparameter +login.html+ (djula:compile-template* "login.html"))

(defun login ()
  (djula:render-template* +login.html+))

(defun login-user ()
  "Logs in a user since we now have his github access token."
  (mr:with-db
    (let* ((name (mr.github:user-full-name (h:session-value 'github-access-token)))
           (user-id (user name)))
      (unless user-id
        (user-create name)
        (setf user-id (user name)))
      (setf (h:session-value 'id) user-id))))

(defun logout ()
  (h:remove-session)
  (h:redirect "/user/login"))
